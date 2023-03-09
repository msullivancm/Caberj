#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*--------------------------------------------------------------------------
| Programa  | CABA202b  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | detalhe das equipe de venda                                   |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | liberação de comissao de colaboradores                        |                                   
 --------------------------------------------------------------------------*/

User Function CABA2021( )
                                                 
local nI := 0          

Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()

Private cQuery        := " "   
Private cQryPEG       := " "  

private cEmp          := ' ' 
private cMes          := ' '
private cAno          := ' '
private cPrefT        := ' ' 
private cNumtT        := ' '
private cTipoT        := ' '
private cVend         := ' '
private lflagMM       :=.F.
private cValor        := ' ' 

Private aBrwPEG    := {}
private aRetPEG	   := {}    

Private aCabPEG	:= {" "                      ,;
                    " "                      ,;         
					"Cod Equipe"             ,;
	      		    "Matr. Colab."           ,;
			        "Nome Colabalorador"     ,;
			        "Competencia Comissão"   ,;
			        "Titulo Pagamento"       ,;
		            "Base de Calculo"        ,;
		            "% Comissao"             ,;
			        "base Comissao"          ,;
			        "% Distribuição"         ,;
		            "Valor Comissão"         ,;
		            "Empresa Contratante"    }

//Private aCabPEG	:= {" ", " " , "Cod Equipe",Matr. Colab.,Nome Colabalorador","Competencia Comissão","Titulo Pagamento","Base de Calculo","% Comissao","base Comissao","% Distribuição","Valor Comissão","Empresa Contratante"}
Private aTamPEG	    := {5  , 10 , 30         ,30          , 50                , 30                   ,40                , 40              , 30         ,40             ,30              , 40             ,  80                 }       
//Private aTamPEG	:= {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20    ,  25    ,  100    ,100       , 25       , 25        }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()
Private _cIdUsuar    :='000310'

private cAproN1      := GetNewPar("MV_APRCOM1"," ")
private cAproN2      := GetNewPar("MV_APRCOM2"," ")
private cAproN3      := GetNewPar("MV_APRCOM3"," ")


Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")

PRIVATE cCadastro	:= "Aprovação de Folha e Beneficios  "


PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 
							{ 'BR_AMARELO'  ,'Não Aprovado ' },;
							{ 'BR_VERMELHO' ,'Rejeitado' }}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG202b'	    , 0, K_Incluir		} }	


Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA202B"     
 
 Processa({||aBrwPEG := aDadosPEG()},'Processando...','Buscando Dados No Servidor ...',.T.)

  
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
          
lAjustHor	  := .T.
//lAjustVert  := .T.
lAjustVert 	  := .F.


aAdd( aObjects, { 120,  200, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )
//aAdd( aObjects, { 130,  250, lAjustHor, lAjustVert } )

nSepHoriz   := 5     
nSepVert    := 5
nSepBorHor 	:= 5
nSepBorVert	:= 5

aInfo  		:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

//oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3]-100,aSizeAut[5]-10,"Repase Comissao Vendedor Interno Integral -> Caberj ",,,.F.,,,,,,.T.,,,.T. ) 

oDlg  		:= MsDialog():New( aSizeAut[7],00,aSizeAut[3] ,aSizeAut[5]-10,"Autorização de pagamento de comissoes Equipe Interna",,,.F.,,,,,,.T.,,,.T. ) 
oSayPEG    	:= TSay():New( aPosObj[1][1],aPosObj[1][2],{||'"Autorização de pagamento de comissoes Equipe Interna"'},oDlg,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)


//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := !aBrwPEG[oBrwPEG:nAt,1], oBrwPEG:Refresh()}   

bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , fMostInf() , oBrwPEG:Refresh()}   
//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 
 
oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                     iif(aBrwPEG[oBrwPEG:nAt,  15] == 'R',oVermelho,(IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) == 'S',oVerde,oAmarelo)))  ,;
                         aBrwPEG[oBrwPEG:nAt,  2] ,;
                         aBrwPEG[oBrwPEG:nAt,  3] ,;
						 aBrwPEG[oBrwPEG:nAt,  4] ,;
                         aBrwPEG[oBrwPEG:nAt,  5] ,;
                         aBrwPEG[oBrwPEG:nAt,  6] ,;                     
	  	       Transform(aBrwPEG[oBrwPEG:nAt,  7] ,'@E  9999,999.99'),;
               Transform(aBrwPEG[oBrwPEG:nAt,  8] ,'@E  999.99')+'%',;  
			   Transform(aBrwPEG[oBrwPEG:nAt,  9] ,'@E  9999,999.99'),;
               Transform(aBrwPEG[oBrwPEG:nAt,  10] ,'@E  999.99')+'%',;
			   Transform(aBrwPEG[oBrwPEG:nAt,  11] ,'@E  9999,999.99'),;
						 aBrwPEG[oBrwPEG:nAt,  14] }}                   

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

aBut    :={{"PENDENTE", {||marca(1)   ,oBrwPEG:Refresh()            }	, "Marcar Todos "       , "Marcar Todos"      }}
aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()            }	, "Desmarcar Todos "	, "Desmarcar Todos"	  })  
aAdd(aBut, {"PENDENTE", {||U_LEG202B()                              }   , "Legenda "            , "Legenda "          })  
//aAdd(aBut, {"PENDENTE", {||fSql()     ,oBrwPEG:Refresh(),oDlg:End() }   , "Demonst. Comissao "  , "Demonst. Comissao" })  
//aAdd(aBut, {"PENDENTE", {||fFazlib()  ,oBrwPEG:Refresh(),oDlg:End() }   , "Faz Liberaçõa "      , "Faz Liberaçõa"     })  
aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'")  ,oBrwPEG:Refresh() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

a:='v'

Return()    

************************************************************************************

Static Function aDadosPEG()

Local cQryPEG	:= ""
Local cAliasPEG	:= GetNextAlias()
local i:= 0

ProcRegua(0) 


for i := i+1 to 5

    IncProc('Buscando Dados no Servidor ...')

next             
      

cQryPEG := CRLF+ "  Select Pdu_Codeqp      Codeqp    , "
cQryPEG += CRLF+ "         Pdu_Matfuc      Matfuc    , "
cQryPEG += CRLF+ "         SUBSTR(Pdu_Nome,1,30) Nome_Benf , "
cQryPEG += CRLF+ "         Pdu_Compte      Compte    , "
cQryPEG += CRLF+ "         nvl(trim(Pdu_Titpgt),'Exec. Contas')  Titpgt    , "
cQryPEG += CRLF+ "         sum(Pdu_Vbasin) Vbasin    , "
cQryPEG += CRLF+ "         Pdu_Perint      Perint    , " 
cQryPEG += CRLF+ "         sum(Pdu_Vlrbas) Vlrbas    , "
cQryPEG += CRLF+ "         Pdu_Percen      Percen    , "
cQryPEG += CRLF+ "         sum(Pdu_Vlrpgt) Vlrpgt    , "
cQryPEG += CRLF+ "         PDU_STATUS      Status    , "
cQryPEG += CRLF+ "         sum(Pdu_Vlrbas)  Vlrse2   , "
cQryPEG += CRLF+ "         BG9_CODIGO      CodEmp    , "
cQryPEG += CRLF+ "         SUBSTR(bg9_descri,1,30) DescEmp  "
cQryPEG += CRLF+ "    From Pdu010 Pdu , Sra010 Sra , bg9020 BG9 "  
    
cQryPEG += CRLF+ "   Where Pdu_Filial = ' ' "
cQryPEG += CRLF+ "     And Pdu.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF+ "     And Ra_Filial ='01' "
cQryPEG += CRLF+ "     And Sra.D_E_L_E_T_ = ' ' "

cQryPEG += CRLF+ "     AND bg9_filial = ' ' "
cQryPEG += CRLF+ "     and BG9.d_E_L_E_T_ = ' ' "
cQryPEG += CRLF+ "     And Pdu_Pgto = 'N' "
cQryPEG += CRLF+ "     And Ra_Mat = Pdu_Matfuc "
cQryPEG += CRLF+ "     And Ra_Demissa = ' ' " 
cQryPEG += CRLF+ "     and bg9_codint = '0001' "
cQryPEG += CRLF+ "     and bg9_codigo = PDU_CODEMP "
cQryPEG += CRLF+ "   group by Pdu_Codeqp , " 
cQryPEG += CRLF+ "            Pdu_Matfuc , "
cQryPEG += CRLF+ "            Pdu_Nome   , "
cQryPEG += CRLF+ "            Pdu_Compte , "
cQryPEG += CRLF+ "            Pdu_Titpgt , "
cQryPEG += CRLF+ "            Pdu_Perint , "
cQryPEG += CRLF+ "            Pdu_Percen , "
cQryPEG += CRLF+ "            PDU_STATUS , "
cQryPEG += CRLF+ "            BG9_CODIGO , "
cQryPEG += CRLF+ "            bg9_descri   "   
cQryPEG += CRLF+ "   Order By Pdu_Codeqp , Pdu_Matfuc , Pdu_Nome ,Pdu_Titpgt "


TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

    aAdd(aRetPEG,{.F.      ,;  //1
	(cAliasPEG)->Codeqp    ,;  //2
	(cAliasPEG)->Matfuc    ,;  //3
	(cAliasPEG)->Nome_Benf ,;  //4
	(cAliasPEG)->Compte    ,;  //5
	(cAliasPEG)->Titpgt    ,;  //6
	(cAliasPEG)->Vbasin    ,;  //7
	(cAliasPEG)->Perint    ,;  //8
	(cAliasPEG)->Vlrbas    ,;  //9
	(cAliasPEG)->Percen    ,;  //10
	(cAliasPEG)->Vlrpgt    ,;  //11
	(cAliasPEG)->Vlrse2    ,;  //12
	(cAliasPEG)->CodEmp    ,;  //13
	(cAliasPEG)->DescEmp   ,;  //14
	(cAliasPEG)->Status    })  //15  

	(cAliasPEG)->(DbSkip())

EndDo
  
(cAliasPEG)->(DbCloseArea())

If empty(aRetPEG)
	aAdd(aRetPEG,{.F.,;  //1
	               '',;  //2
				   '',;  //3
				   '',;  //4
				   '',;  //5
				   '',;  //6
				   0 ,;  //7
				   0 ,;  //8
				   0 ,;  //9
				   0 ,;  //10
				   0 ,;  //11
				   0 ,;  //12
				   '',;  //13
				   '',;  //14
				   '' }) //15
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    
/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
local nI := 0            
       

		For nI := nI + 1 to len(aBrwPEG)
	
		    aBrwPEG[nI,1]:= .T.

		Next

//	EndIf 	
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
       local nI
			
	      For nI :=  nI + 1 to len(aBrwPEG)
	
			   aBrwPEG[nI,1]:= .F.
			   
	      Next
	
RETURN() 

User Function LEG202b()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] },;
						{ aCdCores[4,1],aCdCores[4,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return



Static Function fFazlib()

//Local cQryEqp	:= ""

local I 

nPagto := 0



	For I := I + 1 to len(aBrwPEG)
			
		If  aBrwPEG[I,1] == .T.  
			
			DBSELECTAREA("PDT")   
            PDT->(dbSetOrder(1))  
	 
            cPrefT        := aBrwPEG[I,03] 
            cNumtT        := aBrwPEG[I,04]
            cTipoT        := aBrwPEG[I,06]
            cMes          := substr(aBrwPEG[I,02],5,2)
            cAno          := substr(aBrwPEG[I,02],1,4)
            cEmp          := substr(aBrwPEG[I,11],1,4) 
            cVend         := substr(aBrwPEG[I,12],1,6) 
///			
			PDT->(Reclock("PDT",.T.))

				PDT_FILIAL   := xFilial('PDT')  
				PDT_PREFIX   := aBrwPEG[I,03] 
				PDT_NUM      := aBrwPEG[I,04]  
				PDT_PARCEL   := aBrwPEG[I,05]  
				PDT_TIPO     := aBrwPEG[I,06]  
				PDT_FORNEC   := aBrwPEG[I,07]  
				PDT_APROV    := aBrwPEG[I,13]  
				PDT_TPAPRO   := aBrwPEG[I,17]  
				PDT_DTAPRO   := DATE()  
				PDT_LIBERA   := trim(Iif( aBrwPEG[I,17]='V','N','S'))  
				PDT_MODULO   :='COM'  
				PDT_GRPAPR   := aBrwPEG[I,15]  
				PDT_NOMAPV   := aBrwPEG[I,14] 
				PDT_LOG      := "Usuario : " +_cUsuario + " Data Hora Geração " +cDthr
				PDT_ACAO     := trim(aBrwPEG[I,17])
         
		        nPagto++                

			PDT->(MsUnlock())
	          
	        DBSELECTAREA("SE2")   
            SE2->(DbSetOrder(1))		  
	
	        If SE2->(MsSeek(xFilial("SE2") + aBrwPEG[I,03]+aBrwPEG[I,04]+aBrwPEG[I,05]+aBrwPEG[I,06]))
								
	   //MARCA COMO CONTABILIZADO, PARA EVITAR A DELEÇÃO APOS A AUTORIZAÇÃO - PARA LIBERAR A EXCLUÇÃO LIBERAR A CONTABILIZAÇÃO
	     	   SE2->(RecLock("SE2",.F.))
						
	           SE2->E2_LA := "S"
					
	           SE2->(MsUnLock())

	        EndIf
    
	    EndIf
	
	Next

Return(nPagto)
***************************************************************************************/
Static Function AjustaSX1()

Local aHelp 	:= {}   


u_CABASX1(cPerg,"01",OemToAnsi("Exib. Tit. Baixados")              ,"","","mv_ch1","N",01,0,0,"C","","","","","mv_par01","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 



Return 
           

Static Function ValPergFc()

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Mes Compencia     "  ,"","","mv_ch01","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )  
PutSx1(cPerg,"02","Ano Compencia     "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" ) 
PutSx1(cPerg,"03","Num Titulo Inc    "  ,"","","mv_ch03","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"04","Num Titulo Fim    "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"05","Ope Origem Inc    "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
PutSx1(cPerg,"06","Ope Origem Final  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )


Return(.T.)

Static Function fEnvEmail(cNivel , cRda )

Local lEmail     := .F.
Local c_CampAlt  := '  ' 
Local lExecuta   := .T.   
local cDest      := " "                           
Local aArea      := GetArea() //Armazena a Area atual        
Local _cMensagem := " " 

_cMensagem := "Em " + DtoC( Date() ) +  Chr(10) + Chr(13) + Chr(10) + Chr(13) 

_cMensagem :=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + " Assunto : Movimentação de Comissao , equipe Interna  " 
_cMensagem :=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezados,"       

_cMensagem :=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Foi feito movimentos de baixa(s) de Titulos de Comissao na Intergral Saude , "
_cMensagem :=  Chr(13) + Chr(10) + "Criação de titulos a receber na Caberj e "
_cMensagem :=  Chr(13) + Chr(10) + "Lançamento de verbas da folha de pagamento , Conforme descrito abaixo : "
_cMensagem :=  Chr(13) + Chr(10) 
_cMensagem :=  Chr(13) + Chr(10) + "Titulos a Pagar Baixados : "

_cMensagem :=  Chr(13) + Chr(10) + "Titulos a Receber Criado e  Baixados : "

_cMensagem :=  Chr(13) + Chr(10) + "Verbas da Folha (SRK) lançadas : "
 
_cMensagem :=  Chr(13) + Chr(10) + "Para sua Ciencia."

cDest:= "altamiro@caberj.com.br ; macedo@caberj.com.br"

EnvEmail1( _cMensagem , cDest) 

RestArea(aArea)             

Return (.T.)                                                          
*--------------------------------------*
Static Function EnvEmail1( _cMensagem , cDest )
*--------------------------------------*                                           

/*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
Local _cMailServer := GetMv( "MV_RELSERV" )
Local _cMailCo_Alnta  := GetMv( "MV_EMCONTA" )
Local _cMailSenha  := GetMv( "MV_EMSENHA" ) 

//Local _cTo  	 := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
Local _cTo  	     := cDest //"altamiro@caberj.com.br "
Local _cCC         := " "  //GetMv( "MV_WFFINA" )
Local _cAssunto    := " Movimentação de Comissao , equipe Interna  "
Local _cError      := ""
Local _lOk         := .T.
Local _lSendOk     := .F.
local cto_         := ' '

//_cTo:= cDest

If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  ) 
	// Conecta uma vez com o servidor de e-mails
	CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk

	If _lOk
		SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
	Else
		//Erro na conexao com o SMTP Server
		GET MAIL ERROR _cError
     	Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )   
	EndIf

    If _lOk       
    	//Desconecta do Servidor
      	DISCONNECT SMTP SERVER  
    EndIf
EndIf

return()                    

  /*
    Begin Transaction

		SE1->(DbSeek(cFilSe1+(cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO))
		 aDadSe1 :={{"E1_PREFIXO"  ,(cAliasTmp)->E1_PREFIXO , Nil }, {"E1_NUM"      ,(cAliasTmp)->E1_NUM     , Nil },;
		 		    {"E1_PARCELA"  ,(cAliasTmp)->E1_PARCELA , Nil }, {"E1_TIPO"     ,(cAliasTmp)->E1_TIPO    , Nil },;
				    {"E1_CLIENTE"  ,(cAliasTmp)->E1_CLIENTE , Nil }, {"E1_LOJA"     ,(cAliasTmp)->E1_LOJA    , Nil },;
				    {"AUTMOTBX"    ,'REE'                   , Nil }, {"AUTBANCO"    ,cBanco                  , Nil },;
					{"AUTAGENCIA"  ,cAgencia                , Nil }, {"AUTCONTA"    ,cConta                  , Nil },;
					{"AUTDTBAIXA"  ,dDataBase               , Nil }, {"AUTDTCREDITO",dDataBase               , Nil },;
					{"AUTHIST"     ,cHistor                 , Nil }, {"AUTVALREC"   ,(cAliasTmp)->E1_SALDO   , Nil }}
					lMsErroAuto := .F.
					MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,if(!lExcBord,3,5))
					If lMsErroAuto
						DisarmTransaction()
						MostraErro()
					Endif
    End Transaction
*/
    // Criação de títulos provisórios.

Static Function fSe1(cPrefix , cFatura , cParcela , cTipo , cNat ,  cCliente ,  cLojaCli , dVencto , nValor , cHistor, cCodInt , cCodemp , cAnobase , CMesBase )
  
//for i = 1 to len(aBrwPEG)

		aDadosTit := {}
		aAdd(aDadosTit, {"E1_PREFIXO"	, aBrwPEG[I,3]	, Nil})
		aAdd(aDadosTit, {"E1_NUM"		, aBrwPEG[I,4]  , Nil})
		aAdd(aDadosTit, {"E1_PARCELA"	, ' '        	, Nil})
		aAdd(aDadosTit, {"E1_TIPO"		, aBrwPEG[I,5] 	, Nil})
		aAdd(aDadosTit, {"E1_NATUREZ"	, '999' 	  	, Nil})
		aAdd(aDadosTit, {"E1_CLIENTE"	, '032541'   	, Nil})
		aAdd(aDadosTit, {"E1_LOJA"		, '01'      	, Nil}) 
		aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	    , Nil})
		aAdd(aDadosTit, {"E1_VENCTO"	, dDataBase	    , Nil})
		aAdd(aDadosTit, {"E1_VALOR"		, aBrwPEG[I,11] , Nil})
		aAdd(aDadosTit, {"E1_HIST"		, "Pagto Comissao da INTERGRAL a CABERJ"	, Nil}) 
		aAdd(aDadosTit, {"E1_CODINT"	, '0001'	, Nil})
		aAdd(aDadosTit, {"E1_CODEMP"	, '0009'	, Nil})
		aAdd(aDadosTit, {"E1_ANOBASE"	, substr(cAnoBase,1,4)	, Nil})
		aAdd(aDadosTit, {"E1_MESBASE"	, substr(cMesBase,5,2)	, Nil})

		MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,3)

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
			Return .F.
		endIf 	
Return()		

	// Baixar Fatura
	        cHist     := "Pgto Comissao da INTERGRAL a CABERJ " 
			cHistoric := "Pgto Comissao da INTERGRAL a CABERJ"
	aDadSE1 := {}
	aAdd(aDadSE1, {"E1_PREFIXO"		, aBrwPEG[I,3]	, Nil })
	aAdd(aDadSE1, {"E1_NUM"			, aBrwPEG[I,4]	, Nil })
	aAdd(aDadSE1, {"E1_PARCELA"		, " "		 	, Nil })
	aAdd(aDadSE1, {"E1_TIPO"		, aBrwPEG[I,5]	, Nil })
	aAdd(aDadSE1, {"E1_CLIENTE"		, '032541'		, Nil })
	aAdd(aDadSE1, {"E1_LOJA"		, '01' 			, Nil })
	aAdd(aDadSE1, {"AUTMOTBX"		, 'BX'				, Nil }) // Mudar para NEG
	aAdd(aDadSE1, {"AUTBANCO"		, CriaVar("A6_COD")		, Nil })
	aAdd(aDadSE1, {"AUTAGENCIA"		, CriaVar("A6_AGENCIA")	, Nil })
	aAdd(aDadSE1, {"AUTCONTA"		, CriaVar("A6_NUMCON")	, Nil })
	aAdd(aDadSE1, {"AUTDTBAIXA"		, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTDTCREDITO"	, dDataBase				, Nil })
	aAdd(aDadSE1, {"AUTHIST"		, cHistoric				, Nil })
	aAdd(aDadSE1, {"E1_HIST"		, cHist					, Nil })
	aAdd(aDadSE1, {"AUTVALREC"		, aBrwPEG[I,11]				, Nil })
			
	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina070(x,y)}, aDadSe1, 3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		Return .F.
	Endif

Return()

static Function fSe2()

//troca dimaniucade empresa
//Solução
//Não existe uma função específica que permita consultas ou manipulação em uma empresa 'B' enquanto estiver conectado em ambiente da empresa 'A'.
//Para que uma ação desse tipo seja possível é necessário que outra Thread seja iniciada para uma execução independente, e nela preparado um ambiente para tal.
//O recurso para essa necessidade seria a função StartJob.
//A seguir um exemplo de rotina automática, para a inclusão de um produto, em duas empresas diferentes simultaneamente;

Local aBaixa := {}

PRIVATE lMsErroAuto := .F.
Private INCLUI := .T.
private cHistBaixa := 'Baixa da Comissao Pgto a Caberj'

	AADD(aBaixa, {"E2_FILIAL" , xFilial("SE2") , Nil})
    AADD(aBaixa, {"E2_PREFIXO" , cPref , Nil})
    AADD(aBaixa, {"E2_NUM" , cNUM , Nil})
	AADD(aBaixa, {"E2_PARCELA" , cParc , Nil})
	AADD(aBaixa, {"E2_TIPO" , cTIPO , Nil})
    AADD(aBaixa, {"E2_FORNECE" , cFornec , Nil})
	AADD(aBaixa, {"E2_LOJA" , cLoja , Nil}) 
    AADD(aBaixa, {"AUTMOTBX" , "COMP. CR " , Nil})
    AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
    AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
	AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
	AADD(aBaixa, {"AUTDTBAIXA" , dDataBase , Nil}) 
	AADD(aBaixa, {"AUTDTCREDITO", dDataBase , Nil})
    AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
    AADD(aBaixa, {"AUTVLRPG" , vlrbxa , Nil})
  
    ACESSAPERG("FIN080", .F.)
 


//baixa o titulos na Integral a empresa '02'
//STARTJOB("U_T020Auto",getenvserver(),.t.,aBaixa)
 
Return

///////tela da consulta/////


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

static Function MostRes(cConsult)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cConsCom:= cConsult 

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlgRes","oMGet1","oBtn1")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlgRes     := MSDialog():New( 063,1464,802,2159,"Composição da Comissão",,,.F.,,,,,,.T.,,,.T. )
oMGet1     := TMultiGet():New( 000,000,{|u| If(PCount()>0,cConsCom:=u,cConsCom)},oDlgRes,340,340,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )
oBtn1      := TButton():New( 349,301,"&Sair",oDlgRes,{||oDlgRes:End()},037,012,,,,.T.,,"",,,,.F. )


oDlgRes:Activate(,,,.T.)

Return

static Function fMostInf()

local aLogLista := {}
local cquery    := ' '     

local cAnoM    := substr(aBrwPEG[oBrwPEG:nAt,2],1,4)
local cMesM    := substr(aBrwPEG[oBrwPEG:nAt,2],5,2)
local cCodempM := substr(aBrwPEG[oBrwPEG:nAt,11],1,4)
local cCodVenM := substr(aBrwPEG[oBrwPEG:nAt,12],1,6)

if nOrigem1 == 1

	cQuery :="  select bxqa.vendedor vendedor       , "
    cQuery :=CRLF+"         sum(bxqa.bacom) bacom   , "
	cQuery :=CRLF+"         trim(bxqa.percom) percom  , "
	cQuery :=CRLF+"         sum(bxqa.vlcom) vlcom   , "
	cQuery :=CRLF+"         sum(bxqa.qtda) qtda     , "
	cQuery :=CRLF+"         bxqa.obs     obs        , "
	cQuery :=CRLF+"         bxqa.idadLim idadLim    , "
	cQuery :=CRLF+"         bxqa.agenc   agenc       , "
	
    cQuery :=CRLF+"         decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X') parcela "  

	cQuery :=CRLF+"    from ("

	cQuery :=CRLF+"  select bxq.codven ||'-'|| bxq.nomvend vendedor, " 
	cQuery :=CRLF+"    sum(bxq.bascom) bacom    , "
	cQuery :=CRLF+"    bxq.percom||'%' percom  , "
	cQuery :=CRLF+"    sum(bxq.vlrcom) vlcom    , " 
	cQuery :=CRLF+"    sum(bxq.qtda) qtda       , "

    cQuery :=CRLF+"    bxop.obs     obs         , "
    cQuery :=CRLF+"    bxop.idadLim idadLim     , "
    cQuery :=CRLF+"    bxop.agenc   agenc       , "

	cQuery :=CRLF+"    bxq.numpar   numpar        "

	cQuery :=CRLF+"    from( select bxq_codven codven      , "
	cQuery :=CRLF+"                 a3_nome nomvend        , "
	cQuery :=CRLF+"                 bxq_numpar numpar      , "
	cQuery :=CRLF+"                 count(*) qtda          , "
	cQuery :=CRLF+"                 Bxq_Percom      percom , "
	cQuery :=CRLF+"                 sum(bxq_vlrcom) vlrcom , "
	cQuery :=CRLF+"                 sum(bxq_bascom) bascom , "
	cQuery :=CRLF+"                 bxq_codemp codemp      , "
	cQuery :=CRLF+"                 bxq_matric matric      , "
	cQuery :=CRLF+"                 bxq_tipreg tipreg      , "
	cQuery :=CRLF+"                 a3_nome Vend           , "
	cQuery :=CRLF+"                 ba1_conemp conemp      , "
	cQuery :=CRLF+"                 ba1_subcon subcon      , "
	cQuery :=CRLF+"                 ba1_Tipinc  tipInc       "
	cQuery :=CRLF+"            From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 

	cQuery :=CRLF+"           where bxQ_filial  ='"+xFilial('BXQ')+ "' and bxQ.d_E_L_E_T_ = ' ' "
	cQuery :=CRLF+"             and   A3_filial ='"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery :=CRLF+"             and  BA1_filial ='"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' " 
	cQuery :=CRLF+"             and bxq_codint = ba1_codint "
	cQuery :=CRLF+"             and bxq_codemp = ba1_codemp "
	cQuery :=CRLF+"             and bxq_matric = ba1_matric "
	cQuery :=CRLF+"             and bxq_tipreg = ba1_tipreg "
	cQuery :=CRLF+"             and bxq_codven = a3_cod "    
	cQuery :=CRLF+"             and bxq_vlrcom > 0  "        

	cQuery :=CRLF+"             and bxq_codemp = '"+cCodempM+"'  " 
	cQuery :=CRLF+"             and bxq_codven = '"+cCodVenM+"'  "
	cQuery :=CRLF+"             and bxq_ano    = '"+cAnoM+"'  "
	cQuery :=CRLF+"             and bxq_mes    = '"+cMesM+"'  "

	cQuery :=CRLF+"             and bxq_pagcom = bxq_refere "
	cQuery :=CRLF+"        group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery :=CRLF+"                 bxq_tipreg, Bxq.Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , "
	
cQuery :=CRLF+"  (select bxo_codven codven , 
cQuery :=CRLF+"          bxo_codemp codemp , 
cQuery :=CRLF+"          bxo_matric matric , 
cQuery :=CRLF+"          bxo_tipreg tipreg , 
cQuery :=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery :=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery :=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery :=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery :=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery :=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery :=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery :=CRLF+"            (select * from  "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery :=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery :=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery :=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery :=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery :=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery :=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
cQuery :=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery :=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj 	) bxop " 

/*
	cQuery :=CRLF+"        (select bxo_codven codven , "
	cQuery :=CRLF+"                bxo_codemp codemp , "
	cQuery :=CRLF+"                bxo_matric matric , "
	cQuery :=CRLF+"                bxo_tipreg tipreg , "
	cQuery :=CRLF+"                bxk_qtdde qtdde   , "
	cQuery :=CRLF+"                bxk_qtdate qtdate , "
	
    cQuery :=CRLF+"                    bxk_obs Obs         ,
    cQuery :=CRLF+"                    bxj_Yidisn  idadLim ,

    if cempant == '01'
       cQuery :=CRLF+"                decode(bxk.BXK_AGENCI ,'1', 'Agenciamento', 'Vitalicio') agenc 
	Else 
       cQuery :=CRLF+"                decode(bxk.BXK_AGENC ,'1', 'Agenciamento', 'Vitalicio') agenc 
    EndIf

	cQuery :=CRLF+"            From " + RetSqlName("BXO") +" BXO , " + RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 

	cQuery :=CRLF+"          where BXO_filial = '"+xFilial('BXO')+ "'  and bxo.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"            and BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"            and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "

	cQuery :=CRLF+"            and bxo_codemp = '"+cCodEmpM+"' "
	cQuery :=CRLF+"            and bxo_codven = '"+cCodVenM+"' "

	cQuery :=CRLF+"            and bxj_seq    = bxo_seqbxj
	cQuery :=CRLF+"            and bxk_seqbxj = bxo_seqbxj ) bxop " */ 
	
	cQuery :=CRLF+"           where bxq.codven = bxop.codven   "
	cQuery :=CRLF+"             and bxq.numpar >= bxop.qtdde   "
	cQuery :=CRLF+"             and bxq.numpar <= bxop.qtdate  "
	cQuery :=CRLF+"             and bxq.codemp = bxop.codemp   "
	cQuery :=CRLF+"             and bxq.matric = bxop.matric   "
	cQuery :=CRLF+"             and bxq.tipreg = bxop.tipreg   "
	cQuery :=CRLF+"        group by bxq.codven , bxq.nomvend , "
	cQuery :=CRLF+"                 bxop.qtdde||' a '||bxop.qtdate , bxq.percom||'%' , "
    cQuery :=CRLF+"                 bxop.obs , bxop.idadLim , bxop.agenc , bxq.numpar  "

	cQuery :=CRLF+" union all "  
    
	cQuery :=CRLF+"    select bxq.codven ||'-'|| bxq.nomvend vendedor , "
	cQuery :=CRLF+"           sum(bxq.bascom) bacom    , "
	cQuery :=CRLF+"           bxq.percom||'%' percom   , "
	cQuery :=CRLF+"           sum(bxq.vlrcom) vlcom    , "
	cQuery :=CRLF+"           sum(bxq.qtda) qtda       , "

    cQuery :=CRLF+"           bxop.obs     obs         , "
    cQuery :=CRLF+"		      bxop.idadLim idadLim     , "
    cQuery :=CRLF+"    		  bxop.agenc   agenc       , "

	cQuery :=CRLF+"           bxq.numpar   numpar        "

	cQuery :=CRLF+"      from( select bxq_codven codven      , " 
	cQuery :=CRLF+"                   a3_nome nomvend        , " 
	cQuery :=CRLF+"                   bxq_numpar numpar      , " 
	cQuery :=CRLF+"                   count(*) qtda          , " 
	cQuery :=CRLF+"                   Bxq_Percom  Percom     , " 
	cQuery :=CRLF+"                   sum(bxq_vlrcom) vlrcom , "
	cQuery :=CRLF+"                   sum(bxq_bascom) bascom , "
	cQuery :=CRLF+"                   bxq_codemp codemp      , "
	cQuery :=CRLF+"                   bxq_matric matric      , "
	cQuery :=CRLF+"                   bxq_tipreg tipreg      , "
	cQuery :=CRLF+"                   a3_nome Vend           , "
	cQuery :=CRLF+"                   ba1_conemp conemp      , "
	cQuery :=CRLF+"                   ba1_subcon subcon      , "
	cQuery :=CRLF+"                   ba1_Tipinc  tipInc       "
	cQuery :=CRLF+"              From " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("SA3") +" SA3 ," + RetSqlName("BA1") +" BA1 " 
	cQuery :=CRLF+"             where bxQ_filial = '"+xFilial('BXQ')+ "'  and bxQ.d_E_L_E_T_ = ' ' "
	cQuery :=CRLF+"               and A3_filial  = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "
	cQuery :=CRLF+"               and BA1_filial = '"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_ = ' ' "
	cQuery :=CRLF+"               and bxq_codint = ba1_codint "
	cQuery :=CRLF+"               and bxq_codemp = ba1_codemp "
	cQuery :=CRLF+"               and bxq_matric = ba1_matric "
	cQuery :=CRLF+"               and bxq_tipreg = ba1_tipreg "
	cQuery :=CRLF+"               and bxq_codven = a3_cod     "
	cQuery :=CRLF+"               and bxq_vlrcom < 0          "

	cQuery :=CRLF+"               and bxq_codemp = '"+cCodEmpM+"' "     
	cQuery :=CRLF+"               and bxq_codven = '"+cCodVenM+"' "
	cQuery :=CRLF+"               and bxq_ano    = '"+cAnoM+"' "     
	cQuery :=CRLF+"               and bxq_mes    = '"+cMesM+"' "       

	cQuery :=CRLF+"               and bxq_pagcom = bxq_refere "
	cQuery :=CRLF+"          group by bxq_codven , bxq_numpar , bxq_codemp , bxq_matric , "
	cQuery :=CRLF+"                   bxq_tipreg, Bxq_Percom ,a3_nome , ba1_conemp  , ba1_subcon ,ba1_tipinc  )bxq , " 

cQuery :=CRLF+"  (select bxo_codven codven , 
cQuery :=CRLF+"          bxo_codemp codemp , 
cQuery :=CRLF+"          bxo_matric matric , 
cQuery :=CRLF+"          bxo_tipreg tipreg , 
cQuery :=CRLF+"          NVL(BXJK.bxk_qtdde,'001') qtdde   , 
cQuery :=CRLF+"          NVL(BXJK.bxk_qtdate,'999') qtdate , 
cQuery :=CRLF+"          NVL(BXJK.bxk_obs,' ') Obs         ,
cQuery :=CRLF+"          nvl(BXJK.bxj_Yidisn,' ')  idadLim ,

if  cempant == '01'
    cQuery :=CRLF+"                decode(NVL(bxjk.BXK_AGENCI,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
Else 
    cQuery :=CRLF+"                decode(NVL(bxjk.BXK_AGENC,' ') ,'1', 'Agenciamento', 'Vitalicio') agenc 
EndIf

cQuery :=CRLF+"       From " + RetSqlName("BXO") +" BXO , "  
cQuery :=CRLF+"            (select * from "+ RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 
cQuery :=CRLF+"              where BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
cQuery :=CRLF+"                and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "
cQuery :=CRLF+"                AND BXK_SEQBXJ = BXJ_SEQ
cQuery :=CRLF+"                AND BXJ_CODEMP = '0010') BXJK 
cQuery :=CRLF+"              where BXO_filial = '  '  and bxo.d_E_L_E_T_ = ' '
cQuery :=CRLF+"                and bxo_codemp = '"+cCodEmpM+"' "
cQuery :=CRLF+"                and bxo_codven = '"+cCodVenM+"' "
cQuery :=CRLF+"                and BXJK.bxj_seq(+)    = bxo_seqbxj ) bxop "

	/*select bxo_codven codven , "
	cQuery :=CRLF+"                bxo_codemp codemp , "
	cQuery :=CRLF+"                bxo_matric matric , "
	cQuery :=CRLF+"                bxo_tipreg tipreg , "
	cQuery :=CRLF+"                bxk_qtdde qtdde   , "
	cQuery :=CRLF+"                bxk_qtdate qtdate , "

    cQuery :=CRLF+"                bxk_obs Obs         ,
    cQuery :=CRLF+"                bxj_Yidisn  idadLim ,
	if cempant == '01'
       cQuery :=CRLF+"                decode(bxk.BXK_AGENCI ,'1', 'Agenciamento', 'Vitalicio') agenc 
	Else 
       cQuery :=CRLF+"                decode(bxk.BXK_AGENC ,'1', 'Agenciamento', 'Vitalicio') agenc 
    EndIf
	cQuery :=CRLF+"           From " + RetSqlName("BXO") +" BXO , " + RetSqlName("BXJ") +" BXJ , "+ RetSqlName("BXK") +" BXK " 

	cQuery :=CRLF+"          where BXO_filial = '"+xFilial('BXO')+ "'  and bxo.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"            and BXJ_filial = '"+xFilial('BXJ')+ "'  and bxj.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"            and BXK_filial = '"+xFilial('BXK')+ "'  and bxk.d_E_L_E_T_ = ' ' "

	cQuery :=CRLF+"            and bxo_codemp = '"+cCodEmpM+"' "
	cQuery :=CRLF+"            and bxo_codven = '"+cCodVenM+"' "

	cQuery :=CRLF+"            and bxj_seq    = bxo_seqbxj "
	cQuery :=CRLF+"            and bxk_seqbxj = bxo_seqbxj	 ) bxop "
	*/ 

	cQuery :=CRLF+"   where bxq.codven  = bxop.codven  "
	cQuery :=CRLF+"     and bxq.numpar >= bxop.qtdde   "
	cQuery :=CRLF+"     and bxq.numpar <= bxop.qtdate  "
	cQuery :=CRLF+"     and bxq.codemp  = bxop.codemp  "
	cQuery :=CRLF+"     and bxq.matric  = bxop.matric  "
	cQuery :=CRLF+"     and bxq.tipreg  = bxop.tipreg  "
	cQuery :=CRLF+"   group by bxq.codven   , bxq.nomvend , "
	cQuery :=CRLF+"         bxq.percom||'%' , bxop.obs    , "
    cQuery :=CRLF+"         bxop.idadLim    , bxop.agenc  , bxq.numpar ) bxqa "

    cQuery :=CRLF+"   group by bxqa.vendedor    , "
    cQuery :=CRLF+"            bxqa.percom      , "
    cQuery :=CRLF+"            bxqa.obs         , "
    cQuery :=CRLF+"            bxqa.idadLim     , "
    cQuery :=CRLF+"            bxqa.agenc       , "

	cQuery :=CRLF+"            decode(bxqa.agenc ,'Agenciamento',bxqa.numpar , 'X')" 

	cQuery :=CRLF+" union all "  
    
	cQuery :=CRLF+" select bxq_codven ||'-'|| a3_nome  vendedor , " 
    cQuery :=CRLF+"        sum(bxq_bascom) bacom    , "
	cQuery :=CRLF+"        bxq_percom||'%' percom   , "
	cQuery :=CRLF+"        sum(bxq_vlrcom) vlcom    , "
	cQuery :=CRLF+"        count(*)        qtda     , "
    cQuery :=CRLF+"        PE9_JUSTIF      obs      , "
	cQuery :=CRLF+"        ' '             idadLim  , "
	cQuery :=CRLF+"        'NAO'           agenc    , "
	cQuery :=CRLF+"        bxq_numpar      numpar     "

	cQuery :=CRLF+"   FROM  " + RetSqlName("BXQ") +" BXQ , " + RetSqlName("PE9") +" PE9 , "+ RetSqlName("SA3") +" SA3 " 
    
	cQuery :=CRLF+"  where BXQ_filial = '"+xFilial('BXO')+ "'  and BXQ.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"    and PE9_filial = '"+xFilial('PE9')+ "'  and PE9.d_E_L_E_T_ = ' ' "
    cQuery :=CRLF+"    and  A3_filial = '"+xFilial('SA3')+ "'  and SA3.d_E_L_E_T_ = ' ' "

	cQuery :=CRLF+"    and bxq_codemp = '"+cCodEmpM+"' "     
	cQuery :=CRLF+"    and bxq_codven = '"+cCodVenM+"' "
	cQuery :=CRLF+"    and bxq_ano    = '"+cAnoM+"' "     
	cQuery :=CRLF+"    and bxq_mes    = '"+cMesM+"' "       
	
	cQuery :=CRLF+"    AND PE9_COMPTE = '"+cAnoM+"/"+cMesM+"' " 
    cQuery :=CRLF+"    AND PE9_CODEMP = '"+cCodEmpM+"' "
    cQuery :=CRLF+"    AND PE9_CODVEN = '"+cCodVenM+"' "

	cQuery :=CRLF+"    and bxq_pagcom = bxq_refere "
    cQuery :=CRLF+"    and bxq_codven = a3_cod     "
    cQuery :=CRLF+"    and bxq_numpar = '777'      "
    cQuery :=CRLF+"  GROUP BY bxq_codven ||'-'|| a3_nome , " 
	cQuery :=CRLF+"       bxq_percom , "
    cQuery :=CRLF+"       bxq_numpar , "
    cQuery :=CRLF+"       PE9_JUSTIF   "

	If Select((cAliasMost)) <> 0 
	          (cAliasMost)->(DbCloseArea())  
	Endif                          

	TCQuery cQuery New Alias (cAliasMost)   

    (cAliasMost)->( DbGoTop() )  

	While !(cAliasMost)->(EOF())

		aAdd(aLogLista,{ trim((cAliasMost)->vendedor)                               ,;    //1
						transform((cAliasMost)->bacom,"@E 999,999,999.99") ,;    //2
                        transform(( ( (cAliasMost)->vlcom / (cAliasMost)->bacom) *100),"@E 999.9999") ,;//3	
						transform((cAliasMost)->vlcom,"@E 999,999,999.99") ,;    //4
						transform(iif((cAliasMost)->vlcom < 0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda) ,"@E 999,999") ,;    //5
						trim((cAliasMost)->percom) ,;  //6
						iif(trim((cAliasMost)->parcela)=='777', 'X',trim((cAliasMost)->parcela))  ,; //7
						iif((cAliasMost)->parcela=='777', 'Cobr/Dev', (iif((cAliasMost)->vlcom<0, 'Recuperação', (cAliasMost)->agenc))) ,;//8
						iif(TRIM((cAliasMost)->idadLim)=='', 'Não', 'Sim') ,;    //9
						(cAliasMost)->Obs })     //10 

	    	nbascomT:=(cAliasMost)->bacom
	    	nVlrcomT:=(cAliasMost)->vlcom
	    	nQtdat  := iif((cAliasMost)->vlcom<0, ((cAliasMost)->qtda*-1), (cAliasMost)->qtda)
	
		(cAliasMost)->(DbSkip())

	EndDo

                  aAdd(aLogLista,{'Totais --->'                               ,;    //1
						transform(nbascomT,"@E 999,999,999.99")   ,;    //2
                        transform(((nVlrcomT/nbascomT) *100),"@E 999.9999") ,;	//3	
						transform(nVlrcomT,"@E 999,999,999.99")   ,;    //4
						transform(nQtdat  ,"@E 999,999")          ,;    //5
						' '                                       ,; //6
						' '                                       ,; //7
						(cAliasMost)->Agenc                                  ,;    //8
						(cAliasMost)->idadLim                                ,;    //9
						(cAliasMost)->Obs                                   })     //10 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe dp titulo de comisso                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  len(aLogLista) > 0



		PLSCRIGEN(aLogLista,{{'Vendedor ',"@!",60}    ,;
		                     {'Faturamento',"@!",30}  ,;
							 {'% Calculado',"@!",15}  ,;
							 {'Comissão',"@!",25}     ,;
							 {'Vidas',"@!",15}        ,;
							 {'Regra ',"@!",15}       ,;
							 {'Parcela ',"@!",10}     ,;
							 {'Tipo  ',"@!",25}       ,;
							 {'Idade Limite',"@!",12} ,;
							 {'Observações',"@!",100}},;
							 'Detalhes da Comissão',nil,nil) 
	Endif
    desmarca()
EndIF
nbascomT:= 0.00
nVlrcomT:= 0.00
nQtdat  := 0

//desmarca()

Return()


