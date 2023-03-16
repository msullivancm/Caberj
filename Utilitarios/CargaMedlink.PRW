#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CARGAMEDLINKºAutor  ³Leonardo Portella   º Data ³  27/07/11 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para gerar arquivo com procedimentos, beneficiarios, º±±
±±º          ³prestadores e despesas, zipar este arquivo, fazer o Upload  º±±
±±º          ³no FTP da Medlink e enviar um e-mail de confirmacao. Pode   º±±
±±º          ³ser utilizado manualmente ou atraves de Schedule.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

******************************************************************************************************

Static lAutentEmail := .F.

//Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s 
//Static cPath		:= "\\srvdbp\backup\utl\" //Onde a Procedure gera o arquivo de carga   
Static cPath		:= "\\"+AllTrim(GetMv("MV_XSRVBD"))+"\backup\utl\" //Onde a Procedure gera o arquivo de carga   
	
//Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s
//Static cWinRar 	:= "\\srvap01n\Protheus10\Protheus_Data\WinRAR\WinRAR.exe" //"\\Srvterm2\Desenv$\ToolsFree\WinRar\WinRar.exe"
//Static cWinRar	:= "\\10.19.1.8\Protheus_Data\WinRAR\WinRAR.exe"
Static cWinRar 		:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\P12\Protheus_Data\WinRAR\WinRAR.exe"

******************************************************************************************************

User Function CargaMedlink(aSchedule)

Default aSchedule 	:= {}

Private cDataHora	:= "'MEDLINK - ' + DtoC(Date()) + ' ' + Time()"
Private cQuery 		:= ""
Private cNomeArq	:= "MEDLINK_CARGA_GrupoCaberj_" + DtoS(Date()) + ".txt" //Nome que a Procedure gera para o arquivo de carga
Private cArq		:= cPath + cNomeArq 
Private cArqTmp		:= "\\srvdbp\backup\" + cNomeArq   // motta 19/5/14 alteracao do diretorio
Private cErro		:= "" 
Private cArqDest 	:= cPath + left(cNomeArq,len(cNomeArq) - 4) + ".zip"
Private lSchedule	:= If(empty(aSchedule),.F.,aSchedule[1][1])  

nFTP := 2//Medlink

If lSchedule
	QOut(&cDataHora + ' - Preparando ambiente')   

	//Na query da procedure considera a Caberj e a Integral
	PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
	
	execCarga(lSchedule)
Else
	
	Private lConfirmou := .F.
	Private dReferenci := MsDate()
	Private lEPC       := .F.
	Private lGVD       := .F.
	Private lOUD       := .F.
	Private lPDM       := .F.
	Private lPES       := .F.
	Private lPRS       := .F.
	Private lUEN       := .F.
	Private lUSU       := .F.
	
	SetPrvt("oDlg1","oGrp1","oSay1","oGet1","oGrp2","oCBox1","oCBox2","oCBox3","oCBox4","oCBox5","oCBox6")
	SetPrvt("oCBox8","oSBtn1","oSBtn2")
	
	oDlg1      := MSDialog():New( 092,232,478,519,"Parâmetros da carga Medlink",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 008,008,148,128,"Parâmetros da carga",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 024,012,{||"Data de referência"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
	oGet1      := TGet():New( 020,060,{|u| If(PCount()>0,dReferenci:=u,dReferenci)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dReferenci",,)
	oGrp2      := TGroup():New( 044,016,136,120,"Tipos de carga",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oCBox1     := TCheckBox():New( 052,016,"EPC",{|u| If(PCount()>0,lEPC:=u,lEPC)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox2     := TCheckBox():New( 064,016,"GVD",{|u| If(PCount()>0,lGVD:=u,lGVD)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox3     := TCheckBox():New( 076,016,"OUD",{|u| If(PCount()>0,lOUD:=u,lOUD)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox4     := TCheckBox():New( 088,016,"PDM",{|u| If(PCount()>0,lPDM:=u,lPDM)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox5     := TCheckBox():New( 100,016,"PES",{|u| If(PCount()>0,lPES:=u,lPES)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox6     := TCheckBox():New( 112,016,"PRS",{|u| If(PCount()>0,lPRS:=u,lPRS)},oGrp2,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox7     := TCheckBox():New( 052,064,"UEN",{|u| If(PCount()>0,lUEN:=u,lUEN)},oGrp2,036,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox8     := TCheckBox():New( 064,064,"USU",{|u| If(PCount()>0,lUSU:=u,lUSU)},oGrp2,032,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oSBtn1     := SButton():New( 156,068,1,{||lConfirmou := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     := SButton():New( 156,104,2,{||lConfirmou := .F.,oDlg1:End()},oDlg1,,"", )
	
	oDlg1:Activate(,,,.T.)

	If lConfirmou
		Processa({||execCarga(lSchedule)},'Processando...')
	EndIf
	
EndIf

Return
        
*************************************************************************************************************************

Static Function execCarga(lSchedule)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBrowse
Local Inicio := Time()
   
If !lSchedule
	ProcRegua(0)
	
	For i:= 1 to 5                                 
		Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando carga MEDLINK e OPERATIVA...')
	Next
EndIf

QOut('OPERATIVA - ' + DtoC(Date()) + ' ' + Time() + ' Iniciando carga em paralelo com carga MEDLINK [ U_exCarOper ] - [ ' + AllTrim(Upper(GetEnvServer())) + ' ]')

//Inicializa as variaveis
PutGlbValue('ThreadOperativa', "INICIADO" )
GlbUnLock()

PutGlbValue('TOperativaStatus', " " )
GlbUnLock()

//Carga dos outros projetos - Visita, Auditoria, etc
//Paralelismo
StartJob('U_exCarOper', AllTrim(Upper(GetEnvServer())), .F., cEmpAnt,lSchedule)//StartJob( cADVPLFun , cEnvironment , lWaitRun , < [param1, …paramN] > )
           
QOut('MEDLINK - ' + DtoC(Date()) + ' ' + Time() + ' Iniciando carga em paralelo com carga OPERATIVA [ U_exCarMed ] - [ ' + AllTrim(Upper(GetEnvServer())) + ' ]')

//Inicializa as variaveis
PutGlbValue('ThreadMedlink', "INICIADO" )
GlbUnLock()

PutGlbValue('TMedlinkStatus', " " )
GlbUnLock()

//Carga Medlink de procedimentos, beneficiarios, RDAs e guias verdes
//Paralelismo
StartJob('U_exCarMed', AllTrim(Upper(GetEnvServer())), .F., cEmpAnt,lSchedule)//StartJob( cADVPLFun , cEnvironment , lWaitRun , < [param1, …paramN] > )

If !lSchedule

	Private oOK   			:= LoadBitmap(GetResources(),'br_verde'		)
	Private oErro  			:= LoadBitmap(GetResources(),'br_vermelho'	)
	Private oProcessando   	:= LoadBitmap(GetResources(),'br_azul'		)

  	DEFINE DIALOG oDlg TITLE 'Carga Medlink e Operativa' FROM 0,0 TO 370,930 PIXEL
	                 
	    //Cria Browse
	    oBrowse := TCBrowse():New( 15 , 10, 450, 155,,;
	                              {'','Thread ','Status','Obs'},{20,50,50,100},;
	                              oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )

   		lStatusProc(@oBrowse, Inicio)

   		oBrowse:nScrollType := 1 // Scroll VCR

	    //Atualização de 10 em 10 segundos do status do processamento....    
		oTimer 	:= TTimer():New( 10000 ,{||If(lStatusProc(oBrowse, Inicio),(GetDRefresh(),MsgInfo('Carga finalizada...'),oDlg:End()),)},oDlg)	
		oTimer:Activate()      
		
		bFinalizou 	:= {||If(lStatusProc(@oBrowse, Inicio),oDlg:End(),Alert('Ainda existem Threads em execução. Por favor aguarde...'))}
			
  	ACTIVATE DIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,bFinalizou,bFinalizou,,)
	
EndIf

Return

***********************************************************************************************************************

Static Function lStatusProc(oBrowse, Inicio)

Local ThreadMed := GetGlbValue('ThreadMedlink')
Local StatusMed	:= GetGlbValue('TMedlinkStatus')
Local ThreadOp 	:= GetGlbValue('ThreadOperativa')
Local StatusOp	:= GetGlbValue('TOperativaStatus')
Local lTerminou := ( (ThreadMed <> 'INICIADO') .and. (ThreadOp <> 'INICIADO') )
Local aNewArray	:= {{ThreadMed,'Medlink',StatusMed},{ThreadOp,'Operativa',StatusOp}}

oBrowse:SetArray(aNewArray)
oBrowse:bLine 	:= &(cLineThread())//Apos Setar o Array, estava limpando o bLine
oBrowse:GoBottom()
oBrowse:GoTop()
oBrowse:DrawSelect() 

Return lTerminou 

***********************************************************************************************************************

Static Function cLineThread

Local 	cRet := "{||{ If(oBrowse:aArray[oBrowse:nAt,01] == 'FINALIZADO',oOK,(If(oBrowse:aArray[oBrowse:nAt,01] == 'ERRO',oErro,oProcessando))),"
		cRet += "             oBrowse:aArray[oBrowse:nAt,02],"
		cRet += "             oBrowse:aArray[oBrowse:nAt,01],"
		cRet += "             oBrowse:aArray[oBrowse:nAt,03] } }"
		
Return cRet

***********************************************************************************************************************

User Function exCarMed(cEmp,lSchedule,aParamProc)

Private lOk 		:= .T.
Private cErro 		:= " "

RpcSetType(3)//Nao consome licencas

RpcSetEnv(cEmp,,,,'PLS')

Private cDataHora	:= "'MEDLINK - ' + DtoC(Date()) + ' ' + Time()"

QOut(&cDataHora + ' - ThreadMedlink [ ' + GetGlbValue('ThreadMedlink') + ' ]')

Private cNomeArq	:= "MEDLINK_CARGA_GrupoCaberj_" + DtoS(Date()) + ".txt" //Nome que a Procedure gera para o arquivo de carga
Private cArq		:= cPath + cNomeArq 
Private cArqTmp		:= "\\srvdbp\backup\" + cNomeArq  // motta 19/5/14 alteracao do diretorio
Private cArqDest 	:= cPath + left(cNomeArq,len(cNomeArq) - 4) + ".zip"
Private nFTP 		:= 2//Medlink

QOut(&cDataHora + ' - Iniciando carga')   

PutGlbValue('TMedlinkStatus',&cDataHora + ' - Iniciando carga')
GlbUnLock()
/*          
cQuery := 'BEGIN '				
cQuery += 'GERA_ARQUIVOS_MEDLINK(); '
cQuery += 'END; '
*/

If !lSchedule

	cTipos := If(lEPC,'EPC','') + '|'
	cTipos += If(lGVD,'GVD','') + '|'
	cTipos += If(lOUD,'OUD','') + '|'
	cTipos += If(lPDM,'PDM','') + '|'
	cTipos += If(lPES,'PES','') + '|'
	cTipos += If(lPRS,'PRS','') + '|'
	cTipos += If(lUEN,'UEN','') + '|'
	cTipos += If(lUSU,'USU','') + '|'
	
	cQuery := 'DECLARE ' 
	cQuery := "DATA_REFERENCIA DATE := TO_DATE(" + DtoS(dReferenci) + ",'YYYYMMDD'); "
	cQuery := 'BEGIN '
	
	//GERA_TABELA_MEDLINK_TISS(DATA_REFERENCIA IN DATE DEFAULT SYSDATE, ID_MEDLINK_GERAR IN VARCHAR2 DEFAULT NULL)
	cQuery := 'GERA_TABELA_MEDLINK(DATA_REFERENCIA' + If(!empty(Replace(cTipos,'|','')),',' + cTipos,'') + '); '
	
	//GERA_ARQUIVOS_MEDLINK_TISS(DATA_REFERENCIA IN DATE DEFAULT SYSDATE, P_VERSAO_TISS IN VARCHAR2 DEFAULT NULL)
	cQuery := "GERA_ARQUIVOS_MEDLINK_TISS(DATA_REFERENCIA,'2.02.03'); "
	
	cQuery := "END;"
Else
	cQuery := 'DECLARE ' 
	cQuery := 'DATA_REFERENCIA DATE := SYSDATE; '
	cQuery := 'BEGIN '
	
	//GERA_TABELA_MEDLINK_TISS(DATA_REFERENCIA IN DATE DEFAULT SYSDATE, ID_MEDLINK_GERAR IN VARCHAR2 DEFAULT NULL)
	cQuery := 'GERA_TABELA_MEDLINK(DATA_REFERENCIA); '
	
	//GERA_ARQUIVOS_MEDLINK_TISS(DATA_REFERENCIA IN DATE DEFAULT SYSDATE, P_VERSAO_TISS IN VARCHAR2 DEFAULT NULL)
	cQuery := "GERA_ARQUIVOS_MEDLINK_TISS(DATA_REFERENCIA,'2.02.03'); "
	
	cQuery := "END;"
EndIf					

QOut(&cDataHora + ' - Executando procedure...') 

PutGlbValue('TMedlinkStatus',&cDataHora + ' - Executando procedure...')
GlbUnLock()

If TcSqlExec(cQuery) <> 0
	
	cErro := &cDataHora + " - Erro na execução da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	QOut(cErro) 
	lOk := .F.
	
	PutGlbValue('TMedlinkStatus',cErro)
	GlbUnLock()

EndIf

QOut(&cDataHora + ' - Fim procedure...')

If lOk
    
	If !File(cArq)
		lOk := .F.
		cErro := &cDataHora + " - Arquivo de carga Medlink (" + cArq + ") não foi encontrado!"
		QOut(cErro)    
		
		PutGlbValue('TMedlinkStatus',cErro)
		GlbUnLock()
	Else                                                       
		QOut(&cDataHora + " - Movendo o arquivo " + cArq + " para " + cArqTmp)

		PutGlbValue('TMedlinkStatus',&cDataHora + " - Movendo o arquivo " + cArq + " para " + cArqTmp)
		GlbUnLock()
		
		If !MoveFile(cArq,cArqTmp,.F.)
			lOk := .F.
			cErro := &cDataHora + " - Não foi possível copiar o arquivo: " + cArq + " para " + cArqTmp + "!"
			QOut(cErro)

			PutGlbValue('TMedlinkStatus',cErro)
			GlbUnLock()
		EndIf
		
		If lOk
			QOut(&cDataHora + ' - Compactando arquivo...')
			
			PutGlbValue('TMedlinkStatus',&cDataHora + ' - Compactando arquivo...')
			GlbUnLock()			         
			/*
			If !File(cWinRar)
				lOk := .F.
				cErro := &cDataHora + " - Programa compactador WinRar não encontrado no caminho " + cWinRar + "!"
				QOut(cErro)

				PutGlbValue('TMedlinkStatus',cErro)
				GlbUnLock()
			Else
			*/
				/*
				WaitRunSrv( cCommandLine , lWaitRun , cPath ) : lSuccess 
				cCommandLine : Instrucao a ser executada
				lWaitRun     : Se deve aguardar o termino da Execução
				Path         : Onde, no server, a funcao devera ser executada
				Retorna      : .T. Se conseguiu executar o Comando, caso contrario, .F.
				*/
				
				//Compacta o arquivo e cria o compactado na pasta cArqDest
				
				//Leonardo Portella - 29/11/13 - Inicio - Virada P11
				
				//lResWait := WaitRunSrv( cWinRar + ' a "' + cArqDest + '" "' + cArqTmp + '"' , .T. , "\\Srvap01n\Protheus10\" )
				//lResWait := WaitRunSrv( cWinRar + ' a "' + cArqDest + '" "' + cArqTmp + '"' , .T. , "\\10.19.1.8\Protheus_Data\" )
				
				//Leonardo Portella - 29/11/13 - Fim
				
				If lResWait
					QOut(&cDataHora + " - Resultado WaitRunSrv: Realizado com sucesso!")

					PutGlbValue('TMedlinkStatus',&cDataHora + " - Resultado WaitRunSrv: Realizado com sucesso!")
					GlbUnLock()
				Else
					lOk := .F.
					cErro := &cDataHora + " - Resultado WaitRunSrv: Erro na execução da compactação..."
					QOut(cErro)

					PutGlbValue('TMedlinkStatus',cErro)
					GlbUnLock()
				EndIf
				
				FErase(cArqTmp)   
				
				If lOk .and. !File(cArqDest) 
					lOk := .F.
					cErro := &cDataHora + " - Arquivo de carga Medlink COMPACTADO (" + cArqDest + ") não foi encontrado!"
					QOut(cErro)
					
					PutGlbValue('TMedlinkStatus',cErro)
					GlbUnLock()
				ElseIf lOk 

					QOut(&cDataHora + " - Início do Upload Medlink.")    
					
					PutGlbValue('TMedlinkStatus',&cDataHora + " - Início do Upload Medlink.")
					GlbUnLock()
					
					aRet := UploadFTP(cArqDest)
					
					If !aRet[1]
						lOk		:= .F.
						cErro 	:= &cDataHora + " - " + aRet[2]
						QOut(cErro) 
						
						PutGlbValue('TMedlinkStatus',cErro)
						GlbUnLock()
					Else
						FErase(cArqDest)
						QOut(&cDataHora + " - Término do Upload Medlink.")      
						
						PutGlbValue('TMedlinkStatus',&cDataHora + " - Término do Upload Medlink.")
						GlbUnLock()
					EndIf
					
				EndIf
			EndIf
		EndIf
			    
	EndIf
	
//EndIf
    
aMail := EnviaMail(lOk,cErro,'Medlink',lSchedule)

If !aMail[1]
	QOut(&cDataHora + " - Erro ao enviar o e-mail de confirmação carga Medlink : " + aMail[2])

	PutGlbValue('TMedlinkStatus',&cDataHora + " - Erro ao enviar o e-mail de confirmação carga Medlink : " + aMail[2])
	GlbUnLock()
Else  
	QOut(&cDataHora + " - E-mail de confirmação carga Medlink enviado.")    
	
	PutGlbValue('TMedlinkStatus',&cDataHora + " - E-mail de confirmação carga Medlink enviado.")
	GlbUnLock()
EndIf  
       
cMsg := &cDataHora + If(lOk,' - Carga Medlink efetuada com sucesso!',' - Ocorreram erros na carga Medlink...' + CRLF + CRLF + cErro)  

QOut(cMsg)

PutGlbValue('TMedlinkStatus',cMsg)
GlbUnLock()

If lOk
	PutGlbValue('ThreadMedlink', "FINALIZADO" )
	GlbUnLock()   
Else
	PutGlbValue('ThreadMedlink', "ERRO" )
	GlbUnLock()   
EndIf

QOut(&cDataHora + ' - ThreadMedlink [ ' + GetGlbValue('ThreadMedlink') + ' ]')

Return

***********************************************************************************************************************

User Function exCarOper(cEmp,lSchedule)

Private lOk 		:= .T.
Private cErro 		:= " "

RpcSetType(3)//Nao consome licencas

RpcSetEnv(cEmp,,,,'PLS')

Private cDataHora	:= "'OPERATIVA - ' + DtoC(Date()) + ' ' + Time()"

QOut(&cDataHora + ' - ThreadOperativa [ ' + GetGlbValue('ThreadOperativa') + ' ]')

Private cNomeArq	:= "OPERATIVA_CARGA_GrupoCaberj_" + DtoS(Date()) + ".txt" //Nome que a Procedure gera para o arquivo de carga
Private cArq		:= cPath + cNomeArq 
Private cArqTmp		:= "\\srvdbp\backup\" + cNomeArq  // motta 19/5/14  lteracao do diretorio
Private cArqDest 	:= cPath + left(cNomeArq,len(cNomeArq) - 4) + ".zip"
Private nFTP 		:= 1 //Operativa - Ricardo Azevedo em ferias da Aline, a carga OPERATIVA tambem sera feita no FTP Caberj - e-mail Em 08/02/2013 14:43  

QOut(&cDataHora + ' - Iniciando carga')   

PutGlbValue('TOperativaStatus',&cDataHora + ' - Iniciando carga')
GlbUnLock()
          
cQuery := 'DECLARE ' 	
cQuery += 'PSAIDA  VARCHAR2(255); ' 
cQuery += 'BEGIN '				
cQuery += 'GERA_ARQUIVOS_OPERATIVA(PSAIDA); '
cQuery += 'END; '						

QOut(&cDataHora + ' - Executando procedure...')   

PutGlbValue('TOperativaStatus',&cDataHora + ' - Executando procedure...')
GlbUnLock()

If TcSqlExec(cQuery) <> 0
	
	cErro := &cDataHora + " - Erro na execução da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	QOut(cErro) 
	lOk := .F. 
	
	PutGlbValue('TOperativaStatus',cErro)
	GlbUnLock()

EndIf

QOut(&cDataHora + ' - Fim procedure...')   

PutGlbValue('TOperativaStatus',&cDataHora + ' - Fim procedure...')
GlbUnLock()

If lOk
    
	If !File(cArq)
		lOk := .F.
		cErro := &cDataHora + " - Arquivo de carga Operativa (" + cArq + ") não foi encontrado!"
		QOut(cErro)   
		
		PutGlbValue('TOperativaStatus',cErro)
		GlbUnLock()
	Else                                                       
		QOut(&cDataHora + " - Movendo o arquivo " + cArq + " para " + cArqTmp)
		 
		PutGlbValue('TOperativaStatus',&cDataHora + " - Movendo o arquivo " + cArq + " para " + cArqTmp)
		GlbUnLock()

		If !MoveFile(cArq,cArqTmp,.F.)
			lOk := .F.
			cErro := &cDataHora + " - Não foi possível copiar o arquivo: " + cArq + " para " + cArqTmp + "!"
			QOut(cErro)
			
			PutGlbValue('TOperativaStatus',cErro)
			GlbUnLock()
		EndIf
		
		If lOk
			
			QOut(&cDataHora + ' - Compactando arquivo...')

			PutGlbValue('TOperativaStatus',&cDataHora + ' - Compactando arquivo...')
			GlbUnLock()
			         
			If !File(cWinRar)
				lOk := .F.
				cErro := &cDataHora + " - Programa compactador WinRar não encontrado no caminho " + cWinRar + "!"
				QOut(cErro)

				PutGlbValue('TOperativaStatus',cErro)
				GlbUnLock()
			Else
				
				/*
				WaitRunSrv( cCommandLine , lWaitRun , cPath ) : lSuccess 
				cCommandLine : Instrucao a ser executada
				lWaitRun     : Se deve aguardar o termino da Execução
				Path         : Onde, no server, a funcao devera ser executada
				Retorna      : .T. Se conseguiu executar o Comando, caso contrario, .F.
				*/
				
				//Compacta o arquivo e cria o compactado na pasta cArqDest
				
				//lResWait := WaitRunSrv( cWinRar + ' a "' + cArqDest + '" "' + cArqTmp + '"' , .T. , "\\Srvap01n\Protheus10\" )
				
				//Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s
				//lResWait := WaitRunSrv( cWinRar + ' a "' + cArqDest + '" "' + cArqTmp + '"' , .T. , "\\10.19.1.8\Protheus_Data\" )     
				lResWait := WaitRunSrv( cWinRar + ' a "' + cArqDest + '" "' + cArqTmp + '"' , .T. , "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\Protheus_Data\" )     

				If lResWait
					QOut(&cDataHora + " - Resultado WaitRunSrv: Realizado com sucesso!")
					
					PutGlbValue('TOperativaStatus',cErro)
					GlbUnLock()
				Else
					lOk := .F.
					cErro := &cDataHora + " - Resultado WaitRunSrv: Erro na execução da compactação..."
					QOut(cErro)

					PutGlbValue('TOperativaStatus',cErro)
					GlbUnLock()
				EndIf
				
				FErase(cArqTmp)   
				
				If lOk .and. !File(cArqDest) 
					lOk := .F.
					cErro := &cDataHora + " - Arquivo de carga Operativa COMPACTADO (" + cArqDest + ") não foi encontrado!"
					QOut(cErro)

					PutGlbValue('TOperativaStatus',cErro)
					GlbUnLock()
				ElseIf lOk                  
				
					QOut(&cDataHora + " - Início do Upload Operativa.") 
					
					aRet := UploadFTP(cArqDest)
					
					If !aRet[1]
						lOk		:= .F.
						cErro 	:= &cDataHora + " - " + aRet[2]
						QOut(cErro)

						PutGlbValue('TOperativaStatus',cErro)
						GlbUnLock()
					Else
						FErase(cArqDest)
						QOut(&cDataHora + " - Término do Upload Operativa.")

						PutGlbValue('TOperativaStatus',&cDataHora + " - Término do Upload Operativa.")
						GlbUnLock()
					EndIf
					
				EndIf
			EndIf
		EndIf
			    
	EndIf
	
EndIf
    
aMail := EnviaMail(lOk,cErro,'Operativa',lSchedule)

If !aMail[1]
	QOut(&cDataHora + " - Erro ao enviar o e-mail de confirmação carga Operativa : " + aMail[2])

	PutGlbValue('TOperativaStatus',&cDataHora + " - Erro ao enviar o e-mail de confirmação carga Operativa : " + aMail[2])
	GlbUnLock()
Else  
	QOut(&cDataHora + " - E-mail de confirmação carga Operativa enviado.")

	PutGlbValue('TOperativaStatus',&cDataHora + " - E-mail de confirmação carga Operativa enviado.")
	GlbUnLock()
EndIf  

PutGlbValue('ThreadOperativa', "FINALIZADO")
GlbUnLock()  

QOut(&cDataHora + ' - ThreadOperativa [ ' + GetGlbValue('ThreadOperativa') + ' ]')

Return

***********************************************************************************************************************
                          
Static Function UploadFTP(cArq)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local lRet 		:= .T.
Local cLog		:= "" 
Local cServidor := "ftp.medlinksaude.com.br"
Local nPorta	:= 21
Local cLogin	:= "caberj"
Local c_Senha	:= "caberj@medlink"
Local cPastaDes	:= ''
Local cNomeArq	:= right(cArq,len(cArq) - Rat('\',cArq))

If nFTP == 1 
	cServidor 	:= "10.19.1.62"
	nPorta		:= 21
	cLogin		:= "envio.operativa@caberj.com.br"
	c_Senha		:= "sistemasoperativa."
	cPastaDes	:= "\carga\" //Pasta destino do arquivo no FTP  
Else
	cServidor 	:= "ftp.medlinksaude.com.br"
	nPorta		:= 21
	cLogin		:= "caberj"
	c_Senha		:= "caberj@medlink"
	
	//Leonardo Portella - 29/11/13 - Inicio - Virada P11
				
	//cPastaDes	:= "\caberj\carga\" //Pasta destino do arquivo no FTP
	cPastaDes	:= "\carga\" //Pasta destino do arquivo no FTP
	
	//Leonardo Portella - 29/11/13 - Fim
		
EndIf

//Precisa estar abaixo do RootPath
MoveFile(cArq,"\" + cNomeArq, .F.)

FTPDISCONNECT()

lConnect := FTPCONNECT(cServidor,nPorta,cLogin,c_Senha)

If !lConnect

	nTent := 0

	FTPDISCONNECT()

	While nTent <= 5 .and. !lConnect

	    sleep(1000)
		nTent++
		lConnect := FTPCONNECT(cServidor,nPorta,cLogin,c_Senha)

	EndDo

	If !lConnect

		lRet := .F.
		cLog := "Não foi possível conectar ao servidor FTP..."

	EndIf

EndIf


If lRet

	If nFTP == 1 
	        
		QOut('Operativa - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')
			
		aPasta 		:= Separa(cPastaDes,'\',.F.) 
		cNovoCam	:= ''
		
		For nI := 1 to len(aPasta)

			cNovoCam += '/' + aPasta[nI]

			If !FTPDirChange(cNovoCam)
				lRet 	:= .F.
				cLog 	:= 'Não foi possível mudar para o diretorio [ ' + cNovoCam + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] - Diretório destino [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
				QOut(cLog)
				exit
			EndIf

		Next

		If lRet 
			
			aInfoFTP 	:= FTPDirectory("*.zip")
        
			If len(aInfoFTP) == 0
				QOut('Operativa - Nenhum arquivo a ser deletado no FTP [ ' + cServidor + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')		
			Else
				//Operativa - Deleto todos os arquivos
				For nI := 1 to len(aInfoFTP)
					FTPERASE(cPastaDes + aInfoFTP[nI][1])
					QOut('Operativa - Arquivo deletado: ' + aInfoFTP[nI][1] + ' [ ' + cServidor + ' ]')
			  	Next
			EndIf
		EndIf
	
	//Leonardo Portella - 29/11/13 - Inicio	- Virada P11
	
	//Else
	ElseIf nFTP == 2
	        
		QOut('Medlink - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')
			
		aPasta 		:= Separa(cPastaDes,'\',.F.) 
		cNovoCam	:= ''
		
		For nI := 1 to len(aPasta)

			cNovoCam += '/' + aPasta[nI]

			If !FTPDirChange(cNovoCam)
				lRet 	:= .F.
				cLog 	:= 'Não foi possível mudar para o diretorio [ ' + cNovoCam + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] - Diretório destino [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
				QOut(cLog)
				exit
			EndIf

		Next

		If lRet 
			FTPERASE(cPastaDes + cNomeArq)//Medlink - Apago o arquivo de mesmo nome, caso exista (2 cargas geradas no mesmo dia, mantenho a segunda)
		EndIf
		
		//FTPERASE(cPastaDes + cNomeArq)//Medlink - Apago o arquivo de mesmo nome, caso exista (2 cargas geradas no mesmo dia, mantenho a segunda)
	
	//Leonardo Portella - 29/11/13 - Fim
	
	Endif
EndIf

//Leonardo Portella - 29/11/13 - Inicio	- Virada P11

//If lRet .and. !FTPUPLOAD("\" + cNomeArq,cPastaDes + cNomeArq)
If lRet .and. !FTPUPLOAD("\" + cNomeArq, cNomeArq)

//Leonardo Portella - 29/11/13 - Fim

	lRet := .F.
	cLog := "Não foi possível realizar o upload..."	
EndIf

FTPDISCONNECT()

FErase("\" + cNomeArq)

Return {lRet, cLog}

***************************************************************************************************************************

Static Function EnviaMail(lOk,cErro,cOrigem,lSchedule)

Local cSubject 		:= "Envio de carga " + cOrigem + "(" + If(lSchedule,"Schedule","Manual") + ") " + DtoC(Date()) + " - STATUS: " + If(lOk,"OK","ERRO") 
Local cBody 		:= ""
Local cTo 			:= GetMV('MV_XLOGCAB')
Local cServer 		:= SuperGetmv("MV_RELSERV")
Local cAccount		:= SuperGetmv("MV_RELACNT")
Local cPassword		:= SuperGetMv("MV_RELAPSW") 
Local cRemetente	:= SuperGetMv("MV_WFMAIL")
Local nTimeOut	    := SuperGetMv("MV_RELTIME",,120)
Local cErrorMsg 	:= ""
Local lResult		:= .T.

cBody := '<html>' 
cBody += '<head>' 							
cBody += '<title>CARGA MEDLINK</title>'								 
cBody += '</head>'																							  
cBody += '<b><font size="3" face="Arial" color="Black">Status da carga do dia ' + DtoC(Date()) + ' (' + If(lSchedule,"Schedule","Manual") + '): ' + If(lOk,"Disponibilizada no FTP","ERRO") + '</font></b>'
cBody += '<br>'
cBody += '<br>'

If !lOk
	cBody += '<b><font size="3" face="Arial" color="Black">' + cErro + '</font></b>' 	 
EndIf

If nFTP == 1
	cBody += '<b><font size="3" face="Arial" color="Black">Upload feito no FTP Caberj</font></b>' 	 
Else
	cBody += '<b><font size="3" face="Arial" color="Black">Upload feito no FTP Medlink</font></b>' 	 
EndIf

cBody += '</body>'
cBody += '</html>'
                     
CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut RESULT lResult

If lResult
	
	If !lAutentEmail .or. MailAuth(cAccount,cPassword)
                  
		SEND MAIL FROM cAccount   ;
		TO cTo ;     
		CC "" ;
		SUBJECT cSubject;
		BODY cBody;
		ATTACHMENT ""

	Else
		
		lResult 	:= .F.
		cErrorMsg 	:= ""
		
		GET MAIL ERROR cMsgRet

		cErrorMsg 	:= 	'Falha na autenticacao com servidor de e-mail...' 	+ CRLF 	;  
						+ 'Erro no envio de e-mail ' 						+ CRLF 	;
		                + '   - TO [ ' + cTo + ' ]' 						+ CRLF 	;
		                + '   - CC [ ' + cBody + ' ]' 	  					+ CRLF 	;
						+ '   - SUBJECT [ ' + cSubject + ' ]' 				+ CRLF 	;
						+ '   [ ' + cErrorMsg + ' ]' 
						
	End
Else
	cErrorMsg := "Falha na conexao com servidor de e-mail..."
End

DISCONNECT SMTP SERVER

Return {lResult,cErrorMsg}


******************************************************

User Function TESTEENV

Processa({||P_TESTEENV()},'Processando...')

Return

******************************************************

Static Function P_TESTEENV

Local cQuery 	:= "" 
Local cProc		:= ""
Local cAlias	:= GetNextAlias()  
Local lErro		:= .F.
Local nI		:= 0 

ProcRegua(0)

For nI := 1 to 5
	Incproc('Processando...')
Next

cProc := "CREATE OR REPLACE "
cProc += "PROCEDURE TESTEENV(BAU_CODIGO IN VARCHAR2, EMPRESA IN VARCHAR2) "
cProc += "IS " 
cProc += "ENVIO_INI VARCHAR2(10); "
cProc += "ENVIO_FIM VARCHAR2(10); "
cProc += "BEGIN "
cProc += "  SELECT ENVIO_RDA_MEDLINK(BAU_CODIGO,EMPRESA,'INICIO'), ENVIO_RDA_MEDLINK(BAU_CODIGO,EMPRESA,'FIM') "
cProc += "  INTO ENVIO_INI,ENVIO_FIM "
cProc += "  FROM DUAL "
cProc += "END; "
cProc += "END TESTEENV; "
          
If TcSqlExec(cProc) <> 0
	MsgStop('Erro ao criar procedure TESTEENV' + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM)) 
	lErro := .T.
Else  

	cQuery 	:= "SELECT BAU_CODIGO,'CABERJ' EMPRESA,P.R_E_C_N_O_ R_E_C_N_O_" 	+ CRLF
	cQuery 	+= "FROM BAU010 P  ,BAG010 T" 										+ CRLF
    cQuery 	+= "WHERE BAU_FILIAL=' '" 											+ CRLF
    cQuery 	+= "    AND BAG_FILIAL=' '" 										+ CRLF
    cQuery 	+= "    AND BAU_TIPPRE=BAG_CODIGO" 									+ CRLF
    cQuery 	+= "    AND BAU_XMEDLI = 'S'" 										+ CRLF
    cQuery 	+= "    AND BAU_DTINCL <> ' '" 										+ CRLF
    cQuery 	+= "    AND P.D_E_L_E_T_ = ' '" 									+ CRLF
    cQuery 	+= "    AND T.D_E_L_E_T_ = ' '" 									+ CRLF
	cQuery 	+= "UNION ALL" 														+ CRLF
	cQuery 	+= "SELECT BAU_CODIGO,'INTEGRAL' EMPRESA,P.R_E_C_N_O_ R_E_C_N_O_" 	+ CRLF
	cQuery 	+= "FROM BAU020 P  ,BAG020 T" 										+ CRLF
    cQuery 	+= "WHERE BAU_FILIAL=' '" 											+ CRLF
    cQuery 	+= "    AND BAG_FILIAL=' '" 										+ CRLF
    cQuery 	+= "    AND BAU_TIPPRE=BAG_CODIGO" 									+ CRLF
    cQuery 	+= "    AND BAU_XMEDLI = 'S'" 										+ CRLF
    cQuery 	+= "    AND BAU_DTINCL <> ' '" 										+ CRLF
    cQuery 	+= "    AND P.D_E_L_E_T_ = ' '" 									+ CRLF
    cQuery 	+= "    AND T.D_E_L_E_T_ = ' '" 									+ CRLF 
    
    TcQuery cQuery New Alias cAlias

	While !cAlias->(EOF())
	
		cProc := "BEGIN "
		cProc += "TESTEENV('" + cAlias->BAU_CODIGO + "','" + cAlias->EMPRESA + "'); "
		cProc += "END; "

		If TcSqlExec(cProc) <> 0
		 	LogErros('RDA: ' + cAlias->BAU_CODIGO + ' - Empresa: ' + cAlias->EMPRESA + ' - RECNO: ' + cValToChar(cAlias->R_E_C_N_O_) + ' - ' + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
		 	lErro := .T.
		 	exit
	    EndIf
	
		cAlias->(DbSkip())
		
	EndDo  
	
	cAlias->(DbCloseArea())
	
	cProc := "DROP PROCEDURE TESTEENV" 
	
	If TcSqlExec(cProc) <> 0
		MsgStop('Erro no DROP PROCEDURE TESTEENV' + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
		lErro := .T.
	EndIf
	
EndIf

If !lErro
	MsgInfo('Execução finalizada sem erros!',AllTrim(SM0->M0_NOMECOM))
EndIf
	
Return

User Function TSTSCH

Local nI := 0

For nI := 1 to 10
	QOut('Teste schedule')
Next

Return
