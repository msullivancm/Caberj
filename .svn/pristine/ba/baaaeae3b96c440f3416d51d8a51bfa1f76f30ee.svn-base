#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA144 | Autor | Altamiro	Affonso    | Data | 14/12/2018  |
|---------------------------------------------------------------------------|              
| Descricao | Mapa de envio Sib ans                                         |
|           | 																|                                                       
|---------------------------------------------------------------------------|
| Uso       | gestao do SIB - cadastro                                      | 
 --------------------------------------------------------------------------*/

User Function CABA144                                                                                    
local cRda      := ' ' 
local cNivel    := ' '
local nI        := 0        
private lsai    := .F. 

private pvez    := .T.                                                  

private aRetTit	:= {}
private aBrwTit           

Private oOk     := LoadBitMap(GetResources(),"LBOK")
Private oNo     := LoadBitMap(GetResources(),"LBNO")     

private mvpar01:= ' '
private mvpar02:= '	'
private mvpar03:= ' ' 
private mvpar04:= ' ' 
private mvpar05:= ' '
private mvpar06:= ' '



//Private aCabTit	:= {" ","Comptencia", "Tp Envio" ,"Tp Acao" , "Seq","Enviado" ,"Criticado", "Enviar?", "Dt Envio","Dt Retorno" ,"Dt Geração","Usr. Envio" ,"Arq. Envio" ,"Usr. Retorno","Arq. Retorno"  ,"Qtda"}   
  Private aCabTit	:= {" ","Comptencia", "Tp Envio" ,"Tp Acao" , "Seq","Enviado" ,"Em Analise", "Enviar?", "Dt Envio","Dt Retorno" ,"Dt Geração","Usr. Envio" ,"Arq. Envio" ,"Usr. Retorno","Arq. Retorno"  ,"Qtda"}  
Private aTamTit	:= {15 ,30         ,40          ,40        , 20   ,35        ,35         ,35         ,25          , 25         ,25           ,50           ,50           ,50            ,50              ,30    }
Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

private cQryAMP     := ' '        
private cSql        := ' ' 

Private cPerg	    := "CABA144"     

private datatu      := dtos(dDataBase-10)      
private cAliasB44   := GetNextAlias()       
private cAliasTit	:= GetNextAlias() 
private cAliasEnv 	:= GetNextAlias()      

PRIVATE nReembAt := 0 
PRIVATE nReembAn := 0 
PRIVATE nReembGl := 0 
PRIVATE nReembAp := 0

AjustaSX1()

Pergunte(cPerg,.T.)    

Processa({||aBrwTit:= aDadosTit()},'Processando...','Processando...',.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MsAdvSize()                          ³
//³-------------------------------------³
//³1 -> Linha inicial area trabalho.    ³
//³2 -> Coluna inicial area trabalho.   ³
//³3 -> Linha final area trabalho.      ³
//³4 -> Coluna final area trabalho.     ³
//³5 -> Coluna final dialog (janela).   ³
//³6 -> Linha final dialog (janela).    ³
//³7 -> Linha inicial dialog (janela).  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
          
lAjustHor	:= .T.
lAjustVert 	:= .F.

aAdd( aObjects, { 130,  260, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5   
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Status do Sib / Gestao de envio   ",,,.F.,,,,,,.T.,,,.T. )  
oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Mapa de Envio Sib Ans ",,,.F.,,,,,,.T.,,,.T. ) 

oSayTit    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'Mapa de Envio Sib Ans '},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

//bDbClickTit	:= {||U_CABA145( trim(aBrwTit[oBrwTit:nAt, 2]),trim(aBrwTit[oBrwTit:nAt, 3]),trim(aBrwTit[oBrwTit:nAt, 4]),trim(aBrwTit[oBrwTit:nAt, 5]),trim(aBrwTit[oBrwTit:nAt, 7]), trim(aBrwTit[oBrwTit:nAt, 6]),'','','','CABA144' ), oBrwTit:Refresh()  }   
bDbClickTit	:= {||fCaregPar(),U_CABA145(mvpar01,mvpar02,mvpar03,mvpar04,mvpar05,mvpar06,'','','','CABA144' ), oBrwTit:Refresh()  }

oBrwTit 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3],,aCabTit,aTamTit,oDlg,,,,,bDbClickTit,,,,,,,.F.,,.T.,,.F.,,, )

oBrwTit:SetArray(aBrwTit)   

oBrwTit:bLine :=  {||{If(aBrwTit[oBrwTit:nAt, 1],oOk,oNo)             ,;
				         trim(aBrwTit[oBrwTit:nAt, 2])                ,; 
		                 trim(aBrwTit[oBrwTit:nAt, 3])		          ,; 
		                 trim(aBrwTit[oBrwTit:nAt, 4])                ,; 
				         trim(aBrwTit[oBrwTit:nAt, 5])                ,;                
                         trim(aBrwTit[oBrwTit:nAt, 6])                ,;
                         trim(aBrwTit[oBrwTit:nAt, 7])                ,;
		                 trim(aBrwTit[oBrwTit:nAt, 8])                 ,;
				         trim(aBrwTit[oBrwTit:nAt, 9])                 ,;	 	  	    	 
		 	             trim(aBrwTit[oBrwTit:nAt,10])                 ,;
		 	             trim(aBrwTit[oBrwTit:nAt,11])		        ,; 
		 	             trim(aBrwTit[oBrwTit:nAt,12])                 ,;
				         trim(aBrwTit[oBrwTit:nAt,13])                 ,;	 	  	    	 
		 	             trim(aBrwTit[oBrwTit:nAt,14])                 ,;
		 	             trim(aBrwTit[oBrwTit:nAt,15])		        ,;
               Transform(aBrwTit[oBrwTit:nAt,16],'@E  999,999')  }}

             
             
                                                                    
oBrwTit:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .F.   

  aBut    :={{"PENDENTE", {||fFazExcel(),oBrwTit:Refresh()}, "Excel" , "Excel"  } }                                                                                           

// aBut    :={{"PENDENTE", {||u_LEG145(),oBrwTit:Refresh()  }	, "Legendas" , "Legendas"    } }
//aAdd(aBut, {"PENDENTE", {||fFazExcel() ,oBrwTit:Refresh()}	, "Excel"    , "Excel" } ) 
//aAdd(aBut, {"PENDENTE", {||desmarca(),oBrwTit:Refresh() }	, "DesMarcar Todos " , "DesMarcar Todos" } )  
// aAdd(aBut, {"PENDENTE", {||U_fCaba148((aBrwTit[oBrwTit:nAt, 4]),(aBrwTit[oBrwTit:nAt, 3])),oBrwTit:Refresh()  }	, "Demostrativo "    , "Demostrativo"    } )
// aAdd(aBut, {"PENDENTE", {||U_CABA145(trim(aBrwTit[oBrwTit:nAt, 2]),trim(aBrwTit[oBrwTit:nAt, 3]),trim(aBrwTit[oBrwTit:nAt, 4]),trim(aBrwTit[oBrwTit:nAt, 5]),trim(aBrwTit[oBrwTit:nAt, 7]), trim(aBrwTit[oBrwTit:nAt, 6]),'','','','CABA144' ) ,oDlg:End()  }	, "Demostrativo "    , "Demostrativo"    } )
                                       
 bOk 	:= {|| lConfirmou := .T. ,	MsgInfo("Processo finalizado"),oDlg:End()  }    
  
//  bOk 	:= {||lConfirmou := .T., atrbalcada(),oDlg:End()}   
bCancel := {||lConfirmou := .F.,oDlg:End()}

	
oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut)) 
//oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,))     


//If lConfirmou  

  //	MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))
	
//EndIf

Return    


/***********************************************************************************/	

/***********************************************************************************/

/***********************************************************************************/	
/***********************************************************************************/
Static Function aDadosTit

LOCAL nConSald:= ' '

Local cQryTit	:= ""

local i                          

ProcRegua(0) 

nCont := 0  

for i:=1 to 5
    IncProc('Buscando Dados no Servidor ...')
next 

////////////////////////////////
cQryTit :=" select PD5_COMPTE compte , " 
cQryTit += CRLF+ " decode(trim(PD5_TPENVI),'Sib Mensal', '1-Sib Mensal', '2-Sib Global')  tpenvio , " 
cQryTit += CRLF+ " PD5_TPACAO tpacao , "
cQryTit += CRLF+ "        PD5_SEQUEN seq , "
cQryTit += CRLF+ "        DECODE(PD5_ENVIAD,'T','Sim', 'Não') Enviado , "
cQryTit += CRLF+ "        decode(PD5_CRITIC,'T','Sim', 'Não') Criticado , "
cQryTit += CRLF+ "        decode(PD5_ENVIA,'T','Sim', 'Não') Enviar , "
cQryTit += CRLF+ "        substr(PD5_DTENV,7,2)||'/'||substr(PD5_DTENV,5,2)||'/'|| substr(PD5_DTENV,1,4) Envio , "
cQryTit += CRLF+ "        substr(PD5_DATRET,7,2)||'/'||substr(PD5_DATRET,5,2)||'/'|| substr(PD5_DATRET,1,4) Retorno , "
cQryTit += CRLF+ "        substr(PD5_DTCRIA,7,2)||'/'||substr(PD5_DTCRIA,5,2)||'/'|| substr(PD5_DTCRIA,1,4) Geracao , "  
cQryTit += CRLF+ "        PD5_USRENV  USRENV,"
cQryTit += CRLF+ "        PD5_ARQENV  ARQENV," 
cQryTit += CRLF+ "        PD5_USRRET  USRRET,"
cQryTit += CRLF+ "        PD5_ARQRET  ARQRET,"

cQryTit += CRLF+ "        count(*) qtda "      
cQryTit += CRLF+ "   FROM " +RetSqlName('PD5')+ " PD5 "            
cQryTit += CRLF+ "  WHERE PD5_filial = '" + xFilial('PD5')  + "'"
cQryTit += CRLF+ "    AND  d_e_l_e_t_ = ' ' "    

If !empty(mv_par01) .or. !empty(mv_par02)
   cQryTit += CRLF+ "    AND  pd5_compte >= '"+mv_par01+" ' "  
   cQryTit += CRLF+ "    AND  pd5_compte <= '"+mv_par02+" ' " 
EndIf                             
                                  
If mv_par03 == 2 
   cQryTit += CRLF+ "    AND  pd5_tpenvi= 'Sib Global' "
ElseIf mv_par03 == 1                                    
   cQryTit += CRLF+ "    AND  pd5_tpenvi= 'Sib Mensal' "
EndIf                               

If mv_par04 == 1 
   cQryTit += CRLF+ "    AND  pd5_tpacao = 'INCL' "
ElseIf mv_par04 == 2                                    
   cQryTit += CRLF+ "    AND  pd5_tpacao = 'CANC' "  
ElseIf mv_par04 == 3                                    
   cQryTit += CRLF+ "    AND  pd5_tpacao = 'RETI' "          
ElseIf mv_par04 == 4                                   
   cQryTit += CRLF+ "    AND  pd5_tpacao = 'REAT' "   
EndIf             

If !empty(mv_par01) .or. !empty(mv_par02)
   cQryTit += CRLF+ "    AND  pd5_compte >= '"+mv_par01+" ' "  
   cQryTit += CRLF+ "    AND  pd5_compte <= '"+mv_par02+" ' " 
EndIf                             

cQryTit +=" AND (PD5_CRICAB <> 'XXX1' or PD5_CRICAB <> 'XXX2')"+ CRLF  

   
cQryTit += CRLF+ "  group by PD5_TPACAO , PD5_COMPTE , DECODE(PD5_ENVIAD,'T','Sim', 'Não') , "
cQryTit += CRLF+ "           decode(PD5_CRITIC,'T','Sim', 'Não') , PD5_TPENVI, PD5_SEQUEN , "
cQryTit += CRLF+ "           PD5_DTENV  , PD5_DATRET , PD5_DTCRIA , "
cQryTit += CRLF+ "           decode(PD5_ENVIA,'T','Sim', 'Não') ,"
cQryTit += CRLF+ "           PD5_USRENV , PD5_ARQENV  , PD5_USRRET ,PD5_ARQRET " 

cQryTit += CRLF+ "  order by PD5_COMPTE ,decode(trim(PD5_TPENVI),'Sib Mensal', '1-Sib Mensal', '2-Sib Global'),   PD5_SEQUEN , PD5_TPACAO , DECODE(PD5_ENVIAD,'T','Sim', 'Não')"
//////////////////////////////   
////////////////                       
//////////////////////////////      
If Select((cAliasTit)) <> 0 
      
  (cAliasTit)->(DbCloseArea()) 
 
Endif 
                            
TcQuery cQryTit New Alias (cAliasTit)  

While !(cAliasTit)->(EOF())
 
      aAdd(aRetTit,{.T. ,; 
                        (cAliasTit)->COMPTE  ,; 
                        (cAliasTit)->tpenvio ,; 
                        (cAliasTit)->tpacao  ,;
                        (cAliasTit)->seq     ,;
                        (cAliasTit)->Enviado ,; 
                        (cAliasTit)->Criticado ,;
                        (cAliasTit)->Enviar  ,; 
                        (cAliasTit)->Envio   ,;
                        (cAliasTit)->Retorno ,; 
                        (cAliasTit)->Geracao  ,;
                        (cAliasTit)->USRENV,;
                        (cAliasTit)->ARQENV,; 
                        (cAliasTit)->USRRET,;
                        (cAliasTit)->ARQRET,;
                        (cAliasTit)->qtda }) 
      
       (cAliasTit)->(DbSkip())
	
EndDo

(cAliasTit)->(DbCloseArea())

If empty(aRetTit)  

    MsgAlert("Nao Dados para esta consulta "  + CRLF + " Revise seus parametros !!! ","Atencao!")
    lsai := .T.
	aAdd(aRetTit,{.T. , '' , '' , '' , '' , '' , '' , '' , '', '' , '','' , '', '' , '',0  })        
EndIf

Return aRetTit

/***************************************************************************************/    
Static Function AjustaSX1()

Local aHelp 	:= {}   

aHelp := {}
aAdd(aHelp, "Competencia Inicial  ")
PutSX1(cPerg , "01" , "Competencia Inicial(AAAAMM)" ,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp) 
aAdd(aHelp, "Competencia Final  ")
PutSX1(cPerg , "02" , "Competencia Final(AAAAMM)" ,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Envio Sib")
PutSX1(cPerg,"03", "Tipo de Envio Sib"         ,"","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Sib Mensal"	,"","","","Sib Global","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Acao do Sib ")
PutSX1(cPerg,"04", "Tipo de Acao do Sib"        ,"","","mv_ch4","N",1,0,1,"C","","","","","mv_par04","Inclusoes"	,"","","","Exclusões","","","Retificações","","","Reativação","","","Todos","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Exibir Criticas (Operad./ANS)")
PutSX1(cPerg,"05", "Exibir Criticas (Operad./ANS)"         ,"","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Sim"	,"","","","Não","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return  

//////////////////////////////////////////////////////////////////
STATIC FUNCTION fFazExcel()
                  
	Local aArea        	:= GetArea()
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')
	Local oFWMsExcel
	Local oExcel
	Local cArquivoA    	:= 'C:\TEMP\'+cEmpresa+'DmedIr'+SubStr(DtoS(date()),7,2)+SubStr(DtoS(date()),5,2)+SubStr(DtoS(date()),1,4)+STRTRAN(TIME(),":","_")+'.xml'   
	
	Local nRegsA		:= len(	aRetTit )   

	If nRegsA == 0
		Aviso("Não há dados!!!","Dmed - Ir  !",{"OK"})              
	Else 
		oFWMsExcel := FWMSExcel():New()		
		oFWMsExcel:AddworkSheet("DMEDIR")
		oFWMsExcel:AddTable("DMEDIR","DmedIr")
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Ano base",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Mes Base",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Cod Int",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Cod Emp",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Matricula",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Tip Reg",1)  
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Digito",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Ano Ir",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","CPF",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Nome usuario",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Data Bloqueio",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Data Inclusao",1) 
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Nivel Cobança",1)
		oFWMsExcel:AddColumn("DMEDIR","DmedIr","Valor ",3)
		
		ProcRegua(nRegsA) // Atribui quantidade de registros que serão impressos
		
		//Criando as Linhas... Enquanto não for fim da query

        for I = 1 to len(aRetTit)

			IncProc()                                          
					
			oFWMsExcel:AddRow("DMEDIR","DmedIr",{;
 				  	aRetTit[I,2] ,;
 				  	aRetTit[I,3] ,;
				  	aRetTit[I,4] ,;
 				  	aRetTit[I,5] ,;
				  	aRetTit[I,6] ,;
				  	aRetTit[I,7] ,;
 				  	aRetTit[I,8] ,; 
 				  	aRetTit[I,9] ,;
 				  	aRetTit[I,10] ,;  
 				  	aRetTit[I,11],;
				  	aRetTit[I,13] ,;
				  	aRetTit[I,14] ,; 
				  	aRetTit[I,15] ,;
				  	aRetTit[I,12]  })
						
		Next 
		
		//Ativando o arquivo e gerando o xml                    
		oFWMsExcel:Activate()
		oFWMsExcel:GetXMLFile(cArquivoA)
		
		//Abrindo o excel e abrindo o arquivo xml
		oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
		oExcel:WorkBooks:Open(cArquivoA)     //Abre uma planilha
		oExcel:SetVisible(.T.)              //Visualiza a planilha
		oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas
		
    EndIf 			

RETURN()
            
static function fCaregPar()
	
        mvpar01:= trim(aBrwTit[oBrwTit:nAt, 2]) 
	    mvpar02:= trim(aBrwTit[oBrwTit:nAt, 3])  
	    mvpar03:= trim(aBrwTit[oBrwTit:nAt, 4]) 
	    mvpar04:= trim(aBrwTit[oBrwTit:nAt, 5]) 
	    mvpar05:= trim(aBrwTit[oBrwTit:nAt, 7])
        mvpar06:= trim(aBrwTit[oBrwTit:nAt, 6])
        
return()	