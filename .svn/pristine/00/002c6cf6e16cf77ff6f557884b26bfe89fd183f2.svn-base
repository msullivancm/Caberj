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
| Programa  | CABA2022  | Autor | Altamiro	Affonso    | Data | 19/06/2020  |
|---------------------------------------------------------------------------|              
| Descricao | detalhe das equipe de venda                                   |
|           |                                                               |                                                       
|---------------------------------------------------------------------------|
| Uso       | liberação de comissao de colaboradores                        |                                   
 --------------------------------------------------------------------------*/

User Function CABA2022(nOrig , _user )
                                                 
local nI := 0          

Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()  
PRIVATE cAliasRkC1   := GetNextAlias()

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
private cCompte       := ' ' 

private cAnoANT       :=  ' ' 
private cMesAnt       :=  ' ' 
private cMes          :=  ' ' 
private cAno          :=  ' '
Private cMesAtu       :=  ' '
private cAnoATU       :=  ' '

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
		            "Empresa Contratante"    ,;
                    "Controle"               ,;
                    "St1"                    ,;
                    "St2"                    ,;
                    "St3"                    ,;
					"St4"                    ,;
					"Sinistr"                }

//Private aCabPEG	:= {" ", " " , "Cod Equipe",Matr. Colab.,Nome Colabalorador","Competencia Comissão","Titulo Pagamento","Base de Calculo","% Comissao","base Comissao","% Distribuição","Valor Comissão","Empresa Contratante", "Controle",'St1','St2','St3', 'Sinist'}
Private aTamPEG	    := {5  , 10 , 30         ,30          , 50                , 30                   ,40                , 40              , 30         ,40             ,30              , 40             ,  80                   ,  15       , 5   , 5   ,5    ,15 }       
//Private aTamPEG	:= {5  , 25     ,20     , 25   , 20   ,20    ,    80     , 30    ,30        ,30     ,    20    ,  25    ,  100    ,100       , 25       , 25        }       

//private aBrwPEG
//Private aCabPEG		:= {" ", "Compt. Entrada","Operadora de  Origem  ","Vlr Fase 3","Vlr Fase 31/2","Vlr Fase 4","Vlr Inss","Vlr Tx Adm", "Total Guias","Faturado","Qtda Guias"}
//Private aTamPEG		:= {10,30,120,45,45,45,45,45,45,45,25}  

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()

//Private _cIdUsuar    :='000026'

Private _cIdUsuar1   := _cIdUsuar
//Private _cIdUsuar    :='001495'
//Private _cIdUsuar    :='001592'
//Private _cIdUsuar    :='000214'
//private cAproN1      := GetNewPar("MV_APRCOM1"," ")
//private cAproN2      := GetNewPar("MV_APRCOM2"," ")
//private cAproN3      := GetNewPar("MV_APRCOM3"," ")
//private cAproN4      := GetNewPar("MV_APRCOM4"," ")

private cAproN1      := ""
private cAproN2      := ""
private cAproN3      := ""
private cAproN4      := ""

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")

Private oVerde   	:= LoadBitMap(GetResources(),"ENABLE")
Private oAmarelo	:= LoadBitMap(GetResources(),"BR_AMARELO")
Private oVermelho	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private oPreto   	:= LoadBitMap(GetResources(),"BR_PRETO")

PRIVATE cCadastro	:= "Aprovação de Folha e Beneficios  "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Aprovado     ' },; 
							{ 'BR_AMARELO'  ,'Não Aprovado ' },;
							{ 'BR_VERMELHO' ,'Bloqqueado'    },;
							{ 'BR_PRETO'    ,'Rejeitado Def.'}}

PRIVATE aRotina	:=	{	{ "Legenda"		, 'U_LEG2022'	    , 0, K_Incluir		} }	

Private aObjects 	:= {}

Private aSizeAut 	:= MsAdvSize() 

Private cPerg	    := "CABA2022"     

u_fBusAlc('909097')

if  nOrig != 1

    If  Pergunte(cPerg,.T.) == .F.
	    Return
    Endif 

    cCompte  := Mv_par01 

    If  !empty(Mv_par02)
        _cIdUsuar:=Mv_Par02 
    EndIf

else

    Mv_par03:=0
   _cIdUsuar1:= _cIdUsuar := _user

EndIf 	 


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
/*
bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] :=iif(trim(aBrwPEG[oBrwPEG:nAt,15]) == 'B',aBrwPEG[oBrwPEG:nAt,1], ; 
                                               (IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) == 'A',!aBrwPEG[oBrwPEG:nAt,1], ;
											        (IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) $ 'X|S',aBrwPEG[oBrwPEG:nAt,1],!aBrwPEG[oBrwPEG:nAt,1])))))

*/
bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif(( alltrim(aBrwPEG[oBrwPEG:nAt, 15]) $ 'X|S|B') ,aBrwPEG[oBrwPEG:nAt,1],!aBrwPEG[oBrwPEG:nAt,1])}


//iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , fMostInf() , oBrwPEG:Refresh()}   
//bDbClickPEG	:= {|| aBrwPEG[oBrwPEG:nAt,1] := iif ((aBrwPEG[oBrwPEG:nAt,17] == ' ' .or. mv_par01 == '1') , aBrwPEG[oBrwPEG:nAt,1] ,!aBrwPEG[oBrwPEG:nAt,1]) , oBrwPEG:Refresh()}   

//bChangePEG	:= {||AtuBrwGuia(aBrwPEG[oBrwPEG:nAt,2],aBrwPEG[oBrwPEG:nAt,3])}

oBrwPEG 	:= TcBrowse():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+40,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

//oBrwPEG 	:= TcBrowse():New(aPosObj[1][1]+10,aPosObj[1][2],aPosObj[1][4],aPosObj[1][3]+190,,aCabPEG,aTamPEG,oDlg,,,,,bDbClickPEG,,,,,,,.F.,,.T.,,.F.,,, )

oBrwPEG:SetArray(aBrwPEG) 
 
oBrwPEG:bLine := {||{If( aBrwPEG[oBrwPEG:nAt,  1],oOk,oNo) ,;
                     iif(aBrwPEG[oBrwPEG:nAt,  15] == 'B',oVermelho, ;
					    (IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) == 'A',oVerde, ;
						     (IIf(alltrim(aBrwPEG[oBrwPEG:nAt, 15]) $ 'X|S',oPreto, oAmarelo)))))  ,;
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
						 aBrwPEG[oBrwPEG:nAt,  14] ,;
                         aBrwPEG[oBrwPEG:nAt,  16] ,;
                         aBrwPEG[oBrwPEG:nAt,  17] ,;
                         aBrwPEG[oBrwPEG:nAt,  18] ,;
                         aBrwPEG[oBrwPEG:nAt,  19] ,;
						 aBrwPEG[oBrwPEG:nAt,  20] ,;
						 aBrwPEG[oBrwPEG:nAt,  21]}}                   

oBrwPEG:nScrollType  := 1 // Scroll VCR

lConfirmou 	:= .T.

    aBut    :={{"PENDENTE", {||marca(1)   ,oBrwPEG:Refresh()            }	, "Marcar Todos "       , "Marcar Todos"      }}
	aAdd(aBut, {"PENDENTE", {||desmarca(1),oBrwPEG:Refresh()            }	, "Desmarcar Todos "	, "Desmarcar Todos"	  })  
	aAdd(aBut, {"PENDENTE", {||U_LEG2022()                              }   , "Legenda "            , "Legenda "          })  
If  _cIdUsuar1 == _cIdUsuar .AND. Mv_par03 == 2  
	aAdd(aBut, {"PENDENTE", {||fFazlib(1) ,oBrwPEG:Refresh(),oDlg:End() }   , "Aprova Comissão "    , "Aprova Comissão "  })  
	aAdd(aBut, {"PENDENTE", {||fFazlib(2) ,oBrwPEG:Refresh(),oDlg:End() }   , "Bloqueia Comissão "  , "Bloqueia Comissão" })  
	aAdd(aBut, {"PENDENTE", {||fFazlib(3) ,oBrwPEG:Refresh(),oDlg:End() }   , "Rejeita Comissão Def." , "Rejeita Comissão Def."})  
EndIf 
	aAdd(aBut, {"PENDENTE", {||oDlg:End()                               }   , "Sair "               , "Sair "             })  

lConfirmou := .F.

//bOk 	:= {||fSequen() , oBrwPEG:Refresh() , oBrwPEG:Refresh() ,oDlg:End()   }    
 
bOk 	:= {|| MsgAlert("Favor Escolher uma opção em 'Ações Relacionadas'")  ,oBrwPEG:Refresh() }    
 
bCancel := {||lConfirmou := .F.,oDlg:End()}

oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,bOk,bCancel,,aBut))

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
/*
If  _cIdUsuar $ cAproN1
    cQryPEG += CRLF+ "         PDU_STATU1      Status    , "
elseIf  _cIdUsuar == cAproN2
    cQryPEG += CRLF+ "         PDU_STATU2      Status    , "
ElseIf  _cIdUsuar == cAproN3
    cQryPEG += CRLF+ "         PDU_STATU3      Status    , "
ElseIf  _cIdUsuar == cAproN4
    cQryPEG += CRLF+ "         PDU_STATU4      Status    , "	
Else
    cQryPEG += CRLF+ "         PDU_STATUS      Status    , "
EndIf 
*/
    cQryPEG += CRLF+ "         PDU_STATUS      Status    , "

cQryPEG += CRLF+ "         PDU_STATU1      Statu1    , "
cQryPEG += CRLF+ "         PDU_STATU2      Statu2    , "
cQryPEG += CRLF+ "         PDU_STATU3      Statu3    , "
cQryPEG += CRLF+ "         PDU_STATU4      Statu4    , "
cQryPEG += CRLF+ "         sum(Pdu_Vlrbas) Vlrse2   , "
cQryPEG += CRLF+ "         BG9_CODIGO      CodEmp    , "
cQryPEG += CRLF+ "         SUBSTR(bg9_descri,1,30) DescEmp , "
cQryPEG += CRLF+ "         Pdu.R_E_C_N_O_  RecPdu "

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

//cQryPEG += CRLF+ "     and Pdu_Matfuc = '000649' "

//cQryPEG += CRLF+ "      and (PDX.PDX_PARINI = ' ' and 1=1" 
//cQryPEG += CRLF+ "       or (PDX.PDX_PARINI <> ' ' and pdu_numpar >=  PDX.PDX_PARINI and pdu_numpar <=  PDX.PDX_PARFIM))"

If Mv_par03 != 1 

//   cQryPEG += CRLF+ "     and PDU->PDU_PGTO  not In ('C','S')" 
   cQryPEG += CRLF+ "     and PDU_STATUS <> 'X' "

    If !empty(cCompte)
      cQryPEG += CRLF+ "     and PDU_COMPTE >= '"+cCompte+"' " 
    EndIf 

    If  _cIdUsuar $ cAproN1
        cQryPEG += CRLF+ "     and PDU_APROV1 = ' ' "
        cQryPEG += CRLF+ "     and PDU_APROV2 = ' ' "
        cQryPEG += CRLF+ "     and PDU_STATU2 = ' ' "
        cQryPEG += CRLF+ "     and PDU_STATU3 = ' '  "
    
	ElseIf  _cIdUsuar == cAproN2

        cQryPEG += CRLF+ "     and PDU_APROV1  <> ' '  "
        cQryPEG += CRLF+ "     and PDU_APROV2  =  ' '   "
        cQryPEG += CRLF+ "     and PDU_STATU1  in  ('A','S')   "
        cQryPEG += CRLF+ "     and PDU_STATU2  = ' '   "

    ElseIf  _cIdUsuar == cAproN3

        cQryPEG += CRLF+ "     and PDU_STATU2  = 'A'   "
        cQryPEG += CRLF+ "     and (PDU_APROV2 <> ' ' or  PDU_STATU1  = 'S')     "  
		cQryPEG += CRLF+ "     and PDU_STATU1  in  ('A','S')   "  
		cQryPEG += CRLF+ "     and PDU_STATU3  = ' '   "
	
	ElseIf  _cIdUsuar == cAproN4

        cQryPEG += CRLF+ "     and PDU_STATU3   = 'A'   "
//        cQryPEG += CRLF+ "     and PDU_APROV3  <> ' '   "
		cQryPEG += CRLF+ "     and (PDU_APROV3  <> ' ' or  PDU_STATU1  = 'S')     "  
		cQryPEG += CRLF+ "     and PDU_STATU1   in  ('A','S')   "
		cQryPEG += CRLF+ "     and PDU_STATU4   = ' '   "    

    EndIf

EndIf

//Trata usuario permitido  
If ( !_cIdUsuar $ cAproN1 .and. _cIdUsuar != cAproN2  .and. _cIdUsuar != cAproN3 .and. _cIdUsuar != cAproN4)
     cQryPEG += CRLF+ "     and PDU_STATU2  = 'Z'   "
EndIF 
//cQryPEG += CRLF+ "     and pdu_codemp = '0380'  and Pdu_Matfuc = '000649' "

cQryPEG += CRLF+ "   group by Pdu_Codeqp , " 
cQryPEG += CRLF+ "            Pdu_Matfuc , "
cQryPEG += CRLF+ "            Pdu_Nome   , "
cQryPEG += CRLF+ "            Pdu_Compte , "
cQryPEG += CRLF+ "            Pdu_Titpgt , "
cQryPEG += CRLF+ "            Pdu_Perint , "
cQryPEG += CRLF+ "            Pdu_Percen , "
cQryPEG += CRLF+ "            PDU_STATUS , "
cQryPEG += CRLF+ "            BG9_CODIGO , "
cQryPEG += CRLF+ "            bg9_descri , " 
cQryPEG += CRLF+ "            PDU_STATU1 , " 
cQryPEG += CRLF+ "            PDU_STATU2 , "
cQryPEG += CRLF+ "            PDU_STATU3 , "
cQryPEG += CRLF+ "            PDU_STATU4 , "
cQryPEG += CRLF+ "            Pdu.R_E_C_N_O_ " 
cQryPEG += CRLF+ "   Order By Pdu_Codeqp , Pdu_Matfuc , Pdu_Nome ,Pdu_Titpgt "

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

//// alculo do mes/ano atual e anterior (12 meses)

cAno         := substr((cAliasPEG)->Compte ,1,4)
cMes         := substr((cAliasPEG)->Compte ,5,2)


cAnoANT :=  strzero((val(cAno)-1),4)
cMesAnt := cMes

If cMes == '01'
   cMesAtu := '12'
   cAnoATU := strzero((val(cAno)-1),4)
ElseIf cMes >= '02' 
   cMesAtu :=strzero((val(cMes)-1),2)
   cAnoATU :=cAno
EndIF

//cAnoANT := substr(cAnoANT,3,2)
//cAnoATU := substr(cAnoATU,3,2)


//fSinist((cAliasPEG)->CodEmp , substr((cAliasPEG)->Compte ,1,4), substr((cAliasPEG)->Compte ,5,2) )

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
	(cAliasPEG)->Status    ,;  //15
    (cAliasPEG)->RecPdu    ,;  //16
    (cAliasPEG)->Statu1    ,;  //17
    (cAliasPEG)->Statu2    ,;  //18
    (cAliasPEG)->Statu3    ,; //19
	(cAliasPEG)->Statu4    ,; //20
	fSinist((cAliasPEG)->CodEmp , cAnoAnt,cMesAnt, cMesAtu,cAnoAtu )})  //21   

	(cAliasPEG)->(DbSkip())

EndDo
//fSinist((cAliasPEG)->CodEmp , substr((cAliasPEG)->Compte ,1,4), substr((cAliasPEG)->Compte ,5,2) )})  //21   
  
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
				   '',;  //15
                   0 ,;  //16
                   '',;  //17
                   '',;  //18
				   '',;  //19
				   '',;  //20 
                   0.00})  //21
EndIf

Return aRetPEG

/********************************************/
/********************************************/                                    
/***********************************************************************************/
Static Function marca(cRef) // cRef == 1 peg , 2 , proc
	
local nI := 0            
       
	For nI := nI + 1 to len(aBrwPEG)

		if (alltrim(aBrwPEG[nI, 15]) == 'A' .or. alltrim(aBrwPEG[nI, 15]) == '')
		
			aBrwPEG[nI,1]:= .T.

	  	EndIf
	
	Next 	
		
RETURN()	
	
Static Function desmarca(cRef) // cRef == 1 peg , 2 , proc
	
local nI := 0
			
	For nI :=  nI + 1 to len(aBrwPEG)
	
		if (alltrim(aBrwPEG[nI, 15]) == 'A' .or. alltrim(aBrwPEG[nI, 15]) == '')
		
			aBrwPEG[nI,1]:= .F.

		EndIf

    Next
	
RETURN() 

User Function LEG2022()

Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
	              		{ aCdCores[3,1],aCdCores[3,2] },;
						{ aCdCores[4,1],aCdCores[4,2] } }
	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return()

//Static Function fFazlib(nTpLib)
static Function fFazlib(nTpLib , cEmpc, nSinst)

//Local cQryEqp	:= ""

local nI := 0 

If nTpLib == 3
    
	If !MsgYesNo('As Comissoes Marcadas Seram Bloqueadas Definitivamente, Deseja Continuar','SIMNAO')
    
	   RETURN()
    
	EndIf 

EndIF

    DBSELECTAREA("PDU")   

    PDU->(dbSetOrder(1))  

	For nI := nI + 1 to len(aBrwPEG)
			
		If  aBrwPEG[nI,1] == .T.  

            PDU->(DbGoTo(aBrwPEG[nI,16] ))
	
			PDT->(Reclock("PDU",.F.))

                PDU_DTAPRO  := Date()

				If  _cIdUsuar $ cAproN1 
                    
                    If  empty(aBrwPEG[nI,18])
                     
						If  nTplib == 1 
						    
							If  Substr(aBrwPEG[nI,2],1,1) == 'C' 
							    If  aBrwPEG[nI,21] < 75.00 
							        PDU->PDU_APROV1 := " " +_cUsuario + "- Aprovação " +cDthr 
							        PDU->PDU_STATUS := 'A'
							        PDU->PDU_STATU1 := 'A'
				
						        ElseIf aBrwPEG[nI,21] >= 75.00 .and. PDU->PDU_STATU3 != 'A' .and. PDU->PDU_STATU1 != 'S'    
				
							        PDU->PDU_APROV1 := " " +_cUsuario + "- Bloq. Por Sinistralidade " +cDthr 
							        PDU->PDU_STATUS := 'S'
							        PDU->PDU_STATU1 := 'S'				
				
								EndIf 	
							Else 
							    PDU->PDU_APROV1 := " " +_cUsuario + "- Aprovação " +cDthr 
							    PDU->PDU_STATUS := 'A'
							    PDU->PDU_STATU1 := 'A'
							EndIF 	

						ElseIf  nTplib == 2    
								
							PDU->PDU_APROV1 := " " +_cUsuario + "- Bloqueio  " +cDthr
							PDU->PDU_STATUS := 'B'
							PDU->PDU_STATU1 := 'B'
							
						ElseIf  nTplib == 3 .and. PDU->PDU_STATU3 != 'A'   
								
							PDU->PDU_APROV1 := " " +_cUsuario + "-Bloqueio Definitivo " +cDthr 
							PDU->PDU_STATUS := 'X'
							PDU->PDU_STATU1 := 'X'
				
						EndIf  
					EndIf 

                ElseIf  _cIdUsuar $ cAproN2 
                    
                    If  empty(aBrwPEG[nI,19])
                     
                        If nTplib == 1   .and. PDU->PDU_STATU1 == 'A'
                            
                            PDU->PDU_APROV2 := " " +_cUsuario + "- Aprovação " +cDthr 
                            PDU->PDU_STATUS := 'A'
                            PDU->PDU_STATU2 := 'A'

                        ElseIf nTplib == 2 .and. PDU->PDU_STATU1 == 'A'       
                            
                            PDU->PDU_APROV2 := " " +_cUsuario + "- Bloqueio " +cDthr 
                            PDU->PDU_STATUS := 'B'
                            PDU->PDU_STATU2 := 'B'

                        ElseIf  nTplib == 3 .and. PDU->PDU_STATU3 != 'A' .and. PDU->PDU_STATU1 == 'A'   
                            
                            PDU->PDU_APROV2 := " " +_cUsuario + "-Bloqueio Definitivo " +cDthr 
                            PDU->PDU_STATUS := 'X'
                            PDU->PDU_STATU2 := 'X'
                        
                        EndIf

                    EndIf

                ElseIf  _cIdUsuar $ cAproN3 
                                         
                    If nTplib == 1   .and. PDU->PDU_STATU1 != 'S'
                            
                        PDU->PDU_APROV3 := " " +_cUsuario + "- Aprovação Em " +cDthr 
                        PDU->PDU_STATUS := 'A'
                        PDU->PDU_STATU3 := 'A'

                    ElseIf nTplib == 2   .and. PDU->PDU_STATU1 != 'S' 
                            
                        PDU->PDU_APROV3 := " " +_cUsuario + "- Bloqueio Em" +cDthr 
                        PDU->PDU_STATUS := 'B'
                        PDU->PDU_STATU3 := 'B'

                    ElseIf  nTplib == 3 .and. PDU->PDU_STATU3 != 'A' .and. PDU->PDU_STATU1 != 'S'  
                            
                        PDU->PDU_APROV3 := " " +_cUsuario + "-Bloqueio Definitivo " +cDthr 
                        PDU->PDU_STATUS := 'X'
                        PDU->PDU_STATU3 := 'X'

                    EndIf

					ElseIf  _cIdUsuar $ cAproN4 
                                         
                    If nTplib == 1   .and. PDU->PDU_STATU1 != 'S'
                            
                        PDU->PDU_APROV4 := " " +_cUsuario + "- Aprovação Em " +cDthr 
                        PDU->PDU_STATUS := 'A'
                        PDU->PDU_STATU4 := 'A'

                    ElseIf nTplib == 2   .and. PDU->PDU_STATU1 != 'S' 
                            
                        PDU->PDU_APROV4 := " " +_cUsuario + "- Bloqueio Em" +cDthr 
                        PDU->PDU_STATUS := 'B'
                        PDU->PDU_STATU4 := 'B'

                    ElseIf  nTplib == 3 .and. PDU->PDU_STATU4 != 'A' .and. PDU->PDU_STATU1 != 'S'  
                            
                        PDU->PDU_APROV4 := " " +_cUsuario + "-Bloqueio Definitivo " +cDthr 
                        PDU->PDU_STATUS := 'X'
                        PDU->PDU_STATU4 := 'X'

                    EndIf

                EndIf
                
			PDU->(MsUnlock())

        EndIf     

	Next

Return()
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



static Function fSinist(cEmpC, cAnoAnt, cMesAnt, cMesAtu , cAnoAtu)

local aLogLtaRk1:= {}
local cqueryRkS1:= ' '     
local nSinst    := 0.0000

	cqueryRkS1 :=     " SELECT codemp CodEmp , Bg9.Bg9_Descri Emp_1 , "
	cQueryRkS1 +=CRLF+"    round((Sum(APROVADO-PART))/Sum(MENSA),4)*100 SINIS  "
	If  cEmpant=='02'
		cQueryRkS1 +=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9  "
	Else
		cQueryRkS1 +=CRLF+" FROM COB_SINISTRALIDADE_MS_INT , bg9020 bg9 "
	EndIf	             
		
	cQueryRkS1 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod(cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod(cAnoAtu+cMesAtu+'01'))+"','YYYYMMDD')"
	//cQueryRkS1 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod(cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod(cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD')"
	//cQueryRkS1 +=CRLF+"  where MES_ANO_REF between TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD') and TO_DATE('"+DtOS(stod('20'+cAnoAnt+cMesAnt+'01'))+"','YYYYMMDD')"	   
	cQueryRkS1 +=CRLF+"    and   bg9_filial = ' ' and d_E_L_E_T_ =' ' " 
	cQueryRkS1 +=CRLF+"    and bg9_codint ='0001' and bg9_codigo = codemp " 

	    cQueryRkS1 +=CRLF+"    and bg9_codigo = '"+cEmpC+"' "
   
	cQueryRkS1 +=CRLF+"  having Decode(Sum(MENSA),0,0,round((Sum(APROVADO-PART))/Sum(MENSA),6))*100 > 0 "
	cQueryRkS1 +=CRLF+"  group by  codemp , Bg9.Bg9_Descri " 
	cQueryRkS1 +=CRLF+"  order by 3 "

		If Select((cAliasRkC1)) <> 0 
				(cAliasRkC1)->(DbCloseArea())  
		Endif                          

		TCQuery cQueryRkS1 New Alias (cAliasRkC1)   

		(cAliasRkC1)->( DbGoTop() )  
	
        If (cAliasRkC1)->SINIS > 0
	        nSinst    := (cAliasRkC1)->SINIS
	    EndIf 

Return(SINIS)


User Function fBusAlc(cAlc)

Local cQryPEG	:= ""
Local cAliasPEG	:= GetNextAlias()

cQryPEG := CRLF + "       SELECT AK_USER , AK_NOME, AL_COD , AL_DESC , AL_LIBAPR , AL_USERSUP , AK_LIMMIN ,AK_LIMMAX , AL_NIVEL nivel"  
cQryPEG += CRLF + "         FROM "+RetSQLName("SAL")+" SAL , "
cQryPEG += CRLF + "              "+RetSQLName("SAK")+" SAK   "
cQryPEG += CRLF + "        WHERE AL_FILIAL  = '" + xFilial('SAL') + "'  AND SAL.D_E_L_E_T_ = ' ' " 
cQryPEG += CRLF + "          AND AK_FILIAL  = '" + xFilial('SAK') + "'  AND SAK.D_E_L_E_T_ = ' ' "
cQryPEG += CRLF + "          AND AL_COD = '"+cAlc+"' "
cQryPEG += CRLF + "          AND AK_COD = AL_APROV   "
cQryPEG += CRLF + "          order by NIVEL  "

TcQuery cQryPEG New Alias (cAliasPEG)  

(cAliasPEG)->(dbGoTop())    

While !(cAliasPEG)->(EOF())

	If trim((cAliasPEG)->nivel) == "1"
	    If  !empty(cAproN1)
	        cAproN1  +="|"
		EndIf 	
		cAproN1      += alltrim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "2"
	    If  !empty(cAproN2)
	        cAproN2  +="|"
		EndIf 	
		cAproN2      += alltrim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "3"
	    If  !empty(cAproN3)
	        cAproN3  +="|"
		EndIf 	
		cAproN3      += alltrim((cAliasPEG)->ak_user)
	Elseif   trim((cAliasPEG)->nivel) == "4"
	    If  !empty(cAproN4)
	        cAproN4  +="|"
		EndIf 	
		cAproN4      += alltrim((cAliasPEG)->ak_user)
	EndIf 

	(cAliasPEG)->(DbSkip())

EndDo 

Return()
