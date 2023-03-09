#include "Rwmake.ch"        
#include "Msole.CH"
#include "TopCOnn.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR999   ºAutor  ³Erisson Diniz       º Data ³  12/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Impressaõ do Termo de Negociação                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
************************************************************
User Function CABR999(c_Cliente,c_Loja,n_SomaValJM,a_Vetor,a_VetParc,n_ValParc)
************************************************************        
Private aArea          := GetArea()
Private c_Nome         := ""
Private c_Ident        := ""
Private c_MatPlan      := ""
Private n_ValTot       := n_SomaValJM
Private n_QtdParc      := Len(a_Vetor)    
Private d_DataIni    
Private d_DataFim                           
Private c_Matric
Private c_NomPlan

d_DataIni    := a_Vetor[1,1]

If Len(a_Vetor) > 1

	d_DataFim  := " e a última em  " + DtoC(a_Vetor[Len(a_Vetor),1])

Else

	d_DataFim  := " "

EndIf

c_Prefix  := a_VetParc[1,1]
c_Num   := a_VetParc[1,2]
c_Parc   := a_VetParc[1,3]
c_Tipo    := a_VetParc[1,4]

// Obtensao do Numero da Matricula do Cliente
BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
BBT->(MsSeek(xFilial("BBT")+ c_Prefix+c_Num+c_Parc+c_Tipo))			
c_CodInt := BBT->BBT_CODOPE
c_CodEmp := BBT->BBT_CODEMP
c_Matric  := BBT->BBT_MATRIC
c_ConEmp := BBT->BBT_CONEMP
c_VerCon := BBT->BBT_VERCON
c_SubCon := BBT->BBT_SUBCON
c_cVerSub := BBT->BBT_VERSUB
c_cNiveCob := BBT->BBT_NIVEL             
c_codPlan  := BBT->BBT_CODPLA    
c_verPlan	 := BBT->BBT_VERSAO   

// OBTER MATRICULA
cDIGITO := Modulo11(BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC+BBT->BBT_TIPREG)		
cMatric := c_CodInt +c_CodEmp+c_Matric+cDIGITO

// NOME DO PLANO
BI3->(DbSetOrder(1)) 
BI3->(MsSeek(xFilial("BI3")+ c_CodInt+c_codPlan+c_verPlan))
c_NomePlan := BI3->BI3_NREDUZ

c_MatPlan  :=  ALLTRIM(cMatric) + "  " + ALLTRIM(c_NomePlan) 

// NOME DA OPERADORA
BA0->(DbSetOrder(1)) 
BA0->(MsSeek(xFilial("BA0")+ PLSINTPAD()))   

c_NomeOper := BA0->BA0_NOMINT
c_Cnpj := BA0->BA0_CGC
c_Ans :=  BA0->BA0_SUSEP

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+c_Cliente+c_Loja)
c_Nome := SA1->A1_NOME
c_Ident  := SA1->A1_PFISICA

////////////////////////////////////////////////////////
                             
Processa({|| WORDIMP(c_Nome,c_Ident,c_MatPlan,n_ValTot,n_ValParc,n_QtdParc,d_DataIni,d_DataFim)}) //c_MatPlan 

	
Return

**********************************************************************
Static FUNCTION WORDIMP(c_Nome,c_Ident,c_MatPlan,n_ValTot)
**********************************************************************
Local d_DataExt   := STRZERO(Day(dDataBase),2)+" de "+;
MesExtenso(dDataBase)+" de "+StrZero(Year(dDataBase),4)


// Local onde deve estar o arquivo modelo (*.DOT)
// Nao esuqecer de tirar o Servidor   , deixar somente a pasta \integração.... 
// Só funcionou com o caminho passado diretamente como está no Servidor
//    ou seja a pasta no servidor - Motta 27/6/7

cArquivo := GetNewPar("MV_YATNEG","M:\Protheus_Data\Integração Protheus x Office\CABERJ_3.dot")

// Inicia o Word 
//nVez := 1

// Inicializa o Ole com o MS-Word 97 ( 8.0 )	
oWord := OLE_CreateLink('TMsOleWord97')		

OLE_NewFile(oWord,cArquivo)
OLE_SetProperty( oWord, oleWdVisible,   .T. )
OLE_SetProperty( oWord, oleWdPrintBack, .T. ) 
                                                                                                                                   
c_ValTot   := Transform(n_ValTot   ,"@R  999,999,999.99") 
c_ValParc := Transform(n_ValParc,"@R  999,999,999.99") 


// Variaveis que serão substituidas 
OLE_SetDocumentVar(oWord,"c_Nome"      , c_Nome)
OLE_SetDocumentVar(oWord,"c_Ident"        , c_Ident)
OLE_SetDocumentVar(oWord,"c_MatPlan" 	 , c_MatPlan)                                                     

OLE_SetDocumentVar(oWord,"c_Oper"  , c_NomeOper)               
OLE_SetDocumentVar(oWord,"c_Cnpj"  , c_Cnpj)               
OLE_SetDocumentVar(oWord,"c_Ans"  , c_Ans)               

OLE_SetDocumentVar(oWord,"n_ValTot"  	 , c_ValTot  + " (" +Extenso(n_ValTot,.F.,1) + ")"  )
OLE_SetDocumentVar(oWord,"n_QtdParc"  , AllTrim(Str(n_QtdParc)) + " ( " +Extenso(n_QtdParc,.T.,1)+ " )" )
OLE_SetDocumentVar(oWord,"n_ValParc"   ,c_ValParc  + " ("+ Extenso(n_ValParc,.F.,1)+ ")" )
OLE_SetDocumentVar(oWord,"d_DataIni"    , d_DataIni)
OLE_SetDocumentVar(oWord,"d_DataFim"  , d_DataFim)
OLE_SetDocumentVar(oWord,"d_DataExt"  , d_DataExt)   
            

//--Atualiza Variaveis
OLE_UpDateFields(oWord)

 RestArea(aArea)
Return