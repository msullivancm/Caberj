#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*                  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR171   º Autor ³Altamiro              º Data ³ 21/11/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±                                          
±±ºDescricao ³ pre-critica do sib                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//*******************************************************************************
//Leonardo Portella - 30/07/16 - Importação e leitura do XML via procedure Oracle                
//*******************************************************************************
//Leonardo Portella - 04/11/15 - Modificação na estrutura do relatório                
//*******************************************************************************

User Function CABR171

Local cMsg			:= ""

Private aArGeral
Private lAbortPrint := .F.
Private cPerg       := "CABR171"
Private cTitulo     := "Crítica do arquivo de envio SIB [ SBX ]"
Private cCCO     	:= ' ' 
Private cpf    	 	:= ' ' 
Private cns     	:= ' '
Private nome    	:= ' ' 
Private sexo    	:= ' ' 
Private DtNasc  	:= ' ' 
Private nomeMae 	:= ' ' 
Private lograd  	:= ' ' 
Private numero  	:= ' ' 
Private complem 	:= ' ' 
Private bairro  	:= ' ' 
Private codMunic	:= ' ' 
Private cep     	:= ' ' 
Private tpEnder 	:= ' '
Private resExt  	:= ' ' 
Private codBenef   	:= ' ' 
Private relDepen   	:= ' ' 
Private dtContra   	:= ' ' 
Private numPlaANS  	:= ' ' 
Private cobParTmp  	:= ' ' 
Private itExcCob   	:= ' ' 
Private CnpjEmpCont	:= ' '   
Private CeiEmpCont 	:= ' '   
Private dtCancel   	:= ' ' 
Private MotCancel  	:= ' '                
Private dtReat     	:= ' '                                   
Private CodbenTit  	:= ' '
Private numplnPort 	:= ' '
Private cTab       	:= ' '
Private cHorIni		:= '' 
Private cHorFim		:= ''
Private nLinhasProc	:= 0 
Private lPisPasep                     
Private cTpSib      := ' ' 
private cHora:= StrTran(Time(),':','')   
private cHora1 := substr(cHora,1,2)+':'+substr(cHora,3,2)+':'+substr(cHora,5,2)
private DtHora := substr(dtos(date()),7,2)+'/'+substr(dtos(date()),5,2)+'/'+substr(dtos(date()),1,4)+' - '+cHora1	     
private DtString := substr(dtos(date()),1,8)   

//private cComp  := Iif(substr(dtos(date),5,2)=='01',STRZERO((VAL(substr(dtos(date()),1,4))-1),4),substr(dtos(date()),1,4))+Iif(substr(dtos(date()),5,2)=='01','12',STRZERO((VAL(substr(dtos(date()),5,2))-1),2)) 

private cUsua171 :=  SubStr(cUSUARIO,7,15)

private cAno := substr(DtString,1,4)
private cMes := substr(DtString,5,2) 

Private  dDatcomp   :=iif(cMes=='01',strzero((val(cAno)-1),4), cAno) + iif(cMes=='01','12',strzero((val(cMes)-1),2) ) 
//Private  cCompte    : dDatcomp
Private  cAnoMesA   := iif(((val(cMes)-2) < 1) ,strzero((val(cAno)-1),4), cAno) +iif(((val(cMes)-2) < 1) ,'12',strzero((val(cMes)-2),2) )  

Private cSibEnv := GETMV("MV_SIBENV") // 1 - Sib SIM  , 0 - Sib NAO    

PRIVATE cAlSAns:= GetNextAlias()                                       
private adadoscri:= {}           
private cCriticado := ' ' 
private lFazDel    := .F.  
private cTpSib     := Iif(substr(dtos(date()),7,2) < '06' , 'Sib Mensal', 'Sib Global')

PRIVATE cCodCri    := ' '              
private cNomeBA1   := ' ' 
private cMatrcBA1  := ' ' 
private cCriComp   := ' '   
private cLocSib    := ' ' 
private cNomArqSIB := ' '
//Private  dDatcomp  := ' ' 
If cEmpAnt == '01'  
   cTab		:= " SIGA.CONFSIB_CAB "
   cTabXML	:= "SIGA.ENVIOSIB_CAB" 
   cEmp     := 'CABERJ'
Else
   cTab		:= " SIGA.CONFSIB_INT "     
   cTabXML	:= "SIGA.ENVIOSIB_INT"   
   cEmp     := 'INTEGRAL'
EndIf                              

If  cSibEnv == 1
    DbSelectArea("SX6")
    DbSetOrder(1)
    If DbSeek('  '+"MV_SIBENV")
       RecLock("SX6",.F.)
         SX6->X6_CONTEUD := '0'
       MsUnLock()
    EndIf  
 EndIf    

                                                                         
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Validação do arquivo SIB " + CRLF

oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo SBX",,,.F.,,,,,,.T.,,,.T. )

oGrp1      := TGroup():New( 008,012,100,224,"Arquivo SBX",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}				,oDlg1,,"", )

oDlg1:Activate(,,,.T.)

Return

*****************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKLETXT  º Autor ³                    º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a leitura do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OkLeTxt

Local nCont			:= 0   
//Local cNomArqSIB	:= '' 
Local lContinua		:= .T. 

Private  cNomeArq	:= ""
Private  cMesAdi	:= ""
Private  cAnoAdi	:= "" 
Private  cCritica   := " " 
Private  cCritImp   := " " 
//private  dDatcomp   := ( StrZero(mv_par08,4) + StrZero(mv_par07,2) ) + '31' 


Private  aDadosInc  := {} 
Private  aDadosRet  := {} 
Private  aDadosCanc	:= {} 

Private  aDadosReat	:= {} 
Private  aDadosMcon	:= {} 

Private  aErroVlr	:= {} 
Private  aErroTit	:= {}
Private  aCertosNT  := {} 
PRIVATE nInserido   := 0
private dDatCria    := '' 			
Private  aCabInc    := {'CRITICADO',"Empresa","Descr. Empresa","Matrícula","cpf","cns","nome","sexo","dataNascimento","nomeMae","logradouro" ,"numero","complemento","bairro","codigoMunicipio","cep" ,"tipoEndereco","resideExterior","codigoBeneficiario","relacaoDepEndencia","dataContratacao" ,"numeroPlanoANS","coberturaParcialTemporaria" ,"itensExcluidosCobertura","cnpjEmpresaContratante","ceiEmpresaContratante","Crít. USUÁRIO","Crít. MATRÍCULA","Crít. CPF","Crít. MÃE","Crít. TITULAR","Crít. DATA CONTRATAÇÃO","Crít. DATA NASCIMENTO","Crít. PIS/PASEP","Crít. IND. ENDEREÇO", "Crít. CNPJ/CEI","Crít. CNS", "Crít.Forcar Inclusa"}
Private  aCabRet    := {'CRITICADO',"Empresa","Descr. Empresa","Matrícula","cco","cpf","cns" ,"nome","sexo","dataNascimento","nomeMae","logradouro" ,"numero","bairro","codigoMunicipio","cep" ,"tipoEndereco","resideExterior","codigoBeneficiario","relacaoDepEndencia","dataContratacao" ,"numeroPlanoANS","coberturaParcialTemporaria" ,"itensExcluidosCobertura","cnpjEmpresaContratante","ceiEmpresaContratante","Crít. USUÁRIO","Crít. CPF","Crít. MÃE","Crít. TITULAR","Crít. DATA CONTRATAÇÃO","Crít. CCO","Crít. DATA NASCIMENTO", "Crít. PIS/PASEP" , "Crít. DATA CANCELAMENTO","Crít. DATA REATIVAÇÃO","Crít. CNS", 'Crít.Forcar Cancelamento','Qtda Retic','Crit Ret', 'Campo Retificados' }
Private  aCabCanc   := {'CRITICADO',"Empresa","Descr. Empresa","Matrícula","cco","dataCancelamento","motivoCancelamento", "Crít. CCO", "Crít. DATA CONTRATO", "Crít. DATA CANCELAMENTO"} 
Private  aCabReat   := {'CRITICADO',"Empresa","Descr. Empresa","Matrícula","cco","dataReativacao","Crít. CCO","Crít. MATRÍCULA","Crít. TITULAR","Crít. REATIVAÇÃO", "Crít. CNPJ/CEI" }
Private  aCabMudCon := {'CRITICADO',"Empresa","Descr. Empresa","Matrícula","cco","relacaoDepEndencia","codigoBeneficiarioTitular","dataContratacao","numeroPlanoANS","numeroPlanoPortabilidade","coberturaParcialTemporaria","itensExcluidosCobertura","cnpjEmpresaContratante","ciEmpresaContratante","Crít. MATRÍCULA","Crít. CCO","Crít. TITULAR","Crít. DATA CONTRATO","Crít. PLANO", "Crít. CNPJ/CEI"}    
private lFazPd5     := .F.

Pergunte(cPerg,.F.)
                                                                                                                   
cNomeArq	:= mv_par01                             
cNomArqSIB 	:= Substr(cNomeArq,Rat('\',cNomeArq)+1,Rat('.',cNomeArq)-Rat('\',cNomeArq)+3)
dDatCria    := substr(cNomArqSIB,7,08)


If ( cEmpAnt == '01' ) .and. ( left(cNomArqSIB,6) <> '324361' )  
	MsgStop("Arquivo não é da CABERJ. Esperado que o nome do arquivo inicie com [ 324361 ] porém o nome do arquivo inicia com [ " + left(cNomArqSIB,6) + " ]" ,AllTrim(SM0->M0_NOMECOM))
	lContinua := .F.
ElseIf ( cEmpAnt == '02' ) .and. ( left(cNomArqSIB,6) <> '415774' )
	MsgStop("Arquivo não é da INTEGRAL. Esperado que o nome do arquivo inicie com [ 415774 ] porém o nome do arquivo inicia com [ " + left(cNomArqSIB,6) + " ]" ,AllTrim(SM0->M0_NOMECOM))
	lContinua := .F.
EndIf

If lContinua
/*
	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Copiando arquivo...')
	Next
	
/// copia dos aquivos de envio  ans  	
	cArqSIBc := Right(cNomeArqc,len(cNomeArqc) - RAt('\',cNomeArqc))   
	cArqSIBc := UPPER(cArqSIBc)
	cArqDesC := '\\srvdbp\backup\utl\SIB\SIBENV\' + cArqSIBc
	
	If !MoveFile(cNomeArqc,cArqDesC,.F.)
		MsgStop("Não foi possível copiar o  arquivo  [ " + cNomeArqc+ " ] para [ " + cArqDesC + " ]","Atencao!")
		Return .F.
	EndIf    
*/


	cHorIni := Time()
	
	Processa({|| lContinua := Proc171()}, cTitulo, "", .T.)
	
	If lContinua
	
		MsgInfo("Processo finalizado." 																	 + CRLF	+ ;
				"Linhas processadas: " + AllTrim(Transform(nLinhasProc,'@E 999,999,999,999,999')) + CRLF + CRLF	+ ;
	 			"Início [ " + cHorIni + " ]" 	                                                         + CRLF + ;
	 			"Término [ " + cHorFim + "]" 													  + CRLF + CRLF	+ ;
	 			"Tempo de processamento [ " + ElapTime(cHorIni,cHorFim) + " ]"	  	  							  ;
	 		,AllTrim(SM0->M0_NOMECOM))
	 		
	 EndIf

EndIf

Return                 
                                                                  
**************************************************************************

Static Function Proc171

Local nAux 			:= 0
Local cTot 			:= ''
Local lInicio		:= .T.
Local nI			:= 0

Local cCritUsr 		:= ''	
Local cCritMae 		:= '' 
Local cCritMat 		:= ''
Local cArqSIB		:= ''       

Private lCritSIB 	:= .F.
Private cAliasSIB 	:= ''
Private cAliasBA1 	:= ''     
Private cAliasBA12 	:= ''    

//Private cSequenc    := StrZero(fSeqPD5(( StrZero(mv_par08,4) + StrZero(mv_par07,2) ) , cTpSib ),2) 
Private cSequenc    := StrZero(fSeqPD5(dDatcomp, cTpSib ),2)

Private cBuffer1           
                                                               
cNomeArq := Alltrim(cNomeArq)


If !File(cNomeArq)
   MsgAlert("Arquivo texto: " + cNomeArq + " não Localizado","Atencao!")
   Return .F.
Else
	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Copiando arquivo...')
	Next
	
	cArqSIB := Right(cNomeArq,len(cNomeArq) - RAt('\',cNomeArq))
	cArqDes := '\\srvdbp\backup\utl\SIB\' + cArqSIB
	
	If !MoveFile(cNomeArq,cArqDes,.F.)
		MsgStop("Não foi possível copiar o  arquivo  [ " + cNomeArq + " ] para [ " + cArqDes + " ]","Atencao!")
		Return .F.
	EndIf
	
EndIf

IncProc('Carregando arquivo XML...')

aRetSP := TcSPExec(	'CARGA_ENVIO_SIB',;
						If(cEmpAnt == '01','CABERJ','INTEGRAL'),;
						cArqSIB;
				  )
	
If Empty(aRetSP)
	MsgStop("Erro ao executar a procedure CARGA_ENVIO_SIB",AllTrim(SM0->M0_NOMECOM))
	Return .F.
Else

	//Leonardo Portella - 20/03/17 - Início - Controlar os registros enviados (devido as manutenções, ocorre alteração nos registros e novos registros 
	//são enviados sem a devida validação. Com o controle feito na tabela ENVIAR_SIB e em conjunto com o ponto de entrada PLS782DAD, somente os registros 
	//selecionados inicialmente serão enviados, evitando assim que registros não validados sejam enviados para a ANS) 
	
	cAlEnviar := GetNextAlias()
	
	cQry := "SELECT ANO_MES FROM ENVIAR_SIB WHERE ROWNUM = 1"
	
	TcQuery cQry New Alias cAlEnviar
	
	//Se o parâmetro estiver como regerar ou a tabela estiver vazia ou o mês da geração for diferente do mês atual irá regerar.
	
	If cAlEnviar->(EOF()) .or. ( cAlEnviar->ANO_MES <> Left(DtoS(Date()),6) )
	
		cScript := "BEGIN" 																									+ CRLF
		cScript += "DELETE FROM ENVIAR_SIB WHERE EMPRESA = '" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "';" 				+ CRLF
		cScript += "INSERT INTO ENVIAR_SIB" 																				+ CRLF
		cScript += "(" 																										+ CRLF
		
		If cEmpAnt == '01'
		
			cScript += "	SELECT DISTINCT 'CABERJ' EMPRESA, TO_CHAR(SYSDATE,'YYYYMM') ANO_MES, SIB_MATRIC, SIB_CODCCO"	+ CRLF
			cScript += "	FROM ENVIOSIB_CAB"																				+ CRLF
			
		Else
		
			cScript += "	SELECT DISTINCT 'INTEGRAL' EMPRESA, TO_CHAR(SYSDATE,'YYYYMM') ANO_MES, SIB_MATRIC, SIB_CODCCO"	+ CRLF
			cScript += "	FROM ENVIOSIB_INT"																				+ CRLF
			
		EndIf
		
		cScript += ");" 																									+ CRLF
		cScript += "END;" 																									+ CRLF
		
		If TcSqlExec(cScript) < 0
			LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
		EndIf
		
	EndIf
	
	cAlEnviar->(DbCloseArea())

	//Leonardo Portella - 20/03/17 - Fim 
	
	cMsgTimer := 	"Inclusões: " + cValToChar(aRetSP[1]) 												+ CRLF + ;
					"Reativações: " + cValToChar(aRetSP[2]) 											+ CRLF + ;
					"Cancelamentos: " + cValToChar(aRetSP[3]) 											+ CRLF + ;
					"Retificações: " + cValToChar(aRetSP[4]) 											+ CRLF + ;
					"Mudanças Contratuais: " + cValToChar(aRetSP[5])									+ CRLF + ;
					"Tempo de cópia do arquivo e carga XML [ " + ElapTime(cHorIni,Time()) + " ]" 				 
				
	LogErros(cMsgTimer,"Estatísticas XML",.T.,, 20000)
	
EndIf

IncProc('Consultando XML na base de dados...')

cQryArq := "SELECT 	SIB_OPERACAO, SIB_CPFUSR, SIB_CODCCO, SIB_NOMUSR, SIB_BAIRRO, SIB_CEIEMP, SIB_CEPUSR, SIB_CGCEMP, SIB_CNS," + CRLF
cQryArq += "		SIB_COBPAR, SIB_CODMUN, SIB_CODMUNRES A , SIB_COMPLEM,SIB_DATBLO, SIB_DATCON, SIB_DATNAS, SIB_DATREA," 		+ CRLF  
cQryArq += "		SIB_ENDERE, SIB_GRAUPA, SIB_ITEXCO, SIB_MAE, SIB_MATRIC, SIB_MATTIT, SIB_MOTBLO, SIB_NASVIV, SIB_NR_END," 	+ CRLF
cQryArq += "		SIB_NUMPLA, SIB_PISPAS, SIB_PLAOPE, SIB_PLAPOR, SIB_PROADM, SIB_RESEXT, SIB_SEXO, SIB_TIPOEND "		 		+ CRLF
cQryArq += "FROM " + If(cEmpAnt == '01',"SIGA.ENVIOSIB_CAB","SIGA.ENVIOSIB_INT") + " ENVIO"										+ CRLF
cQryArq += "WHERE SIB_OPERACAO IN 

cOperSIB := If(mv_par02 == 1,'INCLUSAO','')				+ ';'
cOperSIB += If(mv_par03 == 1,'RETIFICACAO','')			+ ';'
cOperSIB += If(mv_par04 == 1,'CANCELAMENTO','')			+ ';'
cOperSIB += If(mv_par05 == 1,'REATIVACAO','')			+ ';'
cOperSIB += If(mv_par06 == 1,'MUDANCA CONTRATUAL','')	+ ';'

cQryArq += FormatIn(cOperSIB,';')

cQryArq += "ORDER BY DECODE(SIB_OPERACAO,'INCLUSAO',1,'CANCELAMENTO',2,'REATIVACAO',3,'RETIFICACAO',4,'MUDANCA CONTRATUAL',5)"	+ CRLF

cAlArq := GetNextAlias()

TcQuery cQryArq New Alias cAlArq
                         
COUNT TO nAux

cAlArq->(DbGoTop())

nLinhasProc := nAux
	
ProcRegua(nAux) 
	
cTot 	:= AllTrim(Transform(nAux,'@E 999,999,999'))
	
nAux 	:= 0
nCont 	:= 0                   

lFazPd5 := fStProc()
	
While !cAlArq->(EOF())
	
   	IncProc('Processando registro ' + AllTrim(Transform(++nAux,'@E 999,999,999')) + ' de ' + cTot)
   
   	cOperSIB 	:= AllTrim(cAlArq->SIB_OPERACAO)
    cCCO     	:= cAlArq->SIB_CODCCO
	cpf     	:= cAlArq->SIB_CPFUSR 
	cns     	:= cAlArq->SIB_CNS
	nome    	:= cAlArq->SIB_NOMUSR
	sexo    	:= If(cAlArq->SIB_SEXO == '3','Feminino', 'Masculino') 
	DtNasc  	:= Right(cAlArq->SIB_DATNAS,2) + '/' + Substr(cAlArq->SIB_DATNAS,5,2) + '/' + Left(cAlArq->SIB_DATNAS,4)
	nomeMae 	:= cAlArq->SIB_MAE 
	lograd  	:= cAlArq->SIB_ENDERE 
	numero  	:= cAlArq->SIB_NR_END
	complem 	:= cAlArq->SIB_COMPLEM
	bairro  	:= cAlArq->SIB_BAIRRO
	codMunic	:= cAlArq->SIB_CODMUN
	cep     	:= cAlArq->SIB_CEPUSR
	tpEnder 	:= cAlArq->SIB_TIPOEND
	resExt  	:= If(cAlArq->SIB_RESEXT == '0','Não','Sim')
	codBenef	:= cAlArq->SIB_MATRIC                        
	relDepen	:= cAlArq->SIB_GRAUPA
	dtContra	:= Right(cAlArq->SIB_DATCON,2) + '/' + Substr(cAlArq->SIB_DATCON,5,2) + '/' + Left(cAlArq->SIB_DATCON,4)
   //	numPlaANS 	:= iif (!empty(cAlArq->SIB_NUMPLA),(cAlArq->SIB_NUMPLA),(cAlArq->SIB_PLAOPE)) 
   	numPlaANS 	:= (cAlArq->SIB_NUMPLA)
	cobParTmp 	:= cAlArq->SIB_COBPAR
	itExcCob 	:= cAlArq->SIB_ITEXCO
	CnpjEmpCont	:= cAlArq->SIB_CGCEMP
	CeiEmpCont 	:= cAlArq->SIB_CEIEMP       
    dtCancel 	:= Right(cAlArq->SIB_DATBLO,2) + '/' + Substr(cAlArq->SIB_DATBLO,5,2) + '/' + Left(cAlArq->SIB_DATBLO,4) 
    MotCancel	:= cAlArq->SIB_MOTBLO
    CeiEmpCont 	:= cAlArq->SIB_CEIEMP
    dtReat   	:= Right(cAlArq->SIB_DATREA,2) + '/' + Substr(cAlArq->SIB_DATREA,5,2) + '/' + Left(cAlArq->SIB_DATREA,4) 
    CodbenTit	:= cAlArq->SIB_MATTIT 
    numplnPort 	:= cAlArq->SIB_PLAPOR
    DN 			:= cAlArq->SIB_NASVIV
    PisPasep  	:= cAlArq->SIB_PISPAS
    lPisPasep	:= !empty(PisPasep)
    
    Do Case
    
     
		Case ( cOperSIB == 'INCLUSAO' )	
		    
	    	If mv_par02 == 1
		    					 
		    	If lAbreAlSIB('INC')
		    	
		    	    cCritUsr := cCritSIB('USUARIO'	,'INC')
			          cCodCri  := Iif(trim(cCodCri)== '' , substr(cCritUsr,9,4), cCodCri )
			          cCriComp := Iif(trim(cCriComp)== '' , cCritUsr,cCriComp)
			    	cCritCPF := cCritSIB('CPF'		,'INC')                    
			    	  cCodCri  := Iif(trim(cCodCri)== '' , substr(cCritCPF,9,4), cCodCri )
			          cCriComp := Iif(trim(cCriComp)== '' , cCritCPF,cCriComp)			    	  
			    	cCritMae := cCritSIB('MAE'		,'INC') 
  			          cCodCri  := Iif(trim(cCodCri)== '' , substr(cCritMae,9,4), cCodCri )			    	
			          cCriComp := Iif(trim(cCriComp)== '' , cCritMae,cCriComp)  			          
			    	cCritMat := cCritSIB('MATRIC'	,'INC')
			    	  cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritMat,9,4), cCodCri )
			          cCriComp := Iif(trim(cCriComp)== '' , cCritMat,cCriComp)  			          			    	  
			    	cCritDCo := cCritSIB('DATCON'	,'INC')
			    	  cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritDCo,9,4), cCodCri )
                      cCriComp := Iif(trim(cCriComp)== '' , cCritDCo,cCriComp)	    	  
			    	cCritTit := cCritSIB('MATTIT'	,'INC')	    	
  			          cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritTit,9,4), cCodCri )			    	
  			          cCriComp := Iif(trim(cCriComp)== '' , cCritTit,cCriComp)
					cCritNas := cCritSIB('DTNASC'	,'INC')
			          cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritNas,9,4), cCodCri )					
			          cCriComp := Iif(trim(cCriComp)== '' , cCritNas,cCriComp)
			    	cCritPis := cCritSIB('PISPAS'	,'INC')
     			      cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritPis,9,4), cCodCri )			    	
     			      cCriComp := Iif(trim(cCriComp)== '' , cCritPis,cCriComp)
			    	cCritEnd := cCritSIB('INDEND'	,'INC') // (sinformado pelo cadastro não e mas criticado pela ans)
			          cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritEnd,9,4), cCodCri )			    	
			          cCriComp := Iif(trim(cCriComp)== '' , cCritEnd,cCriComp)
			    	cCritCNP := cCritSIB('CNPJEMP'	,'INC')
			          cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCNP,9,4), cCodCri )			    	
			          cCriComp := Iif(trim(cCriComp)== '' , cCritCNP,cCriComp)
			    	cCritCNS := cCritSIB('CNS'		,'INC')                                                 
			    	  cCriComp := Iif(trim(cCriComp)== '' , cCritCNS,cCriComp)
			          cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCNS,9,4), cCodCri )			    	
			      //	cCritCPL := cCritSIB('numPlaANS','INC')   
			    	                

//			    	adadoscri:= fValAns( cCCO )                

        
                    cCriticado := If(lCritSIB,'SIM','NÃO')			    	
 
 
                     fNomBa1(' ', codBenef )                    
                    	
// RETIRAR DO ENVIO REGISTRO FORCADO EM SIB MENSAL 
			        If cCriticado != 'SIM' .and.  clocsib == '6' .AND. cTpSib == 'Sib Mensal' .AND. ( Substr(dtContra,7,4) + Substr(dtContra,4,2) ) <> ( dDatcomp )
			    	   cCodCri :='XX12'             
			    	   cCriComp:='Froçado no Sib Mensal ' 
			    	   cCriticado := 'SIM'
			    	EndIf      
			    	
                    
                    
                    fIncCcoVal( 'INCL' ,cEmp, cCCo, codBenef, cCodCri ,cCriComp ) 
			    	 
			    	aAdd(aDadosInc, {			;
			    					cCriticado	,;
			    					GetCpoTab('BA1', 'BA1_CODEMP'),;
			    					AllTrim(Posicione('BG9',1,xFilial('BG9') + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP'),'BG9_DESCRI')),;
			    					GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO'),;
			       					cpf     	,; 
						   			cns     	,;
									nome    	,; 
									sexo    	,;
									DtNasc  	,;
									nomeMae 	,;							
									lograd  	,;
									numero  	,;
									complem 	,;
									bairro  	,;
									codMunic	,;
									cep     	,;
									tpEnder 	,;
									resExt  	,;
									codBenef	,;
									relDepen	,;
									dtContra	,;
									numPlaANS 	,;
									cobParTmp 	,;
									itExcCob 	,;
									CnpjEmpCont	,;
									CeiEmpCont 	,;
									cCritUsr	,;
									cCritMat	,;
									cCritCPF	,;
									cCritMae 	,;
									cCritTit	,;
									cCritDCo	,;
									cCritNas 	,;
							    	cCritPis 	,;
							    	cCritEnd	,;
							    	cCritCNP	,;
							    	cCritCNS 	,;
							    	cCriComp     ;
									})       		
									
				Else
					aAdd(aDadosInc, {			;
			    					'SIM'		,;
			    					'ERRO NA ABERTURA DO ALIAS SIB. OPERAÇÃO: [ INC ]';
									}) 
				EndIf
							
				FechaAlSIB()
			
			EndIf
							
		Case ( cOperSIB == 'RETIFICACAO' )	
		
			If mv_par03 == 1
		
				If lAbreAlSIB('RETIF')
		    	
			    	cCritUsr := cCritSIB('USUARIO'	,'RETIF')                    
			    	cCriComp :=  Iif(trim(cCriComp)=='',cCritUsr,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritUsr,9,4), cCodCri )
			    	cCritMae := cCritSIB('MAE'		,'RETIF')                            
			    	cCriComp := Iif(trim(cCriComp)=='',cCodCri,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritMae,9,4), cCodCri )
			    	cCritCPF := cCritSIB('CPF'		,'RETIF')                           
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCPF,cCriComp) 
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCPF,9,4), cCodCri )
			    	cCritDCo := cCritSIB('DATCON'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritDCo,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritDCo,9,4), cCodCri )
			    	
			    	cCritTit := cCritSIB('MATTIT'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritTit,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritTit,9,4), cCodCri )
			    	
			    	cCritCCO := cCritSIB('CCO'		,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCCO,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCCO,9,4), cCodCri )
					
					cCritNas := cCritSIB('DTNASC'	,'RETIF')                  
					cCriComp := Iif(trim(cCriComp)== '' ,cCritNas,cCriComp)
					cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritNas,9,4), cCodCri )
			    	
			    	cCritPis := cCritSIB('PISPAS'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritPis,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritPis,9,4), cCodCri )

			    	cCritTit := cCritSIB('MATTIT'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritTit,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritTit,9,4), cCodCri )

			    	cCritCan := cCritSIB('DTCANC'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCan,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCan,9,4), cCodCri )

			    	cCritRea := cCritSIB('DATREAT'	,'RETIF')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritRea,cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritRea,9,4), cCodCri )
  
		            cCritCNS := cCritSIB('CNS'		,'RETIF')                  
				    cCriComp := Iif(trim(cCriComp)== '' ,cCritCNS,cCriComp)
				    cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCNS,9,4), cCodCri )
//				    cCritCPL := cCritSIB('numPlaANS','RETIF')    
			    	
			    	adadoscri:= fValAns( cCCO )             

                    cCriticado := Iif(lCritSIB,'SIM',Iif(adadoscri[1,1] == 0,'SIM','NÃO'))			    	 

/// CRITICA SIB ANTERIOR -- RETIFICAÇÃO 			    	                           
		                    
		
			    	If fValReti(cCCO, cAnoMesA ) .and. trim(cCodCri) == ''        
			    	   cCodCri :='XXX2'             
                       cCriComp:='Enviado Retificação No Sib Global da Competência Anterior['+cAnoMesA+'] , aguardando arquivos de Retorno '
                       cCriticado := 'SIM'
                    EndIf  			    	    

////////			    	
			        If adadoscri[1,1] == 0	.and. trim(cCodCri) == '' 
			    	   cCodCri :='XXX1'             
			    	   cCriComp:='Sem dados a Retificar' 
			    	   cCriticado := 'SIM'
			    	EndIf      
		
		            fNomBa1(cCCO, ' ' )
			    	
// RETIRAR DO ENVIO REGISTRO FORCADO EM SIB MENSAL 
			        If cCriticado != 'SIM' .and.  clocsib == '7' .AND. cTpSib == 'Sib Mensal' 
     	    	       cCodCri :='XX12'             
			    	   cCriComp:='Froçado no Sib Mensal ' 
			    	   cCriticado := 'SIM'
			    	EndIf      
			    	*/
			    	fIncCcoVal( 'RETI' ,cEmp, cCCo, codBenef, cCodCri ,cCriComp) 
			    	
                    				  
			    	aAdd(aDadosRet, {			;
			       					cCriticado	,;
			    					GetCpoTab('BA1', 'BA1_CODEMP'),;
			    					AllTrim(Posicione('BG9',1,xFilial('BG9') + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP'),'BG9_DESCRI')),;
			    					GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO'),;
			       					cCCO     	,;
			                        cpf     	,; 
						   			cns     	,;
									nome    	,;							
									sexo    	,;
									DtNasc  	,;
									nomeMae 	,;
									lograd  	,;
									numero  	,;
									bairro  	,;
									codMunic	,;
									cep     	,;
									tpEnder 	,;
									resExt  	,;
									codBenef	,;
									relDepen	,;
									dtContra	,;
									numPlaANS 	,;
									cobParTmp 	,;
									itExcCob 	,;
									CnpjEmpCont	,;
									CeiEmpCont 	,;
									cCritUsr 	,;
									cCritCPF	,;
									cCritMae 	,;
									cCritTit	,;
									cCritDCo	,;
									cCritCCO	,;
									cCritNas	,;
						    		cCritPis 	,;
							    	cCritCan	,;
							    	cCritRea	,;
							    	cCritCNS    ,;
							    	cCriComp    ,;
							    	adadoscri[1,1],; 
							    	adadoscri[2,1],; 
							    	adadoscri[3,1];
							    	})  
				Else
					aAdd(aDadosRet, {			;
			    					'SIM'		,;
			    					'ERRO NA ABERTURA DO ALIAS SIB. OPERAÇÃO: [ RETIF ]';
									}) 
				EndIf
								
				FechaAlSIB()
				
			EndIf      
								
	    Case ( cOperSIB == 'CANCELAMENTO' )	
		
			If mv_par04 == 1

				If lAbreAlSIB('CANCE')		
			
			    	cCritCCO := cCritSIB('CCO'		,'CANCE')	    	       
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCCO, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCCO,9,4), cCodCri )
			    	cCritCon := cCritSIB('DATCON'	,'CANCE')                            
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCon, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCon,9,4), cCodCri )
					cCritCan := cCritSIB('DTCANC'	,'CANCE')                  
					cCriComp := Iif(trim(cCriComp)== '' ,cCritCan, cCriComp)
					cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCan,9,4), cCodCri )
					
                    cCriticado := If(lCritSIB,'SIM','NÃO')
			    				    	 			    	
			   fNomBa1(cCCO, ' ' )                    
			    	                    	
// RETIRAR DO ENVIO REGISTRO FORCADO EM SIB MENSAL 
			        If cCriticado != 'SIM' .and.  clocsib == '8' .AND. cTpSib == 'Sib Mensal'  .AND. ( Substr(dtCancel,7,4) + Substr(dtCancel,4,2) ) <> ( dDatcomp )
			    	   cCriComp:='Froçado no Sib Mensal ' 
			    	   cCriticado := 'SIM'
			    	EndIf      
			    	
			    	
			    	
			    	fIncCcoVal( 'CANC' ,cEmp, cCCo, codBenef, cCodCri ,cCriComp) 					
					
					aAdd(aDadosCanc,{			;
									 cCriticado ,;
			    					 GetCpoTab('BA1', 'BA1_CODEMP'),;
			    					 AllTrim(Posicione('BG9',1,xFilial('BG9') + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP'),'BG9_DESCRI')),;
			    					 GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO'),;
			       					 cCCO 		,;
			                         dtCancel 	,; 
						   	      	 MotCancel 	,;
									 cCritCCO	,;
									 cCritCon	,;
									 cCritCan	,;
									 cCriComp    ;
									 })   
				Else
					aAdd(aDadosCanc, {			;
			    					'SIM'		,;
			    					'ERRO NA ABERTURA DO ALIAS SIB. OPERAÇÃO: [ CANCE ]';
									}) 
				EndIf
								 
				FechaAlSIB()
				
			EndIf      
					   	      	  
	    Case ( AllTrim(cAlArq->SIB_OPERACAO) == 'REATIVACAO' )	
		
			If mv_par05 == 1
		
				If lAbreAlSIB('REATI')				
				
			    	cCritCCO := cCritSIB('CCO'		,'REATI')                  
 					cCriComp := Iif(trim(cCriComp)== '' ,cCritCCO, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCCO,9,4), cCodCri )
			    	cCritMat := cCritSIB('MATRIC'	,'REATI')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritMat, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritMat,9,4), cCodCri )
			    	
			    	cCritTit := cCritSIB('MATTIT'	,'REATI')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritTit, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritTit,9,4), cCodCri ) 
			    	
			    	cCritRea := cCritSIB('DATREAT'	,'REATI')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritRea, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritRea,9,4), cCodCri )
			    	cCritCNP := cCritSIB('CNPJEMP'	,'REATI')                  
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCNP, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCNP,9,4), cCodCri )
			    	
                    cCriticado := If(lCritSIB,'SIM','NÃO')
			    	    
			    	fNomBa1(cCCO, ' ' )
			    	
// RETIRAR DO ENVIO REGISTRO FORCADO EM SIB MENSAL 
			        If cCriticado != 'SIM' .and.  clocsib == 'C' .AND. cTpSib == 'Sib Mensal' 
			    	   cCodCri :='XX12'             
			    	   cCriComp:='Froçado no Sib Mensal ' 
			    	   cCriticado := 'SIM'
			    	EndIf        
			    	    
			    	fIncCcoVal( 'REAT' ,cEmp, cCCo, codBenef, cCodCri , cCriComp ) 
 
			       	aAdd(aDadosReat,{			;
			       					 cCriticado ,;
			    					 GetCpoTab('BA1', 'BA1_CODEMP'),;
			    					 AllTrim(Posicione('BG9',1,xFilial('BG9') + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP'),'BG9_DESCRI')),;
			    					 GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO'),;
			       					 cCCO 		,;
			                         dtReat 	,;
									 cCritCCO   ,;
									 cCritMat 	,;
							    	 cCritTit 	,;
							    	 cCritRea	,;
							    	 cCritCNP	,;
							    	 cCriComp    ;
									 })    
				Else
					aAdd(aDadosReat, {			;
			    					'SIM'		,;
			    					'ERRO NA ABERTURA DO ALIAS SIB. OPERAÇÃO: [ REATI ]';
									}) 
				EndIf
	                            
				FechaAlSIB() 
				
			EndIf     
	                             
	    Case ( cOperSIB == 'MUDANCA CONTRATUAL' )

			If mv_par06 == 1
		    	
				If lAbreAlSIB('MUDC')				
			
			    	cCritMat := cCritSIB('MATRIC'	,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritMat, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritMat,9,4), cCodCri )

			    	cCritTit := cCritSIB('MATTIT'	,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritTit, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritTit,9,4), cCodCri )

			    	cCritCCO := cCritSIB('CCO'		,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCCO, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCCO,9,4), cCodCri )
			    	cCritCon := cCritSIB('DATCON'	,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCon, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCon,9,4), cCodCri )
			    	cCritPla := cCritSIB('PLANO'	,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritPla, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritPla,9,4), cCodCri )
			    	cCritCNP := cCritSIB('CNPJEMP'	,'MUDC')                   
			    	cCriComp := Iif(trim(cCriComp)== '' ,cCritCNP, cCriComp)
			    	cCodCri  :=  Iif(trim(cCodCri)== '' , substr(cCritCNP,9,4), cCodCri )
			    	

                    cCriticado := If(lCritSIB,'SIM','NÃO')
			    	
			    	fNomBa1(cCCO, ' ' )
			    	
// RETIRAR DO ENVIO REGISTRO FORCADO EM SIB MENSAL 
			        If cCriticado != 'SIM' .and.  clocsib == 'B' .AND. cTpSib == 'Sib Mensal'
			    	   cCodCri :='XX12'             
			    	   cCriComp:='Froçado no Sib Mensal ' 
			    	   cCriticado := 'SIM'
			    	EndIf      
			    	
			    	
			    	
			    	
			    	fIncCcoVal( 'MUDC' ,cEmp, cCCo, codBenef, cCodCri ,cCriComp) 
			    						
			       	aAdd(aDadosMcon,{ 			;
			       					 cCriticado	,;
			    					 GetCpoTab('BA1', 'BA1_CODEMP'),;
			    					 AllTrim(Posicione('BG9',1,xFilial('BG9') + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP'),'BG9_DESCRI')),;
			       					 GetCpoTab('SIB', 'SIB_MATRIC')	,;
			       					 cCCO 		,;
			                	     relDepen	,;	
			                	     codBenef	,;	
			                	     dtContra	,;	
			                	     numPlaANS 	,; 
			                	     numplnPort	,;	
			                	     cobParTmp 	,; 	
			                	     itExcCob 	,; 
			                	     CnpjEmpCont,;
									 CeiEmpCont ,;
									 cCritMat	,;
									 cCritCCO	,;
									 cCritTit	,;
									 cCritCon	,;
									 cCritPla	,;
									 cCritCNP	;
									 })    
				Else
					aAdd(aDadosMcon, {			;
			    					'SIM'		,;
			    					'ERRO NA ABERTURA DO ALIAS SIB. OPERAÇÃO: [ MUDC ]';
									}) 
				EndIf
								 
				FechaAlSIB()    
				
			EndIf  
									
    End Case        
    
    
 	cAlArq->(DbSkip())                                               
 	cCodCri := ''           
 	cCriComp:= ''
    
End Do

cAlArq->(DbCloseArea())

cMsg := '' 

cHorFim := Time()

//Obs: DlgToExcel grava em: AllTrim(GetTempPath())
    
If ( mv_par02 == 1 ) 
	If empty(aDadosinc)			
   		cMsg += 'Não foram encontrados registros de INCLUSÃO' 		+ CRLF
   	Else
   		DlgToExcel({{"ARRAY","SIB Inclusao " + If(cEmpAnt == '01','CABERJ','INTEGRAL') 		,aCabInc,aDadosinc}})
   	EndIf 
Else
   cMsg += 'Relatório parametrizado para não validar regitros de INCLUSÃO' 		+ CRLF
EndIf

If ( mv_par03 == 1 ) 
	If empty(aDadosRet)			
   		cMsg += 'Não foram encontrados registros de RETIFICAÇÃO' 	+ CRLF
   	Else			
   		DlgToExcel({{"ARRAY","SIB Retificação " + If(cEmpAnt == '01','CABERJ','INTEGRAL')  	,aCabRet,aDadosRet}})
   	EndIf    
Else
   cMsg += 'Relatório parametrizado para não validar regitros de RETIFICAÇÃO' 	+ CRLF
EndIf

If ( mv_par04 == 1 )
	If empty(aDadosCanc)			
   		cMsg += 'Não foram encontrados registros de CANCELAMENTO' 	+ CRLF
   	Else
   		DlgToExcel({{"ARRAY","SIB Cancelamento " + If(cEmpAnt == '01','CABERJ','INTEGRAL')  ,aCabCanc,aDadosCanc}})
   	EndIf    
Else
   cMsg += 'Relatório parametrizado para não validar regitros de CANCELAMENTO' 	+ CRLF
EndIf

If ( mv_par05 == 1 )
	If empty(aDadosReat)			
   		cMsg += 'Não foram encontrados registros de REATIVAÇÃO' 	+ CRLF
   	Else
   		DlgToExcel({{"ARRAY","SIB Reativação "  + If(cEmpAnt == '01','CABERJ','INTEGRAL')  	,aCabReat,aDadosReat}})
   	EndIf     
Else
   cMsg += 'Relatório parametrizado para não validar regitros de REATIVAÇÃO' 	+ CRLF
EndIf

If ( mv_par06 == 1 )
	If empty(aDadosMcon)			
   		cMsg += 'Não foram encontrados registros de MUDANÇA CONTRATUAL'
   	Else
   		DlgToExcel({{"ARRAY","SIB Mudança "  + If(cEmpAnt == '01','CABERJ','INTEGRAL')     	,aCabMudCon,aDadosMcon}})
   	EndIf     
Else
   cMsg += 'Relatório parametrizado para não validar regitros de MUDANÇA CONTRATUAL' 	+ CRLF
EndIf
	
If !empty(cMsg)
	MsgAlert(cMsg,AllTrim(SM0->M0_NOMECOM))
EndIf

Return .T.

**********************************************************************************************
                                                                
Static Function cValAbre(c_Tipo) 
                       
Local cRet 		:= '' 
Local cNomCrit	:= ''
Local nX 		:= 1

//Campo BTS_XABSIB identifica beneficiários cuja abreviação foi entregue na sede da ANS e obteve retorno de que a 
//abreviação está correta e que foi incluída na base deles (por isso não precisa validar se estiver como .T.)
//Obs: Função lAbreAlSIB ponteira na BTS corrente.

If !BTS->BTS_XABSIB  
  
	If c_Tipo == 'MAE'    
	   cNomCrit := nomemae
	Else 
	   cNomCrit := nome
	EndIf  
	                              
	If empty(cNomCrit) .and. ( c_Tipo == 'USUARIO' )     
		cRet := 'Crítica 0101 - Nome de beneficiário é obrigatório;'  
	EndIf    
	 
	For nX := 1 to ( len(cNomCrit) - 2 )
	
	    If 	Substr(cNomCrit ,nX 		, 1) == ' ' .and. ;
	    	Substr(cNomCrit ,nX + 1 	, 1) <> ' ' .and. ;
	    	Substr(cNomCrit ,nX + 2 	, 1) == ' '
	    	
	    	If c_Tipo == 'MAE'
	    		cRet := 'Crítica 0601 - Abreviação identificada [ ' + Substr(cNomCrit ,nX , 3) + ' ] Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
	    	Else 
	        	cRet := 'Crítica 0102 - Abreviação identificada [ ' + Substr(cNomCrit ,nX , 3) + ' ] Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
	        EndIf
	        
	        Exit 
	                            
	    EndIf
	        
	    If Substr(cNomCrit ,nX , 1) $ "-_|/':@“”*/{}$^[]\&!=?+<>()%.;#~,0123456789"  
	    
	        If c_Tipo == 'MAE'
	    		cRet := 'Crítica 0601 - Caractere Especial [ ' + Substr(cNomCrit ,nX , 1) + ' ] Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
	    	Else
	    		cRet := 'Crítica 0102 - Caractere Especial [ ' + Substr(cNomCrit ,nX , 1) + ' ] Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
	    	EndIf 
	        
	        Exit  
	            
	    EndIf
	    
	Next 
	
EndIf	
      
Return cRet

**************************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
PutSx1(cPerg,"01",OemToAnsi("Arquivo SIB ")			     		,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('sbx     (*.sbx)            | *.sbx | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Sib Inclusao") 	         		,"","","mv_ch2","N",01 ,0,0,"C","","","","","mv_par02","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Sib Retificação") 	         		,"","","mv_ch3","N",01 ,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("Sib Cancelamento") 	       		,"","","mv_ch4","N",01 ,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Sib Reativação") 	         		,"","","mv_ch5","N",01 ,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Sib Mudança") 	             		,"","","mv_ch6","N",01 ,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Mês da Competência atual") 		,"","","mv_ch7","N",02 ,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{'Informe o mês da competência atual, '	,'independente de estar enviando correção de '	,'outras competências'			},{},{}) 
PutSx1(cPerg,"08",OemToAnsi("Ano da Competência atual") 		,"","","mv_ch8","N",04 ,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{'Informe o ano da competência atual, '	,'independente de estar enviando correção de '	,'outras competências'			},{},{}) 
PutSx1(cPerg,"09",OemToAnsi("DesConsidera Critica ")            ,"","","mv_ch9","N",01 ,0,0,"C","","","","","mv_par09","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"10",OemToAnsi("Tipo Sib ") 	                    ,"","","mv_ch10","N",01 ,0,0,"C","","","","","mv_par10","Sib Mensal","","","","Sib Global","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"11",OemToAnsi("Sequencial  ") 		            ,"","","mv_ch11","N",02 ,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{'Informe o sequencial do sib ,       '	,' Na competencia e por tipo, O sib do mês   ' ,'Sera sempre (zero),o Global sera 1 em diante'	},{},{}) 
PutSx1(cPerg,"12",OemToAnsi("Arq. De Env. sib ")                ,"","","mv_ch12","N",01 ,0,0,"C","","","","","mv_par12","Não","","","","Sim","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.T.)

Return

***********************************************************************************************************************     

Static Function cCritSIB(cCampo,cOrigem)

Local cCritica 		:= ''
Local nI			:= 0

//****************************************************************************
//Criticas X0XX - Críticas customizadas Caberj e Integral
//****************************************************************************
//- IMPLEMENTADAS: X001, X002, X003, X004, X005, X006 , XXXX
//****************************************************************************

Do Case                               

 	Case ( cCampo == 'USUARIO' )
	
		If ( cOrigem == 'INC' ) .and. ( !empty(GetCpoTab('SIB', 'SIB_CODCCO')) )
			
			cCritica += 'Crítica X001 - Matrícula existente na ANS em registro de inclusão. Operação SIB [ ' + cOrigem + ' ]. CCO [ ' + GetCpoTab('SIB', 'SIB_CODCCO') + ']. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ]. Situação ANS [ ' + GetCpoTab('SIB', 'SIB_SITUAC') + ' ];'
					
		EndIf
		
		If ( cOrigem == 'RETIF' ) .and. empty(GetCpoTab('BA1', 'BA1_CODCCO'))
			
			cCritica += 'Crítica X002 - CCO não existente na ANS em registro de retificação. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
		EndIf
		
		If ( cOrigem $ 'INC|RETIF' ) 

			If ( cpf == '78241114400' )
	
				cCritica += 'Crítica X003 - CPF [ ' + cpf + ' ] inválido (usado no TRF). Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			ElseIf ( cpf $ ( 	Replicate('0',11) + '|' + ;
								Replicate('1',11) + '|' + ;
								Replicate('2',11) + '|' + ;
								Replicate('3',11) + '|' + ;
								Replicate('4',11) + '|' + ;
								Replicate('5',11) + '|' + ;
								Replicate('6',11) + '|' + ;
								Replicate('7',11) + '|' + ;
								Replicate('8',11) + '|' + ;
								Replicate('9',11) ) )
			
				cCritica += 'Crítica X004 - CPF [ ' + cpf + ' ] inválido (todos os dígitos iguais). Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		
			End If
	
		End If	
			
		If ( cOrigem == 'REATI' )
				
			//Chamado - ID: 28566
			
			c__motBlo := cMotBloMat(codBenef) //Código de bloqueio no Protheus
			c__motBlo := cBloqANS(c__motBlo)  //Converte para o bloqueio na ANS
			
			If !( c__motBlo $ '41|42|43' ) 
			
				//41- Rompimento do contrato por iniciativa do beneficiário;
				//42- Desligamento da empresa (planos coletivos)
				//43- Inadimplência.
				
				cCritica += 'Crítica X005 - Motivo de bloqueio [ ' + c__motBlo + ' ] não permite reativação. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
			
		EndIf	
	
	Case ( cCampo == 'CNS' )
	
		If ( cOrigem $ 'INC|RETIF' ) .and. ( cns == '755839261740000' )
	
			cCritica += 'Crítica X006 - CNS [ ' + cns + ' ] inválido (usado no TRF). Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
	
		End If                                              
		

/*	Case ( cCampo == 'numPlaANS' )
        
			If ( cOrigem $ "INC|RETIF" ) .and. empty(numPlaANS)
				
					cCritica := 'Crítica XXXX - numPlaANS [ ' + numPlaANS + ' ] inválido. Operação SIB [ ' + cOrigem + ' ]. Cod Plano. [ ' + numPlaANS + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
                
            EndIf     
*/				
 End Case 	

//****************************************************************************

Do Case
	
	//****************************************************************************
	//Criticas 01XX - Nome Beneficiário
	//****************************************************************************
	//- IMPLEMENTADAS: 0101, 0102
	//****************************************************************************
	
	Case ( cCampo == 'USUARIO' )
	
	
		If !( cOrigem $ 'CANCE|REATI|MUDC' ) 
			
			cCritica += cValAbre(cCampo)
			
		EndIf
			
		If !empty(nome) .and. ( len(trim(nome)) <= 3 )
		
			cCritica += 'Crítica XXX7 de schema: tamanho do campo [ ' + cCampo + ' ] deve ter no mínimo 3 caracteres. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Conteúdo do campo [ ' + nome + ' ];'
			
		EndIf	
		
	//****************************************************************************
	//Criticas 02XX - Data de nascimento
	//****************************************************************************
	//- IMPLEMENTADAS: 0204
	//****************************************************************************
	
	Case ( cCampo == 'DTNASC' )
	      
		If cOrigem $ "INC|RETIF"
	
			//Crítica 0204 - Data de nascimento deve ser anterior ou igual ao último dia do mês da competência de referência  
	 		If ( Substr(DtNasc,7,4) + Substr(DtNasc,4,2) ) > ( StrZero(mv_par08,4) + StrZero(mv_par07,2) )
	 //		If ( Substr(DtNasc,7,4) + Substr(DtNasc,4,2) ) > ( dDatcomp )

			
				cCritica += 'Crítica 0204 - Data de nascimento [ ' + DtNasc + ' ] superior a competência atual informada [ ' + ( StrZero(mv_par07,2) + '/' + StrZero(mv_par08,4) ) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'  
//				cCritica += 'Crítica 0204 - Data de nascimento [ ' + DtNasc + ' ] superior a competência atual informada [ ' + ( substr(dDatcomp,5,2) + '/' + substr(dDatcomp,1,4) ) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
		
		EndIf	
	
	//****************************************************************************
	//Criticas 03XX - Sexo
	//****************************************************************************
	
	//****************************************************************************
	//Criticas 04XX - CPF
	//****************************************************************************
	//- IMPLEMENTADAS: 0401, 0403, 0408, 0410
	//****************************************************************************
	
	Case ( cCampo == 'CPF' )
	
		If !( cOrigem $ 'CANCE|REATI|MUDC' ) 
			
			If empty(cpf) .and. ( cOrigem == 'INC' ) .and. ( relDepen == '1 ' ) //É titular
		   	  	cCritica += 'Crítica 0401 - CPF obrigatório para titular na inclusão. Matr. [ ' + codBenef + ' ];'
		   	EndIf   
		   	
			If empty(cpf) .and. ( cOrigem $ "INC|RETIF" ) .and. ( relDepen <> '1 ' )//Não é titular
				
				If empty(GetCpoTab('BA1', 'BA1_DATNAS'))
					cCritica += 'Data de nascimento vazia na BA1. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				ElseIf Calc_Idade(dDataBase,StoD(GetCpoTab('BA1', 'BA1_DATNAS'))) >= 18
		   	    	cCritica += 'Crítica 0403 - CPF é obrigatório para beneficiário dependente com idade igual ou superior a 18 anos. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		   	    ElseIf empty(cns) .and. empty(PisPasep) .and. empty(nomeMae)
		   	    	cCritica += 'Crítica 0408 - CPF ou Nome da Mãe ou CNS ou PIS/PASEP, um deles é obrigatório para dependente menor de idade. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		   	    EndIf
		   	    
		  	EndIf
		  	
	   		If 	cOrigem <> 'RETIF'
	   		
	   			For nI := 1 to 2 //1: confere na base da ANS; 2: confere no próprio arquivo gerado
	   			
			   		cAl0410 	:= GetNextAlias()
				
					cQry0410 	:= "SELECT SIB_MATRIC, BA1_DATBLO, BA1_LOCSIB, BA1_DATINC, BA1_MOTBLO,"					+ CRLF
					cQry0410 	+= "       CASE WHEN TRIM(BA1_MOTBLO) IS NULL THEN '   ' ELSE "							+ CRLF
					cQry0410 	+= "           NVL(("																	+ CRLF
					cQry0410 	+= "           SELECT BG3_BLQANS"														+ CRLF
					cQry0410 	+= "           FROM " + RetSqlName('BG3') 												+ CRLF
					cQry0410 	+= "           WHERE BG3_FILIAL = '" + xFilial('BG3') + "'"								+ CRLF
					cQry0410 	+= "              AND BG3_CODBLO = BA1_MOTBLO"											+ CRLF
					cQry0410 	+= "              AND BG3_TIPBLO = '0'"													+ CRLF
					cQry0410 	+= "              AND D_E_L_E_T_ = ' '"													+ CRLF
					cQry0410 	+= "           ),'   ')"																+ CRLF
					cQry0410 	+= "       END CODBLOQ_ANS"																+ CRLF
					cQry0410 	+= "FROM " + If(nI == 1,cTab,cTabXML)													+ CRLF
					cQry0410 	+= "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1_FILIAL = '" + xFilial('BA1') + "'"	+ CRLF
					cQry0410 	+= "   	AND BA1_CODINT = SUBSTR(SIB_MATRIC,1,4)"										+ CRLF
					cQry0410 	+= "	AND BA1_CODEMP = SUBSTR(SIB_MATRIC,5,4)"										+ CRLF
					cQry0410 	+= "  	AND BA1_MATRIC = SUBSTR(SIB_MATRIC,9,6)"										+ CRLF
					cQry0410 	+= "  	AND BA1_TIPREG = SUBSTR(SIB_MATRIC,15,2)"										+ CRLF
					cQry0410 	+= "  	AND BA1_DIGITO = SUBSTR(SIB_MATRIC,17,1)"										+ CRLF
					cQry0410 	+= "   	AND D_E_L_E_T_ = ' '"															+ CRLF
				    cQry0410 	+= "WHERE SIB_NUMPLA = '" + numPlaANS + "'"												+ CRLF
				    
				    If nI == 1
				    	cQry0410 	+= "    AND SIB_SITUAC = '1'"														+ CRLF
				     Else
				    	cQry0410 	+= "	AND SIB_OPERACAO = 'INCLUSAO'"												+ CRLF
				    	cQry0410 	+= "	AND SIB_MATRIC <> '" + codBenef + "'"										+ CRLF
				    EndIf
				    
				    c_Descri := ''
				    
				    Do Case
				    
					    Case !empty(cpf)
					    	cQry0410 	+= "   AND SIB_CPFUSR = '" + cpf + "'"											+ CRLF
					    	c_Descri 	:= 'cpf [ ' + PadR(cpf,12,' ') + ' ]'
					    
					    Case !empty(cns)
					    	cQry0410 	+= "   AND SIB_CNS = '" + cns + "'"												+ CRLF
					    	c_Descri 	:= 'CNS [ ' + cns + ' ]'
					    
					    Case !empty(PisPasep)
					    	cQry0410 	+= "   AND SIB_PISPAS = '" + PisPasep + "'"										+ CRLF
					    	c_Descri 	:= 'Pis/Pasep [ ' + PisPasep + ' ]'
					    
					    Case !empty(nomeMae)
					    	cQry0410 	+= "   AND SIB_MAE LIKE '" + Alltrim(Upper(nomeMae)) + "%'"						+ CRLF
					    	c_Descri 	:= 'Nome da mãe [ ' + Alltrim(Upper(nomeMae)) + ' ]'
					    
					    Otherwise
					    	cQry0410 	+= "   AND SIB_CPFUSR = '" + cpf + "'"											+ CRLF
					    	c_Descri 	:= 'cpf [ ' + PadR(cpf,12,' ') + ' ]'
					    
				    End Case
				    
				    //Localizei casos na base da ANS que estão vazios e que foram criticados no retorno do processamento da ANS 
				    cQry0410 	+= "   AND SIB_CGCEMP IN ( '" + CnpjEmpCont + "' , ' ' )"								+ CRLF
				    
				    TcQuery cQry0410 New Alias cAl0410
				    
				    If !cAl0410->(EOF())
				    	cCritica := 'Crítica 0410 - Já existe registro ativo com o mesmo ' + c_Descri + ', plano [ ' + PadR(numPlaANS,9,' ') + ' ] e empresa contratante [ ' + PadR(CnpjEmpCont,14,' ') + ' ] na operadora. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ], inclusão [ ' + GetCpoTab('BA1', 'BA1_DATINC') + ' ] e bloqueio [ ' + GetCpoTab('BA1', 'BA1_DATBLO') + ' ] . Matr. com mesmos dados [ ' + cAl0410->SIB_MATRIC + ' ]. Situação cadastro duplicado [ ' + cAl0410->BA1_LOCSIB + ' ]. Inclusão matr. mesmos dados [ ' + cAl0410->BA1_DATINC  + ' ]. Bloqueio matr. mesmos dados [ ' + cAl0410->BA1_DATBLO + ' ]. Motivo bloqueio matr. mesmos dados [ ' + cAl0410->BA1_MOTBLO + ' ]. Código bloqueio ANS matr. mesmos dados [ ' + cAl0410->CODBLOQ_ANS + ' ]. Tabela [ ' + If(nI == 1,cTab,cTabXML) + ' ];'
				    EndIf   
				    
				    cAl0410->(DbCloseArea())
				    
			    Next
			    		
		   	EndIf
		   	
		EndIf
	
	//****************************************************************************
	//Criticas 05XX - PIS/PASEP
	//****************************************************************************
	//- IMPLEMENTADAS: 0501
	//****************************************************************************
	
	Case ( cCampo == 'PISPAS' )
               
               
        If lPisPasep//Verifico se existe a tag
        
			If ( cOrigem $ "INC|RETIF" )	
			
				If empty(PisPasep)
				
					cCritica := 'Crítica 0501 - PIS/PASEP [ ' + PisPasep + ' ] inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
				ElseIf len(AllTrim(PisPasep)) <> 11
				
					cCritica := 'Crítica 0501 - PIS/PASEP [ ' + PisPasep + ' ] inválido. Quantidade de dígitos diferente de 11. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
				ElseIf !empty(AllTrim(cRemovDig(PisPasep)))
				
					cCritica := 'Crítica 0501 - PIS/PASEP [ ' + PisPasep + ' ] inválido. Caracteres não númericos localizados [ ' + AllTrim(cRemovDig(PisPasep)) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
				ElseIf !u_lVldPisPasep(PisPasep)
				
					cCritica := 'Crítica 0501 - PIS/PASEP [ ' + PisPasep + ' ] inválido. Dígito verificador inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
					
				EndIf
	
			EndIf
			
		EndIf

	//****************************************************************************
	//Criticas 06XX - Nome mãe
	//****************************************************************************
	//- IMPLEMENTADAS: 0601
	//****************************************************************************
	
	Case ( cCampo == 'MAE' )
	
		If !( cOrigem $ 'CANCE|REATI|MUDC' ) 
			
			If empty(cCampo) .and. ( cOrigem == 'INC' )
				
				cCritica += 'Crítica 0601 - Nome da mãe não declarado em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
			
			Else
			
				If !empty(nomeMae)
				
					If ( len(trim(nomeMae)) <= 3 )
					
						cCritica += 'Crítica XXX8 de schema: tamanho do campo [ ' + cCampo + ' ] deve ter no mínimo 3 caracteres. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Conteúdo do campo [ ' + nomeMae + ' ];'
					
					ElseIf AllTrim(Upper(nomeMae)) $ 'NAO DECLARADO|SEM REGISTRO|NAO TEM|IGNORADO|IGNORADA|SEM INFORMACAO|NAO INFORMADO'
					
						cCritica += 'Crítica 0601 - Nome da mãe inválido em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
						
					ElseIf At('PENDENTE',AllTrim(Upper(nomeMae))) > 0
					
						cCritica += 'Crítica 0601 - Nome da mãe inválido em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
					
					ElseIf At('INFORMACAO',AllTrim(Upper(nomeMae))) > 0
					
						cCritica += 'Crítica 0601 - Nome da mãe inválido em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
					
					ElseIf At('CLIENTE',AllTrim(Upper(nomeMae))) > 0
					
						cCritica += 'Crítica 0601 - Nome da mãe inválido em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
					
					//Nome da mãe não pode ter apenas 1 nome (pelo menos 1 espaço entre 2 nomes)
					ElseIf ( At(Space(1),AllTrim(nomeMae)) <= 0 )
					
						cCritica += 'Crítica 0601 - Nome da mãe deve ter sobrenome em inclusão. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ];'
					
					EndIf
				
				EndIf
				
				//Crítica 0601 - Abreviação identificada
				cCritica += cValAbre(cCampo) 
				
			EndIf        	
	
		EndIf
		                                             
	//****************************************************************************
	//Criticas 07XX - CNS
	//****************************************************************************
	//- IMPLEMENTADAS: 0701
	//****************************************************************************
	
	Case ( cCampo == 'CNS' )
	
		If ( cOrigem $ "INC|RETIF" )        
			
			//Solicitado pela Lúcia Souza em 02/06/16 para todos os casos de CNS
			//INFORMADO pela cristiana  em 09/04/19 que a ans nao critica cns em branco.
            //mantido a critica para tratamento pontual pelo usuario  
	        If empty(cns)
			
				cCritica += 'Crítica 0701 - CNS [ ' + cns + ' ] vazio inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			ElseIf len(AllTrim(cns)) <> 15
					
				cCritica += 'Crítica 0701 - CNS [ ' + cns + ' ] tamanho inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			ElseIf !empty(AllTrim(cRemovDig(cns)))
					
				cCritica += 'Crítica 0701 - CNS [ ' + cns + ' ] com caracteres inválidos. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			ElseIf !lVldCNS(cns)
					
				cCritica += 'Crítica 0701 - CNS [ ' + cns + ' ] inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			ElseIf !U_lCNSValido(cns)//Valida a estrutura do CNS conforme instruções do DATASUS
			
				cCritica += 'Crítica 0701 - CNS [ ' + cns + ' ] inválido. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
						
			EndIf
				    	
		EndIf
	
	//****************************************************************************
	//Criticas 08XX - Código de Identificação do Beneficiário (Matrícula)
	//****************************************************************************
	//- IMPLEMENTADAS: 0802
	//****************************************************************************
	
	Case ( cCampo == 'MATRIC' )
	
		If cOrigem == "INC"         
		                
			cAlMatr := GetNextAlias()
			
			cQryMat := "SELECT SIB_CODCCO"												+ CRLF
			cQryMat += "FROM " + cTab													+ CRLF
			cQryMat += "WHERE SIB_MATRIC = '" + CodBenef + "'"							+ CRLF
		    cQryMat += "   AND SIB_CODCCO <> ' '"										+ CRLF
		    
		    TcQuery cQryMat New Alias cAlMatr
		    
		    If !cAlMatr->(EOF())
		    	cCritica += 'Crítica 0802 - Código de identificação do beneficiário já existe no cadastro para a operadora informada. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ]. CCO base ANS. [ ' + cAlMatr->SIB_CODCCO + ' ];'
		    EndIf   
		    
		    cAlMatr->(DbCloseArea()) 
		    
		ElseIf cOrigem == "RETIF"         
		                
			cAlMatr := GetNextAlias()
			
			cQryMat := "SELECT SIB_MATRIC"												+ CRLF
			cQryMat += "FROM " + cTab													+ CRLF
			cQryMat += "WHERE SIB_MATRIC <> '" + CodBenef + "'"							+ CRLF
		    cQryMat += "   AND SIB_CODCCO = '" + GetCpoTab('BA1', 'BA1_CODCCO') + "'"	+ CRLF
		    cQryMat += "   AND SIB_CODCCO <> ' '"										+ CRLF
		    
		    TcQuery cQryMat New Alias cAlMatr
		    
		    If !cAlMatr->(EOF())
		    	cCritica += 'Crítica 0802 - Código de identificação do beneficiário já existe no cadastro para a operadora informada. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ]. CCO [ ' + GetCpoTab('BA1', 'BA1_CODCCO') + ' ]. Matr. base ANS com mesmo CCO [ ' + cAlMatr->SIB_MATRIC + ' ];'
		    EndIf   
		    
		    cAlMatr->(DbCloseArea()) 
		
		EndIf
	
	//****************************************************************************
	//Criticas 09XX - Número do Plano (RPS) - Registro de Plano de Saúde
	//****************************************************************************
	//- IMPLEMENTADAS: 0905, 0906
	//****************************************************************************
	
	Case ( cCampo == 'PLANO' )
	
		If cOrigem == "MUDC"         
			
			If AllTrim(numPlaANS) == GetCpoTab('SIB', 'SIB_NUMPLA')
			
				cCritica += 'Crítica 0905 - Número do plano [ ' + numPlaANS + ' ] RPS não pode ser o mesmo existente no cadastro [ ' + GetCpoTab('SIB', 'SIB_NUMPLA') + ' ] em mudança contratual. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			EndIf
			
		EndIf
	
		If cOrigem == "RETIF"         
			
			If 	!empty(numPlaANS) .and. ( AllTrim(numPlaANS) <> GetCpoTab('SIB', 'SIB_NUMPLA') ) .and. ;
				!empty(Replace(Replace(dtContra,'/',''),'-','')) .and. ( ( Substr(dtContra,7,4) + Substr(dtContra,4,4) ) <> GetCpoTab('SIB', 'SIB_DATCON') )
			
				cCritica += 'Crítica 0906 - Número do plano [ ' + numPlaANS + ' ] RPS e data de contratacão [ ' + dtContra + ' ] diferentes dos existentes no cadastro [ Plano: ' + GetCpoTab('SIB', 'SIB_NUMPLA') + '; Data Contratação:' + GetCpoTab('SIB', 'SIB_DATCON') + ' ] caracterizam uma mudança contratual e não retificação. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
		
		EndIf
		
	//****************************************************************************
	//Criticas 10XX - Plano (SCPA) - Sistema de Cadastro de Planos Antigos
	//****************************************************************************
	//Criticas 11XX - Número do plano RPS de origem (PORTABILIDADE) 
	
	//****************************************************************************
	//Criticas 12XX - Data Contratação
	//****************************************************************************
	//- IMPLEMENTADAS: 1205, 1213, 1214, 1218, 1220
	//****************************************************************************
	
	Case ( cCampo == 'DATCON' )
	
		If cOrigem $ "MUDC|INC|RETIF"
		
			//Crítica 1205 - Data de contratação deve ser anterior ou igual ao último dia do mês da competência de referência. 
			If ( Substr(dtContra,7,4) + Substr(dtContra,4,2) ) > ( dDatcomp )

				cCritica += 'Crítica 1205 - Data de contratação [ ' + dtContra + ' ] superior a competência atual informada [ ' + ( StrZero(mv_par07,2) + '/' + StrZero(mv_par08,4) ) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];' 
//				cCritica += 'Crítica 1205 - Data de contratação [ ' + dtContra + ' ] superior a competência atual informada [ ' + ( substr(dDatcomp,5,2) + '/' + substr(dDatcomp,1,4)) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'				
				
			EndIf 
			
			If 	( ( Substr(dtContra,7,4) + Substr(dtContra,4,4) ) > GetCpoTab('SIB', 'SIB_DATCON') .and. !empty(GetCpoTab('SIB', 'SIB_DATCON')) ) .or.;
				( ( Substr(dtContra,7,4) + Substr(dtContra,4,4) ) > GetCpoTab('SIB', 'SIB_DATCAN') .and. !empty(GetCpoTab('SIB', 'SIB_DATCAN')) )
				
				cCritica += 'Crítica 1214 - Data de contratação [ ' + dtContra + ' ] deve ser anterior ou igual a menor data existente no cadastro: data histórico [ ' + DtoC(StoD(GetCpoTab('SIB', 'SIB_DATCON'))) + ' ] ou data cancelamento [ ' + DtoC(StoD(GetCpoTab('SIB', 'SIB_DATCAN'))) + ' ] ou data de reativação ou data de inclusão [ ' + DtoC(StoD(GetCpoTab('SIB', 'SIB_DATCON'))) + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
                                                          
		    EndIf                     
		    
		    If ( Substr(DtNasc,7,4) + Substr(DtNasc,4,2) ) > ( Substr(dtContra,7,4) + Substr(dtContra,4,2) )
			
		 		cCritica += 'Crítica 1218 - Data de nascimento [ ' + DtNasc + ' ] deve ser anterior ou igual a data da primeira contratação  [ ' + dtContra + ' ] do plano. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		 		
		 	EndIf     
		    
		EndIf 		
		
		If cOrigem == "RETIF"         
			
			If 	!empty(numPlaANS) .and. ( AllTrim(numPlaANS) <> GetCpoTab('SIB', 'SIB_NUMPLA') ) .and. ;
				!empty(Replace(Replace(dtContra,'/',''),'-','')) .and. ( ( Substr(dtContra,7,4) + Substr(dtContra,4,4) ) <> GetCpoTab('SIB', 'SIB_DATCON') )
			
				cCritica += 'Crítica 1213 - Número do plano [ ' + numPlaANS + ' ] (RPS OU SCPA) e data de contratacão [ ' + dtContra + ' ] diferentes dos existentes no cadastro [ Plano: ' + GetCpoTab('SIB', 'SIB_NUMPLA') + '; Data Contratação:' + GetCpoTab('SIB', 'SIB_DATCON') + ' ] caracterizam uma mudança contratual e não retificação. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
		
		EndIf
		
		If cOrigem == 'CANCE' 
		
			If dtContra > dtCancel
			
				cCritica += 'Crítica 1220 - Data de cancelamento [ ' + dtCancel + ' ] deve ser posterior ou igual a maior data informada ou existente no cadastro: data histÓrico ou data reativaÇÃo (se registro i ivo) ou data contrataÇÃo [ ' + dtContra + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		    
		    Else // inicio  altamiro 03/12/2018
		    
		       cQuery := "SELECT *" 											+ CRLF
               cQuery += "FROM " + RetSqlName('BA1')							+ CRLF 
               cQuery += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'"			+ CRLF 

               cQuery += "  AND BA1_CODCCO = '" + cCCO + "'"			 		+ CRLF

               cQuery += "  AND D_E_L_E_T_ = ' '"								+ CRLF 

               TcQuery cQuery New Alias cAliasBA12

               If !cAliasBA12->(EOF())
                  
                  If  cAliasBA12->ba1_datinc >= substr(dtCancel,7,4)+substr(dtCancel,4,2)+substr(dtCancel,1,2)
            
  			     	  cCritica += 'Crítica XXX9 - Data  de cancelamento [ ' + dtCancel + ' ] igual a Data de inclusao data contrataÇÃo [ ' + cAliasBA12->ba1_datinc + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
	
                  EndIf       
                                                               
                  cAliasBA12->(DbCloseArea())          
               EndIf
		    
            EndIf // fim altamiro 03/12/2018 
        
        EndIf        
	
	//****************************************************************************
	//Criticas 13XX - Relação Dependência 
	//****************************************************************************
	//Criticas 14XX - Código de Cobertura Parcial Temporária 
	//****************************************************************************
	//Criticas 15XX - Código de Itens Excluídos Cobertura
	
	//****************************************************************************
	//Criticas 16XX - CNPJ Empresa Contratante
	//****************************************************************************
	//- IMPLEMENTADAS: 1602, 1604
	//****************************************************************************
	
	Case ( cCampo == 'CNPJEMP' ) 
	
		//RN 295 Art. 20. As operadoras devem enviar para a ANS a informação sobre o número de inscrição no 
		//Cadastro Nacional de Pessoa Jurídica (CNPJ), ou, conforme o caso, no Cadastro Específico do INSS (CEI), 
		//dos contratantes de planos coletivos empresariais ou de planos coletivos por adesão.
			
		If cOrigem == "INC"
	
			If empty(CnpjEmpCont) .and. empty(CeiEmpCont)
			
				//Crítica 1602 - CNPJ ou CEI da empresa contratante, um deles deve existir para plano coletivo.
				cCritica += 'Crítica 1602 - CNPJ ou CEI da empresa contratante, um deles deve existir para plano coletivo. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];''
		    		
			ElseIf !CGC(CnpjEmpCont,,.F.)
			
				//Crítica 1604 - CNPJ da empresa contratante inválido
				cCritica += 'Crítica 1604 - CNPJ da empresa contratante inválido. Operação SIB [ ' + cOrigem + ' ]. CNPJ [ ' + CnpjEmpCont + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];''
		    	
			EndIf	
			
		ElseIf cOrigem $ "MUDC|REATI"
		
			If empty(GetCpoTab('SIB', 'SIB_CGCEMP'))
			
				//Crítica 1602 - CNPJ ou CEI da empresa contratante, um deles deve existir para plano coletivo.
				cCritica += 'Crítica 1602 - CNPJ ou CEI da empresa contratante, um deles deve existir para plano coletivo. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];''
			    	
			EndIf
			
		EndIf	
	
	//****************************************************************************
	//Criticas 17XX - CEI Empresa Contratante
	
	//****************************************************************************
	//Criticas 18XX - Código de Identificação de Beneficiário Titular 
	//****************************************************************************
	//- IMPLEMENTADAS: 1801, 1802, 1803
	//****************************************************************************
	
	Case ( cCampo == 'MATTIT' )  
	
		If cOrigem $ "INC|RETIF"
	
			If ( relDepen <> '1 ' ) .and. ( Substr(codBenef,15,2) <> '00' ) // .and. BA1_TIPUSU <> 'T'//Nao e titular
			
		    	If empty(CodbenTit) .and. ( cOrigem == "INC" )
		    		
		    		//Crítica 1801 - Codigo de identificacao do titular e obrigatorio para beneficiario dependente
		    		cCritica += 'Crítica 1801 - Dependente sem a tag titular ou tag vazia - Verificar titular do dependente [ ' + codBenef + ' ];'
		    		
		    	EndIf
		
				//Critica 1802 (Codigo de identificacao do titular nao pertence a operadora informada) e 
				//        1803 (Codigo de identificacao de beneficiario titular nao pertence a um beneficiario titular)
				If !u_lTitularOk(codBenef, CodbenTit)
		    		
		    		cCritica += 'Crítica 1802|1803 - Problema com o titular - Verificar matrícula do titular [ ' + CodbenTit + ' ] Dep [ ' + codBenef + ' ];'
					
				EndIf
		    	
		    EndIf
		    
		/*    
		ElseIf cOrigem $ "MUDC|REATI"
		    
		    If ( GetCpoTab('SIB', 'SIB_MATRIC') <> '1' ) 
		    
//		    	SIB_GRAUPA:
//				01 - beneficiário titular
//				03 - cônjuge/companheiro
//				04 - filho/filha
//				06 - enteado/enteada
//				08 - pai/mãe
//				10 - agregado/outros
			
		    	SIB_MATRIC	CHAR(17)  path 'vinculo/codigoBeneficiario', 
                SIB_GRAUPA
			    
			    //Crítica 1801 - Codigo de identificacao do titular e obrigatorio para beneficiario dependente
			    cCritica += 'Crítica 1801 - Dependente sem a tag titular ou tag vazia - Verificar titular do dependente [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ];'
			    
			EndIf
		*/  
		  		
		EndIf
	
	//****************************************************************************
	//Criticas 19XX - Não existe
	
	//****************************************************************************
	//Criticas 20XX - Data de Reativação
	//****************************************************************************
	//- IMPLEMENTADAS: 2004, 2009, 2010, 2013
	//****************************************************************************
	
	Case ( cCampo == 'DATREAT' ) 
			
		If cOrigem == 'RETIF'
		
			If 	( !empty(GetCpoTab('SIB', 'SIB_DATCAN')) .and.;
		 		( ( Right(dtReat,4) + Substr(dtReat,4,2) + Left(dtReat,2) ) > GetCpoTab('SIB', 'SIB_DATCAN') ) ) .or.;
		 		( !empty(GetCpoTab('SIB', '_SIB_DTREAT')) .and.;
		 		( ( Right(dtReat,4) + Substr(dtReat,4,2) + Left(dtReat,2) ) > GetCpoTab('SIB', '_SIB_DTREAT') ) )		 		
			
			 	//Conforme ANS: "No procedimento de RETIFICAÇÃO, indica que o campo Data de Reativação foi informado no XML ou consta no cadastro
				//de beneficiários da operadora junto à ANS com valor maior que a Data de Cancelamento ou da Data da última Reativação"
				
				cCritica += 'Crítica 2009 - Data de Reativação [ ' + DtoS(CtoD(dtReat)) + ' ] deve ser anterior ou igual a menor data informada ou existente no cadastro: Data de Cancelamento [ ' + GetCpoTab('SIB', 'SIB_DATCAN') + ' ] (se registro ativo) ou Data da última Reativação [ ' + GetCpoTab('SIB', '_SIB_DTREAT') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
		
			If ( ( Right(dtReat,4) + Substr(dtReat,4,2) + Left(dtReat,2) ) == GetCpoTab('SIB', 'SIB_DATCON') )
			
				cCritica += 'Crítica 2010 - Não existe informação de reativação [ ' + GetCpoTab('SIB', '_SIB_DTREAT') + ' ] no cadastro para ser retificada. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			EndIf
			
		EndIf
		
		If cOrigem == 'REATI'
		
			If cAliasSIB->(EOF())
			
				cCritica += 'Crítica XX10 - Data de Reativação [ ' + dtReat + ' ] e beneficiário não existe na ANS. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			ElseIf GetCpoTab('SIB', 'SIB_SITUAC') <> '3'
		
				cCritica += 'Crítica XX10 - Data de Reativação [ ' + dtReat + ' ] com registro não está cancelado na ANS. Status ANS [ ' + GetCpoTab('SIB', 'SIB_SITUAC') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
	
			Else
			
				If ( Right(dtReat,4) + Substr(dtReat,4,2) + Left(dtReat,2) ) < GetCpoTab('SIB', 'SIB_DATCAN')
			
					cCritica += 'Crítica 2004 - Data de Reativação [ ' + dtReat + ' ] deve ser posterior ou igual à Data de Cancelamento  [ ' + DtoC(Stod(GetCpoTab('SIB', 'SIB_DATCAN')))  + ' ] existente no cadastro em reativação. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
					
				EndIf
				
			EndIf
			
			If ( StoD(GetCpoTab('SIB', 'SIB_DATCON')) > CtoD(dtReat) )
				
				cCritica += 'Crítica 2013 - Data de contratação [ ' + DtoC(StoD(GetCpoTab('SIB', 'SIB_DATCON'))) + ' ] deve ser anterior ou igual a menor data existente no cadastro: data histórico ou data cancelamento ou data reativação [ ' + dtReat + ' ] ou data última mudança contratual. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			EndIf			
			
		EndIf
	
	//****************************************************************************
	//Criticas 21XX - Código de Indicação de Endereço
	//****************************************************************************
	//- IMPLEMENTADAS: 2101
	//****************************************************************************
	
	Case ( cCampo == 'INDEND' )  
	
		If cOrigem == 'INC'
		
			If !( AllTrim(tpEnder) $ '12' )
			
				cCritica += 'Crítica 2101 - Código de indicação de endereço [ ' + tpEnder + ' ] deve ter um dos seguintes valores: 1 - profissional, 2 - residencial. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
	    						
	    	ElseIf empty(tpEnder) .and. ( resExt <> '0' )
		
				cCritica += 'Crítica 2101 - Código de indicação de endereço [ ' + tpEnder + ' ] é obrigatório para residentes no Brasil [ ' + resExt + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			EndIf
			
		EndIf
		
	//****************************************************************************
	//Criticas 22XX - Logradouro
	
	//****************************************************************************
	//Criticas 23XX - Número do Logradouro
	
	//****************************************************************************
	//Criticas 24XX - Complemento Logradouro
	
	//****************************************************************************
	//Criticas 25XX - Bairro
	
	//****************************************************************************
	//Criticas 26XX - Código Município
	
	//****************************************************************************
	//Criticas 27XX - CEP
	
	//****************************************************************************
	//Criticas 28XX - Código de Indicação de Residência (Nacional/Exterior)
	
	//****************************************************************************
	//Criticas 29XX - Código Município residência (IBGE)
	
	//****************************************************************************
	//Criticas 30XX - CCO
	//****************************************************************************
	//- IMPLEMENTADAS: 3001, 3004, 3005, 3010, 3011 
	//****************************************************************************
	
	Case ( cCampo == 'CCO' )
	
		If cOrigem <> 'INC'
		
			If Empty(cCCo)
		       cCritica += 'Crítica 3001 - CCO é obrigatório. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];' 
		    EndIf
    
			If cAliasSIB->(EOF())                              
		       cCritica += 'Crítica 3004 - CCO não pertence a operadora informada [ CCO NÃO existe na ANS ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];' 
		    EndIf
		    
		    cAlCCODupl 	:= GetNextAlias()
		    
		    cQryCCODupl := "SELECT COUNT(*)" 								+ CRLF
		    cQryCCODupl += "FROM " + RetSqlName('BA1') 						+ CRLF
		    cQryCCODupl += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 	+ CRLF
		    cQryCCODupl += "   AND BA1_CODCCO = '" + cCCo + "'" 			+ CRLF
		    cQryCCODupl += "   AND D_E_L_E_T_ = ' '" 						+ CRLF
		    cQryCCODupl += "GROUP BY BA1_CODCCO" 							+ CRLF
		    cQryCCODupl += "HAVING COUNT(*) > 1" 							+ CRLF
		    
		    TcQuery cQryCCODupl New Alias cAlCCODupl
		    
		    If !cAlCCODupl->(EOF())
		    	cCritica += 'Crítica XX11 - CCO em duplicidade na base da ' + If(cEmpAnt == '01','Caberj','Integral') + '. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		    EndIf   
		    
		    cAlCCODupl->(DbCloseArea()) 
	    
	    EndIf
	    
	    If cOrigem == 'INC' .and. !empty(cCCo)
	    
	    	cCritica += 'Crítica XX12 - CCO [ ' + cCCo + ' ] preenchido em inclusão. Empresa [ ' + If(cEmpAnt == '01','Caberj','Integral') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('BA1', 'BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
	    	
	    EndIf
	    
		If cOrigem == 'RETIF'	
		
			If !cAliasSIB->(EOF()) 
			
				If 	GetCpoTab('SIB', 'SIB_MATRIC') 	== codBenef 						.and.;
					GetCpoTab('SIB', 'SIB_CPFUSR') 	== cpf 								.and.;
					GetCpoTab('SIB', 'SIB_CNS')	 	== cns 								.and.;
					GetCpoTab('SIB', 'SIB_NOMUSR') 	== nome 							.and.;
					GetCpoTab('SIB', 'SIB_SEXO') 	== If(sexo == 'Feminino','3','1') 	.and.;
					GetCpoTab('SIB', 'SIB_DATNAS') 	== DtoS(CtoD(DtNasc))  				.and.;
					GetCpoTab('SIB', 'SIB_MAE') 	== nomeMae  						.and.;
					GetCpoTab('SIB', 'SIB_ENDERE') 	== lograd 							.and.;
					GetCpoTab('SIB', 'SIB_NR_END') 	== numero 							.and.;
					GetCpoTab('SIB', 'SIB_BAIRRO') 	== bairro 							.and.;
					GetCpoTab('SIB', 'SIB_CODMUN') 	== codMunic  						.and.;
					GetCpoTab('SIB', 'SIB_CEPUSR') 	== cep  							.and.;
					GetCpoTab('SIB', 'SIB_RESEXT') 	== If(resExt == 'Sim','1','0') 		.and.;
					GetCpoTab('SIB', 'SIB_GRAUPA') 	== AllTrim(relDepen)  				.and.;
					GetCpoTab('SIB', 'SIB_DATCON') 	== DtoS(CtoD(dtContra)) 			.and.;
					GetCpoTab('SIB', 'SIB_NUMPLA') 	== numPlaANS  						.and.;
					GetCpoTab('SIB', 'SIB_COBPAR') 	== cobParTmp  						.and.;
					GetCpoTab('SIB', 'SIB_ITEXCO') 	== itExcCob  						.and.;
					GetCpoTab('SIB', 'SIB_CGCEMP') 	== CnpjEmpCont
			 
			    	//Crítica 3011 - Registro referente ao CCO informado contem dados identicos aos existentes no cadastro
					cCritica += 'Crítica 3011 - Retificação com dados iguais aos da ANS. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
				EndIf
				
			Else
				//Crítica 3010 - Nao existem informacoes de cancelamento de cadastro para ser Retificada
				cCritica += 'Crítica 3010 - Retificação e matrícula não existe na ANS. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			EndIf 

		EndIf
		
//		If cOrigem == 'CANC'  -- ALTAMIRO	19/05/2016
		If cOrigem == 'CANCE'
		
			If !cAliasSIB->(EOF()) 
			
				If GetCpoTab('SIB', 'SIB_SITUAC') <> '1'
				
					cCritica += 'Crítica 3005 - O CCO [ ' + cCCo + ' ] informado já se encontra inativo no cadastro. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
				EndIf
				
			EndIf
			
		EndIf	
	
	//****************************************************************************
	//Criticas 31XX - Data Cancelamento
	//****************************************************************************
	//- IMPLEMENTADAS: 3101, 3104, 3105, 3114 
	//****************************************************************************
	
	Case ( cCampo == 'DTCANC' )
	
		If cOrigem == 'CANCE' 
			
			If empty(dtCancel)
			
				cCritica += 'Crítica 3101 - Data de cancelamento [ ' + dtCancel + ' ] é obrigatória. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
		  
            ElseIf ( ( Right(dtCancel,4) + Substr(dtCancel,4,2) + Left(dtCancel,2) ) < GetCpoTab('SIB', 'SIB_DATCON') ) 
            
            	cCritica += 'Crítica 3104 - Data de cancelamento [ ' + Right(dtCancel,4) + Substr(dtCancel,4,2) + Left(dtCancel,2) + ' ] deve ser posterior ou igual a data de contratação [ ' + GetCpoTab('SIB', 'SIB_DATCON') + ' ]. Registro tabela histórico bloqueios BCA [ ' + PadR(cValToChar(nBCABloqANS(GetCpoTab('SIB', 'SIB_MATRIC'))),10,' ') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			ElseIf	( ( Right(dtCancel,4) + Substr(dtCancel,4,2) + Left(dtCancel,2) ) < GetCpoTab('SIB', '_SIB_DTREAT') )
			
				cCritica += 'Crítica 3105 - Data de cancelamento [ ' + Right(dtCancel,4) + Substr(dtCancel,4,2) + Left(dtCancel,2) + ' ] deve ser posterior ou igual a data de reativação  [ ' + GetCpoTab('SIB', '_SIB_DTREAT') + ' ] em registros de cancelamento. Registro tabela histórico bloqueios BCA [ ' + PadR(cValToChar(nBCABloqANS(GetCpoTab('SIB', 'SIB_MATRIC'))),10,' ') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + GetCpoTab('SIB', 'SIB_MATRIC') + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
			
			EndIf
		
		EndIf
		
		If cOrigem == 'RETIF'
				
			If ( !empty(CtoD(dtCancel)) ) .and. ( GetCpoTab('SIB', 'SIB_SITUAC') == '1' )
			
				cCritica += 'Crítica 3114 - Retificação com data de bloqueio [ ' + dtCancel + ' ] e beneficiário se encontra ativo na ANS [ ' + GetCpoTab('SIB', 'SIB_SITUAC') + ' ]. Operação SIB [ ' + cOrigem + ' ]. Matr. [ ' + codBenef + ' ]. Situação cadastro [ ' + GetCpoTab('BA1', 'BA1_LOCSIB') + ' ];'
				
			EndIf
		 
		EndIf
	
	//****************************************************************************
	//Criticas 32XX - Código do Motivo Cancelamento
	
	//****************************************************************************
	//Criticas 33XX - Código de Ausência de movimento é obrigatório
	
	//****************************************************************************
	//Criticas 34XX - Não existe
	
	//****************************************************************************
	//Criticas 35XX - Não existe 
	
	//****************************************************************************
	//Criticas 36XX - Não existe 
	
	//****************************************************************************
	//Criticas 37XX - Não existe 
	
	//****************************************************************************
	//Criticas 38XX - Não existe 
	
	//****************************************************************************
	//Criticas 39XX - Não existe
	
	//****************************************************************************
	//Criticas 40XX - Não existe
	
	//****************************************************************************
	//Criticas 41XX - DN (Declaração de Nascido Vivo)

	//****************************************************************************

End Case

If !empty(cCritica)
	//Seta a variavel private para verdadeiro quando ocorre uma crítica. Quando muda o registro, a variavel é setada
	//como falso na função lAbreAlSIB
	lCritSIB := .T.
EndIf

Return cCritica

*******************************************************************************************************************

//Abre alias com as informações a serem utilizadas. 
//cAliasSIB contém informações das tabelas CONFSIB_CAB e CONFSIB_INT.
//cAliasBA1 contém informações da tabela BA1.

Static Function lAbreAlSIB(cOperacao)

Local cQuery 	:= ''
Local lOk		:= .T.

aArGeral := getArea()

lCritSIB 	:= .F.//Seta a variavel private para falso no início de cada registro.

cAliasSIB 	:= GetNextAlias()
cAliasBA1 	:= GetNextAlias()

cQuery := "SELECT *" 							   							+ CRLF
cQuery += "FROM " + cTab  						   							+ CRLF 

If !empty(cCCO)
	cQuery += "WHERE SIB_CODCCO = '" + cCCO + "'"							+ CRLF
Else
	//Pode ser que exista na inclusao. Este relatorio busca por erros...
	cQuery += "WHERE SIB_MATRIC = '" + codBenef + "'" 				  		+ CRLF
	cQuery += "  AND SIB_MATRIC <> ' '" 							 		+ CRLF
EndIf 

TcQuery cQuery New Alias cAliasSIB

cQuery := "SELECT *" 														+ CRLF
cQuery += "FROM " + RetSqlName('BA1')								 		+ CRLF 
cQuery += "WHERE BA1_FILIAL = '" + xFilial('BA1') + "'"				  		+ CRLF 

If !empty(cCCO)
    cQuery += "  AND BA1_CODCCO = '" + cCCO + "'"			 				+ CRLF
Else
	cQuery += "  AND BA1_CODINT = '" + Left(codBenef,4) + "'"				+ CRLF 
	cQuery += "  AND BA1_CODEMP = '" + Substr(codBenef,5,4) + "'"			+ CRLF 
	cQuery += "  AND BA1_MATRIC = '" + Substr(codBenef,9,6) + "'"			+ CRLF 
	cQuery += "  AND BA1_TIPREG = '" + Substr(codBenef,15,2) + "'"			+ CRLF 
	cQuery += "  AND BA1_DIGITO = '" + Right(codBenef,1) + "'"				+ CRLF 
EndIf
	
cQuery += "  AND D_E_L_E_T_ = ' '"											+ CRLF 

TcQuery cQuery New Alias cAliasBA1

lOk := !cAliasBA1->(EOF())

If lOk 

	BTS->(DbSetOrder(1))//BTS_FILIAL + BTS_MATVID
	
	lOk := BTS->(DbSeek(xFilial('BTS' + cAliasBA1->BA1_MATVID))) 
	
EndIf

Return lOk

*******************************************************************************************************************

//Retorna campo do alias solicitado

Static Function GetCpoTab(cTabela, cCpo)

Local uRet := ''

If ( cTabela == 'BA1' ) .and. !cAliasBA1->(EOF())

	uRet := 'cAliasBA1->(' + cCpo + ')'
	uRet := &uRet
	
ElseIf ( cTabela == 'SIB' ) .and. !cAliasSIB->(EOF())
	
	Do Case 
	
//		Obs: SIB_DATCAN e SIB_SITUAC
//	 
//		- Se data de cancelamento preenchida mas registro ativo, a data de cancelamento indica até que data o 
//		  registro ficou cancelado, ou seja, a data de reativação.
//		- Se data de cancelamento preenchida e registro ativo, a data de cancelamento indica efetivamente a 
//		  data em que o registro foi cancelado, ou seja, a data de cancelamento efetiva.
		
		Case cCpo == 'SIB_DATCAN'
		
			uRet := If(cAliasSIB->SIB_SITUAC == '3', cAliasSIB->SIB_DATCAN, '')
	
		Case cCpo == '_SIB_DTREAT'
		
			//uRet := If(cAliasSIB->SIB_SITUAC == '1', cAliasSIB->SIB_DATCAN, '')
				
			If ( cAliasSIB->SIB_SITUAC == '1' ) .and. !empty(cAliasSIB->SIB_DATCAN) //Ativo mas teve cancelamento em algum momento 
				uRet := cAliasSIB->SIB_DT_ATU //A data de histórico neste caso é a data de reativação
			Else
				uRet := ''
			EndIf
		
		Otherwise
			uRet := 'cAliasSIB->(' + cCpo + ')'
			uRet := &uRet
			
	End Case
	
EndIf

Return uRet

*******************************************************************************************************************

Static Function FechaAlSIB

cAliasSIB->(DbCloseArea())
cAliasBA1->(DbCloseArea())

RestArea(aArGeral)   
			
Return			

*******************************************************************************************************************

Static Function cRemovDig(cStrRem)

Local cRet := cStrRem

cRet := Replace(cRet,'0','')
cRet := Replace(cRet,'1','')
cRet := Replace(cRet,'2','')
cRet := Replace(cRet,'3','')
cRet := Replace(cRet,'4','')
cRet := Replace(cRet,'5','')
cRet := Replace(cRet,'6','')
cRet := Replace(cRet,'7','')
cRet := Replace(cRet,'8','')
cRet := Replace(cRet,'9','')
 
Return cRet		

*******************************************************************************************************************

User Function lVldPisPasep(cPISPAS)

Local lOk 		:= .T.
Local nVlrMult 	:= 0
Local nDigVerif	:= 0
Local nVlrCalc	:= 0
Local nDigCalc	:= 0

If ValType(cPISPAS) == 'N'
	cPISPAS := cValToChar(cPISPAS)
EndIf

cPISPAS := AllTrim(cPISPAS)

lOk := ( len(cPISPAS) == 11 ) .and. ( empty(AllTrim(cRemovDig(cPISPAS))) )

If lOk

	nVlrMult 	:= Val(Substr(cPISPAS,1,1)) * 3
	nVlrMult 	+= Val(Substr(cPISPAS,2,1)) * 2
	nVlrMult 	+= Val(Substr(cPISPAS,3,1)) * 9
	nVlrMult 	+= Val(Substr(cPISPAS,4,1)) * 8
	nVlrMult 	+= Val(Substr(cPISPAS,5,1)) * 7
	nVlrMult 	+= Val(Substr(cPISPAS,6,1)) * 6
	nVlrMult 	+= Val(Substr(cPISPAS,7,1)) * 5
	nVlrMult 	+= Val(Substr(cPISPAS,8,1)) * 4
	nVlrMult 	+= Val(Substr(cPISPAS,9,1)) * 3
	nVlrMult 	+= Val(Substr(cPISPAS,10,1)) * 2
	
	nDigVerif 	:= Val(Substr(cPISPAS,11,1))
	
	nVlrCalc	:= 11 - ( nVlrMult % 11 )
	
	If ( nVlrCalc == 10 ) .or. ( nVlrCalc == 11 ) 
		nDigCalc 	:= 0
	Else
		nDigCalc	:= nVlrCalc
	EndIf
	
	lOk := ( nDigVerif == nDigCalc )  

EndIf

Return lOk	

*******************************************************************************************************************

Static Function lVldCNS(CNSVld)

Local lOk 		:= .T.

If ValType(CNSVld) == 'N'
	CNSVld := cValToChar(CNSVld)
EndIf

CNSVld := AllTrim(CNSVld)

lOk := ( len(CNSVld) == 15 ) .and. ( empty(AllTrim(cRemovDig(CNSVld))) )

If lOk

 	lOk := ( left(CNSVld,1) $ '7|9|1|2|8' )

EndIf

Return lOk

*******************************************************************************************************************

Static Function nBCABloqANS(c_Matric) 

Local aArea 	:= GetArea()
Local nRec 		:= 0
Local cQry		:= ''
Local cAlias	:= ''

cQry := "SELECT MAX(RECBCA) RECNO" 																		+ CRLF
cQry += "FROM" 																							+ CRLF
cQry += "(" 																							+ CRLF
cQry += "  SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC, BCA_MOTBLO, BCA_NIVBLQ, BCA_DATA, 'ANS - ' || TRIM(BG3_BLQANS) BLOQUEIO, BCA.R_E_C_N_O_ RECBCA" + CRLF
cQry += "  FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BCA') + " BCA ON BCA_FILIAL = '" + xFilial('BCA') + "'" 			+ CRLF 
cQry += "    AND BCA_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC" 										+ CRLF
cQry += "    AND BCA_TIPREG = BA1_TIPREG" 																+ CRLF
cQry += "    AND BCA_TIPO = '0'" 																		+ CRLF
cQry += "    AND BCA.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BG3') + " BG3 ON BG3_FILIAL = '" + xFilial('BG3') + "'" 			+ CRLF 
cQry += "    AND BG3_CODBLO = BCA_MOTBLO" 																+ CRLF
cQry += "    AND BCA_NIVBLQ = 'U'" 																		+ CRLF
cQry += "    AND TRIM(BG3_BLQANS) IS NOT NULL" 															+ CRLF
cQry += "    AND BG3.D_E_L_E_T_ = ' '" 																	+ CRLF 
cQry += "  WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 												+ CRLF 
cQry += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + c_Matric + "'" 		+ CRLF
cQry += "    AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += "  UNION" 																						+ CRLF
cQry += "  SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC, BCA_MOTBLO, BCA_NIVBLQ, BCA_DATA, 'ANS - ' || TRIM(BG1_BLQANS) BLOQUEIO, BCA.R_E_C_N_O_ RECBCA" + CRLF
cQry += "  FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BCA') + " BCA ON BCA_FILIAL = '" + xFilial('BCA') + "'" 			+ CRLF 
cQry += "    AND BCA_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC" 										+ CRLF
cQry += "    AND BCA_TIPREG = BA1_TIPREG" 																+ CRLF
cQry += "    AND BCA_TIPO = '0'" 																		+ CRLF
cQry += "    AND BCA.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BG1') + " BG1 ON BG1_FILIAL = '" + xFilial('BG1') + "'" 			+ CRLF 
cQry += "    AND BG1_CODBLO = BCA_MOTBLO" 																+ CRLF
cQry += "    AND BCA_NIVBLQ = 'F'" 																		+ CRLF
cQry += "    AND TRIM(BG1_BLQANS) IS NOT NULL" 															+ CRLF
cQry += "    AND BG1.D_E_L_E_T_ = ' '" 																	+ CRLF 
cQry += "  WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 												+ CRLF 
cQry += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + c_Matric + "'" 		+ CRLF
cQry += "    AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += "  UNION" 																						+ CRLF
cQry += "  SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC, BCA_MOTBLO, BCA_NIVBLQ, BCA_DATA, 'ANS - ' || TRIM(BQU_BLQANS) BLOQUEIO, BCA.R_E_C_N_O_ RECBCA" + CRLF
cQry += "  FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BCA') + " BCA ON BCA_FILIAL = '" + xFilial('BCA') + "'" 			+ CRLF 
cQry += "    AND BCA_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC" 										+ CRLF
cQry += "    AND BCA_TIPREG = BA1_TIPREG" 																+ CRLF
cQry += "    AND BCA_TIPO = '0'" 																		+ CRLF
cQry += "    AND BCA.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += "  INNER JOIN " + RetSqlName('BQU') + " BQU ON BQU_FILIAL = '" + xFilial('BQU') + "'" 			+ CRLF 
cQry += "    AND BQU_CODBLO = BCA_MOTBLO" 																+ CRLF
cQry += "    AND BCA_NIVBLQ = 'S'" 																		+ CRLF
cQry += "    AND TRIM(BQU_BLQANS) IS NOT NULL" 															+ CRLF
cQry += "    AND BQU.D_E_L_E_T_ = ' '" 																	+ CRLF 
cQry += "  WHERE BA1_FILIAL = '" + xFilial('BA1') + "'" 												+ CRLF 
cQry += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + c_Matric + "'" 		+ CRLF
cQry += "    AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQry += ")" 																							+ CRLF

TcQuery cQry New Alias cAlias

If !cAlias->(EOF())

	nRec := cAlias->RECNO
	
EndIf

cAlias->(DbCloseArea())

RestArea(aArea)

Return nRec

*****************************************************************************************
/*
User Function tstcns

Local nI

aCNS := {;
			'700960564707287','702002899864418',;
			'129922045890003','207016825870009','160436807350003','209522966370000','201657354190018',;
			'705602432801318','707004877084632','709100286196430','700009599985901','898003469863565','898004834693777','898004856232195','898004829170109','980016297575008','980016294920987','980016296165701','980016002573181';
		}

For nI := 1 to len(aCNS)
	
	LOGERROS(aCNS[nI] + ' - ' + If(u_lCNSValido(aCNS[nI]),'.T. -> Válido','.F. -> Inválido'))
	
Next	

Return
*/
*****************************************************************************************************

//Baseado na rotina em javascript disponível em [ http://cartaonet.datasus.gov.br/Rotina_JavaScript.doc ]

User Function lCNSValido(cCNS)

Local lOk 	:= .T.
Local nI	:= 0

Local nSoma 		:= 0
Local nResto 		:= 0
Local nDV			:= 0
Local cPIS			:= ''
Local cResultado 	:= ''

If ValType(cCNS) == 'N'
	cCNS := cValToChar(cCNS)
EndIf

lOk := ( ( len(cCNS) == 15 ) .and. ( len(cCNS) == len(AllTrim(cCNS)) ) .and. empty(AllTrim(cRemovDig(cCNS))) )

If lOk

	Do Case
	
		Case Left(cCNS,1) $ '1|2'
		
			cPIS 	:= Left(cCNS,11)
			
			For nI := 1 to 11
				nSoma += Val(Substr(cPIS,nI,1)) * ( 15 - nI + 1 )
			Next
			
			nResto 	:= ( nSoma % 11 )
			nDV		:= 11 - nResto
			
			If nDV == 11
				nDV := 0
			EndIf
			
			If nDV == 10
			
				nSoma += 2
				
				nResto 		:= ( nSoma % 11 )
				nDV			:= 11 - nResto
				cResultado 	:= cPIS + "001" + cValToChar(nDV)
			
			Else
			
				cResultado 	:= cPIS + "000" + cValToChar(nDV)
				
			EndIf
			
			lOk := ( cCNS == cResultado )
	
		Case Left(cCNS,1) $ '7|8|9'
		
			cPIS 	:= Left(cCNS,15)
			
			For nI := 1 to 15
				nSoma += Val(Substr(cPIS,nI,1)) * ( 15 - nI + 1 )
			Next
			
			nResto 	:= ( nSoma % 11 )
			
			lOk 	:= ( nResto == 0 )
		
		Otherwise
		
			lOk := .F.
		
	End Case

EndIf

Return lOk

*****************************************************************************************************

Static Function cMotBloMat(c_Matric)

Local aArea 	:= GetArea()
Local aArBCA	:= BCA->(GetArea())
Local nRecBCA 	:= nBCABloqANS(c_Matric)
Local cMotBlo	:= ''

If nRecBCA > 0 
	
	BCA->(DbGoTo(nRecBCA))
	
	If BCA->BCA_TIPO == '0' 
		cMotBlo := BCA->BCA_MOTBLO
	EndIf
	
EndIf

BCA->(RestArea(aArBCA))
RestArea(aArea)

Return cMotBlo

*****************************************************************************************************

//Dado um código de bloqueio no Protheus retornará o código de bloqueio na ANS

Static Function cBloqANS(c_BloqProt)

Local aArea 	:= GetArea()
Local cQry 		:= ''
Local cAlias	:= GetNextAlias()
Local cBloqANS	:= ''

cQry += "SELECT BG1_BLQANS BLOQANS, 1 ORD" 				+ CRLF
cQry += "FROM " + RetSqlName("BG1") 					+ CRLF
cQry += "WHERE BG1_FILIAL = '" + xFilial('BG1') + "'" 	+ CRLF 
cQry += "  AND BG1_CODBLO = '" + c_BloqProt + "'"		+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF
cQry += "  AND TRIM(BG1_BLQANS) IS NOT NULL" 			+ CRLF
cQry += " " 											+ CRLF
cQry += "UNION" 										+ CRLF
cQry += " " 											+ CRLF
cQry += "SELECT BG3_BLQANS BLOQANS, 2 ORD" 				+ CRLF
cQry += "FROM " + RetSqlName("BG3") 					+ CRLF
cQry += "WHERE BG3_FILIAL = '" + xFilial('BG3') + "'"	+ CRLF 
cQry += "  AND BG3_CODBLO = '" + c_BloqProt + "'" 		+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF
cQry += "  AND TRIM(BG3_BLQANS) IS NOT NULL" 			+ CRLF
cQry += " " 											+ CRLF
cQry += "UNION" 										+ CRLF
cQry += " " 											+ CRLF
cQry += "SELECT BQU_BLQANS BLOQANS, 3 ORD" 				+ CRLF
cQry += "FROM " + RetSqlName("BQU") 					+ CRLF
cQry += "WHERE BQU_FILIAL = '" + xFilial('BQU') + "'" 	+ CRLF 
cQry += "  AND BQU_CODBLO = '" + c_BloqProt + "'" 		+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF
cQry += "  AND TRIM(BQU_BLQANS) IS NOT NULL" 			+ CRLF
cQry += " " 											+ CRLF
cQry += "ORDER BY ORD" 									+ CRLF

TcQuery cQry New Alias cAlias

If !cAlias->(EOF())
	cBloqANS := AllTrim(cAlias->BLOQANS)
EndIf

cAlias->(DbCloseArea())

RestArea(aArea)

Return cBloqANS                     




Static Function  fValAns( cCcco )  
               
local  QTDA       := 0
local  cQrySANS   := ' '
local  cCritica   := ' '
local  cMsgn      := ' '                                                               
local  adadosc    := {}

cQrySANS := "SELECT * " + CRLF 
cQrySANS += "  FROM " 
If cempant =='01'
   cQrySANS +="CONFSIB_CAB " 
Else
   cQrySANS +="CONFSIB_INT "
EndIf    
cQrySANS +=" SIBANS" + CRLF   
cQrySANS += " WHERE   SIB_CODCCO = '"+ cCcco+"' " + CRLF                           
            
If Select("TMPans") > 0
	dbSelectArea("TMPans")
	dbclosearea()
Endif

TCQuery cQrySANS Alias "TMPans" New     

TMPans->( dbGoTop() )


If  trim(TMPAns->SIB_NOMUSR)     != trim(nome) 
    QTDA++                  
    cMsgn      := cMsgn+'  '+ " - Nome usuario : "+ trim(nome)       
End    

If  TRIM(TMPAns->SIB_CPFUSR)           != TRIM(cpf)
    QTDA++                                   
    cMsgn      := cMsgn+'  '+" - Cpf Usuario : "+  TRIM(cpf)
End    
If  trim(TMPAns->SIB_PISPAS)     != TRIM(PisPasep)
    QTDA++                               
    cMsgn      := cMsgn+'  '+" - pispasp : "+ TRIM(PisPasep)    
End    
If  TMPAns->SIB_SEXO             != TRIM(iif(SEXO=='Masculino','1','3'))   
    QTDA++
    cMsgn      := cMsgn+'  '+" - Sexo : " + TRIM(SEXO)   
End    
If  trim(TMPAns->SIB_DATNAS)           !=  TRIM(substr(DtNasc,7,4)+substr(DtNasc,4,2)+substr(DtNasc,1,2))
    QTDA++
    cMsgn      := cMsgn+'  '+" - Data Nascimento : " + TRIM(substr(DtNasc,7,4)+substr(DtNasc,4,2)+substr(DtNasc,1,2))    
End    
If  Trim(TMPAns->SIB_MAE)        != Trim(nomeMae)
    QTDA++                                  
    cMsgn      := cMsgn+'  '+" - Nome da Mae : " + Trim(nomeMae)   
End    
If  Trim(TMPAns->SIB_ENDERE)     != Trim(lograd) 
    QTDA++                              
    cMsgn      := cMsgn+'  '+" - Logradouro : " + Trim(lograd)    
End    
If  Trim(TMPAns->SIB_NR_END)     != Trim(numero)
    QTDA++                                     
    cMsgn      := cMsgn+'  '+" - Numero : " + Trim(numero)    
End    
If  Trim(TMPAns->SIB_BAIRRO)     != Trim(bairro)
    QTDA++                              
    cMsgn      := cMsgn+'  '+" - Bairro : " + Trim(bairro)    
End    
If  Trim(TMPAns->SIB_CODMUN)     != trim(codMunic)
    QTDA++                         
    cMsgn      := cMsgn+'  '+" - Cod Municipio : " + trim(codMunic)    
End    
If  Trim(TMPAns->SIB_CEPUSR)     != Trim(cep)
    QTDA++
    cMsgn      := cMsgn+'  '+" - Cep : " + Trim(cep)    
End    
If  Trim(TMPAns->SIB_MATRIC)     != Trim(codBenef)
    QTDA++                       
    cMsgn      := cMsgn+'  '+" - Cod Beneficiario : " + Trim(codBenef)     
End    
If  Trim(TMPAns->SIB_GRAUPA)     != Trim(relDepen)
    QTDA++                                   
    cMsgn      := cMsgn+'  '+" - Relação de Dependente : " + Trim(relDepen)
End    
If  trim(TMPAns->SIB_DATCON)           != TRIM(substr(dtContra,7,4)+substr(dtContra,4,2)+substr(dtContra,1,2))  
    QTDA++                                        
    cMsgn      := cMsgn+'  '+" - Data de Contratação : " +TRIM(substr(dtContra,7,4)+substr(dtContra,4,2)+substr(dtContra,1,2))     
End    

If  Trim(TMPAns->SIB_NUMPLA)     != Trim(numPlaANS)
    QTDA++                                      
    cMsgn      := cMsgn+'  '+" - num Plano Ans : " + Trim(numPlaANS)   
End
  
If  Trim(TMPAns->SIB_COBPAR)     != Trim(cobParTmp)
    QTDA++                                       
    cMsgn      := cMsgn+'  '+" - XXXXX : " + Trim(cobParTmp)        
End    
If  Trim(TMPAns->SIB_ITEXCO)     != Trim(itExcCob)
    QTDA++                                   
    cMsgn      := cMsgn+'  '+" - Cobra Exterior : " + Trim(itExcCob)            
End    
If  Trim(TMPAns->SIB_CGCEMP)     != Trim(CnpjEmpCont) 
    QTDA++                                                
    cMsgn      := cMsgn+'  '+" - Cnpj Contratante : " + Trim(CnpjEmpCont)                
End    
If  Trim(TMPAns->SIB_CNS)        != Trim(cns)
    QTDA++                                     
    cMsgn      := cMsgn+'  '+" - Cns : " + Trim(cns)                
End 
/*  ans nao considera a data de cancelamento na retificação  
If  trim(TMPAns->SIB_DATCAN)     !=  TRIM(substr(dtCancel,7,4)+substr(dtCancel,4,2)+substr(dtCancel,1,2))  //substr(cAlArq->SIB_DATBLO,1,4) + Substr(cAlArq->SIB_DATBLO,5,2) + substr(cAlArq->SIB_DATBLO,2,7) 
    QTDA++                        
    cMsgn      := cMsgn+'  '+" - Data de Cancelamento : " + TRIM(substr(dtCancel,7,4)+substr(dtCancel,4,2)+substr(dtCancel,1,2))         
End 
*/   
If  Trim(TMPAns->SIB_PISPASEP)   != Trim(PISPASEP) 
    QTDA++                                         
    cMsgn      := cMsgn+'  '+" - PISPASEP : " + Trim(PISPASEP)        
End    
If  Trim(TMPAns->SIB_CNPJ_CONTRATANTE) != Trim(CnpjEmpCont)                 
    QTDA++
    cMsgn      := cMsgn+'  '+" - Cnpj Contratante : " + Trim(CnpjEmpCont)                     
End   
 
If  QTDA == 0   
    cCritica:= 'Não a alterações a serem reportadas a ANS'
Else                                                      
   cCritica:=''
EndIf    
                       
aAdd(adadosc,{QTDA})             
aAdd(adadosc,{cCritica}) 
aAdd(adadosc,{cMsgn})

TMPAns->(DbCloseArea()) 

Return( adadosc ) 


Static Function  fIncCcoVal(cTpAcao ,cEmp, cCcco, Cmatr , cCodCri,cCriComp)    

local c_Script := ' '      
local IdTit    := ' '   
                       
fNomBa1(cCcco, Cmatr ) 

if trim(cCcco) == ''            
                                                               
   IdTit    := Cmatr+(StrZero(mv_par08,4) + StrZero(mv_par07,2))+cTpSib + cTpAcao + cSequenc    
//   IdTit    := Cmatr+dDatcomp+cTpSib + cTpAcao + cSequenc       
   IdPd4    := Cmatr+(StrZero(mv_par08,4) + StrZero(mv_par07,2))+cTpSib + cTpAcao + cSequenc  
//   IdPd4    := Cmatr+dDatcomp+cTpSib + cTpAcao + cSequenc    

Else    

   IdTit    := cCcco+(StrZero(mv_par08,4)+StrZero(mv_par07,2))+cTpSib + cTpAcao + cSequenc 
// IdTit    := cCcco+dDatcomp+cTpSib + cTpAcao + cSequenc
   IdPd4    := cCcco+(StrZero(mv_par08,4)+StrZero(mv_par07,2))+cTpSib + cTpAcao + cSequenc                                                                                                                       
// IdPd4    := cCcco+dDatcomp+cTpSib + cTpAcao + cSequenc                                                                                                                      
   
EndIf
 
   dbselectarea("PD5") 
 
 if trim(cCcco) == ''
    PD5->(dbsetorder(2)) 
 Else                               
    PD5->(dbsetorder(1))
 EndIf 
  
 
If dbseek(xFilial("PD5")+TRIM(IdTit)) .and. !lFazPd5
                                       
     PD5->(RecLock("PD5",.F.))
     PD5->(DbDelete())
     PD5->(MsUnlock())

EndiF
      
      
If lFazPd5 .and. empty(PD5_ARQENV)                               

   RecLock("PD5",.F.)                     
                   
     PD5_ARQENV := cNomArqSIB
     PD5_USRENV := SubStr(cUSUARIO,7,15)
                  
Else              

   RecLock("PD5",.T.)                     
                                                         
     PD5_FILIAL   := Xfilial("PD5")  
     PD5_TPACAO   := cTpAcao               
  // PD5_EMPRES   := cEmp
     PD5_CODCCO   := cCcco
     if trim(Cmatr)=='' 
        PD5_MATRIC   := cMatrcBA1
     Else 
        PD5_MATRIC   := Cmatr 
     EndIf    
     PD5_DTCRIA   := stod(DtString) //stod(dDatCria)  //DtString
     PD5_TPENVI   := cTpSib 
     PD5_SEQUEN   := cSequenc
     PD5_COMPTE   := ( StrZero(mv_par08,4) + StrZero(mv_par07,2) ) 
     PD5_ENVIAD   := .F.   
     PD5_CRITIC   := iif(cCriticado == 'SIM',.T.,.F.)  
     PD5_DTENV    := stod( ' ' )  
     PD5_DATRET   := stod( ' ' )            
     PD5_ENVIA    := iif(cCriticado == 'SIM',.F.,.T.)    
     PD5_CRICAB   := cCodCri     
     PD5_CRIANS   := ' '     
     PD5_nomusr   := cNomeBa1  
     PD5_LOCSIB   := cLocSib 
     PD5_ARQENV   := ' '  
     PD5_ARQRET   := ' ' 
     PD5_USRENV   := ' ' 
     PD5_USRRET   := ' 
          
  EndIf    
    
    PD5->(Msunlock())  

If !lFazPd5

   dbselectarea("PD4")  

   if trim(cCcco) == ''
      PD4->(dbsetorder(1))
   Else                               
      PD4->(dbsetorder(2))
   EndIf 

   If dbseek(xFilial("PD4")+(IdPd4)) 
                                                            
      PD4->(RecLock("PD4",.F.))
      PD4->(DbDelete())
      PD4->(MsUnlock())

   EndIf                        
    
   If !Empty(cCodCri) .or. cTpAcao == 'RETI'

      RecLock("PD4",.T.)                     

        PD4->PD4_FILIAL   := Xfilial("PD4")   
        If trim(Cmatr)=='' 
           PD4_MATRIC   := cMatrcBA1
        Else 
           PD4_MATRIC   := Cmatr 
        EndIf    
        PD4->PD4_CODCCO   := cCcco  
        PD4->PD4_COMPTE   := ( StrZero(mv_par08,4) + StrZero(mv_par07,2) ) 
        PD4->PD4_TIPENV   := cTpSib   
        If !Empty(cCodCri) 
           PD4->PD4_CRITIC   := cCriComp    
        ElseIf cTpAcao == 'RETI'                                
           PD4->PD4_CRITIC   := aDadosCri[3,1] 
        EndIf      
        PD4->PD4_CRIANS   := ' '    
        PD4->PD4_ACAO     := cTpAcao
        If cempant == '01'
           PD4->PD4_ORIGEM   := 'CABERJ'
        Else                             
           PD4->PD4_ORIGEM   := 'INTEGRAL'
        EndIf  
        PD4->PD4_SEQUEN   := cSequenc 
       
       PD4->(Msunlock())  
   EndIf
EndIf  

return ()	     
         

/// nome Usuario 
Static Function  fNomBa1(cCCO, cMatric )   

local cQryNom := ' '   


    cQryNom := "SELECT BA1_NOMUSR NomUser , ba1_locsib locsib ,      "                + CRLF                          
    cQryNom += "  Ba1_CODINT||Ba1_CODEMP||Ba1_MATRIC||Ba1_TIPREG||Ba1_DIGITO Matric      "                + CRLF                         
    cQryNom += "  FROM " + RetSqlName("BA1")  + " "             + CRLF
    cQryNom += " WHERE  BA1_FILIAL = '" + xFilial('BA1') + "'" 	+ CRLF                     
    cQryNom += "   AND  d_e_l_e_t_  =  ' '  "               + CRLF    
    If trim(cCCO) == ''
       cQryNom += "   AND  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '"+cMatric+"'" + CRLF 
    Else  
       cQryNom += "   AND BA1_CODCCO ='"+cCCO+"' " + CRLF
    EndIf                                             
    
    If Select("TMPNom") > 0
	   dbSelectArea("TMPNom")
	   dbclosearea()
    Endif                                   

TCQuery cQryNom Alias "TMPNom" New     

TMPNom->( dbGoTop() )
                
cNomeBA1 := substr(TMPNom->NomUser,1,40)
cLocSib  := TMPNom->locsib                                                          
cMatrcBA1:= TMPNom->matric 

return (cNomeBA1)
                              
 
///////////////////////////////

Static Function  fValReti(cCCO, cAnoMesA )   

local cQryVret := ' '   
local lRet     := .F. 

If cTpSib != 'Sib Mensal'

 cQryVret := "  SELECT COUNT(*) QTDA  "                   + CRLF 
 cQryVret += "    FROM " + RetSqlName("PD5")  + " PD5  "  + CRLF 
 cQryVret += "   WHERE PD5_filial = '"+xFilial('BA1')+"'" + CRLF 
 cQryVret += "     AND PD5.d_E_L_E_T_ = ' '  "            + CRLF 
 cQryVret += "     AND PD5_COMPTE >= '"+cAnoMesA+"'"      + CRLF 
// cQryVret += "     AND PD5_TPENVI = 'Sib Global'  "       + CRLF 
 cQryVret += "     AND PD5.PD5_TPACAO = 'RETI' "          + CRLF 
 cQryVret += "     AND PD5.PD5_CODCCO = '"+cCCO +"'"      + CRLF 
 cQryVret += "     AND PD5.PD5_ENVIAD = 'T'  "            + CRLF 

    If Select("TMPVRet") > 0
	   dbSelectArea("TMPVRet")
	   dbclosearea()
    Endif                                   

TCQuery cQryVret Alias "TMPVRet" New     

TMPVRet->( dbGoTop() )
                
lRet:= Iif(TMPVRet->QTDA > 0, .T. , .F.)

Else 

  lRet:=.F.

EndIf 
return (lRet) 

/// verifica status processamento  
Static Function  fStProc()   

local cQryStProc :=' '

    cQryStProc := "SELECT count(*) Qtda     "               + CRLF                         
    cQryStProc += "  FROM " + RetSqlName("PD5")  +" PD5 "                 + CRLF
    cQryStProc += " WHERE  PD5_FILIAL = '" + xFilial('PD5')+ "'" 	+ CRLF                     
    cQryStProc += "   AND  d_e_l_e_t_  =  ' '  "               + CRLF    
    
    cQryStProc += "   AND PD5_TPENVI   = '"+ cTpSib +"'" + CRLF
    cQryStProc += "   AND PD5_SEQUEN   = '"+cSequenc +"'" + CRLF
    cQryStProc += "   AND PD5_COMPTE   = '"+(StrZero(mv_par08,4) + StrZero(mv_par07,2)) +"'" + CRLF
    cQryStProc += "   AND PD5_ENVIAD   = 'T' " + CRLF 
    
    If Select("TMPStP") > 0
	   dbSelectArea("TMPStP")
	   dbclosearea()
    Endif

TCQuery cQryStProc Alias "TMPStP" New     

TMPStP->(dbGoTop())

return (Iif(TMPStP->qtda == 0,.F.,.T.))
                                             

Static Function  fSeqPD5(cCompte , cTpSib )   
                      
local cQrySeq :=' '

 cQrySeq := "select nvl(max(PD5_SEQUEN),00) SEQ "           + CRLF
 cQrySeq += "  FROM " + RetSqlName("PD5")  +" PD5 "         + CRLF
 cQrySeq += " WHERE  PD5_FILIAL = '" + xFilial('PD5')+ "'" 	+ CRLF                     
 cQrySeq += "   AND  d_e_l_e_t_  =  ' '  "                  + CRLF     
 cQrySeq += "   AND  pd5_compte = '"+cCompte+"'"            + CRLF
 cQrySeq += "   AND  PD5_TPENVI  = '"+cTpSib+"' "           + CRLF         
 cQrySeq += "   AND  PD5_ENVIAD  = 'T' "                    + CRLF
                                         

    If Select("TMPSequen") > 0
	   dbSelectArea("TMPSequen")
	   dbclosearea()
    Endif

TCQuery cQrySeq Alias "TMPSequen" New     

TMPSequen->(dbGoTop())
                                                                 
//return IIf (mv_par12==2, val(TMPSequen->SEQ), val(TMPSequen->SEQ) + 1) 
return IIf(cSibEnv==1, val(TMPSequen->SEQ), val(TMPSequen->SEQ) + 1)


/*
Static Function  fDelPD5(cTpAcao , cTpSib )   

local c_Script :=' '
If trim(cUsua171) = 'Altamiro Totta'      
    c_Script := "DELETE " + RetSqlName("PD5") +" WHERE PD5_FILIAL ='"+ Xfilial("PD5")+ "' "
    c_Script += "   AND PD5_TPENVI  = '"+cTpSib+"'"           
    c_Script += " AND PD5_COMPTE   = "+(StrZero(mv_par08,4) + StrZero(mv_par07,2)) +"'" + CRLF
    c_Script += "   AND PD5_SEQUEN  = '"+StrZero(mv_par11,2)+"'"    
    c_Script += "   AND PD5_ENVIAD  = 'F'"
    
	If TcSqlExec(c_Script) < 0 
		LogErros("Falha ao DELETAR  tabela "+RetSqlName("PD5") + CRLF;
		        + "Verifique se ja foram Enviados "            + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				," ",.T.)	
		l_Erro	:= .T.
        Return (.F.)
    Else	
	    Return (.T.) 
	EndIf

return ()	