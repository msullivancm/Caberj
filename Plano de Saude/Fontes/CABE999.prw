#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"
#INCLUDE "FONT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABE999   º Autor ³ Erisson Diniz      º Data ³  09/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Negociação de Titulos Atrasados                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABE999()

Private cCadastro := "Negociação de Titulos Atrasados"


Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Negociação","U_CABE999A",0,2}}


Private cDelFunc := ".T."

Private cString := "SA1"

dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return

//************************************************************************************************************
// Interface de Negociacao
User Function CABE999A( calias , c_recno , nop)

Local cSepNeg   := If("|"$MV_CRNEG,"|",",")
Local cSepProv  := If("|"$MVPROVIS,"|",",")
Local cSepRec   := If("|"$MVRECANT,"|",",")

o_DLG := Nil

Define FONT oFont1 	NAME "Arial" SIZE 0,20 OF o_Dlg Bold

Private oCond
Private oVlTotTit
Private oValParc
Private o_DataNeg
Private oSay
Private o_Dlg				// Dialog Principal
Private oLBx1
Private oLBx2
Private oOk          	 := LoadBitmap( GetResources(), "LBOK" )
Private oNo       		 := LoadBitmap( GetResources(), "LBNO" )

Private aListBox1    := {}
Private aListBox2 	 := {}

Private aSize 		 := MsAdvSize()
Private aObjects    	 := {}
Private aInfo
Private aPosObj      := {}
Private a_Vetor     	 := {}
Private a_VetTit    	 := {}
Private a_VetParc   := {}
Private c_CLiente    := ""
Private c_Loja		 := ""
Private n_SomaValJM  			:= 0    // Somatório do valor da Parcela + Juro + Multa
Private c_Cond	     := Space(25)
Private c_say
Private n_VlTotTit	 := 0
Private n_ValParc	 := 0
Private d_DataNeg  := CtoD("  /  /  ")

Private lMark     := .F.


dbSelectArea("SA1")
dbGoTo(c_recno)
c_CLiente := SA1->A1_COD
c_Loja    := SA1->A1_LOJA

dbSelectArea("SE1")

cQuery:="SELECT E1_PREFIXO, E1_NUM,E1_PARCELA, E1_TIPO, E1_SALDO , E1_VENCTO,E1_CLIENTE FROM " + RetSQLName("SE1")+ " SE1 "
cQuery+=" WHERE SE1.D_E_L_E_T_ =  ' ' "
cQuery+="   AND E1_FILIAL = '"+xFilial("SE1")+"' "
cQuery+="   AND E1_CLIENTE = '"+c_Cliente+"' "
cQuery+="   AND E1_LOJA    = '"+c_Loja+"' "
/*------------------------------------------------------------*/
/* Alterado por Jeferson Couto               em 15/10/2007    */
/* Liberar os titulos vencidos e a vencer para reparcelamento */
/* apenas respeitando a emissão do títulos estando anterior   */
/* a database do sistema                                      */
/*------------------------------------------------------------*/
//cQuery+="   AND E1_VENCTO < '"+DtoS(dDataBase)+"' "
cQuery+="   AND E1_EMISSAO <= '"+DtoS(dDataBase)+"' "
cQuery+="   AND E1_SALDO > 0 "
cQuery+="   AND E1_TIPO NOT IN " + FormatIn(MVABATIM,"|")
cQuery+="   AND E1_TIPO NOT IN " + FormatIn(MV_CRNEG,cSepNeg)
cQuery+="   AND E1_TIPO NOT IN " + FormatIn(MVPROVIS,cSepProv)
cQuery+="   AND E1_TIPO NOT IN " + FormatIn(MVRECANT,cSepRec)

cQuery+="   ORDER BY E1_NUM "

TcQuery cQuery Alias "QRY" New

While !eof()
	
	aAdd(a_VetTit,{ lMark ,QRY->E1_PREFIXO,QRY->E1_NUM,QRY->E1_PARCELA,QRY->E1_TIPO,QRY->E1_SALDO,QRY->E1_VENCTO })
	
	dbSelectArea("QRY")
	DbSkip()
Enddo

dbSelectArea("QRY")
DbCloseArea()


If len(a_VetTit)  = 0
	Alert("Não existem Títulos à Negociar para esse Cliente!")
	Return
Endif

aAdd(a_VetParc,{ "","","","",CtoD(""), 0 , 0})
//aAdd(a_VetParc,{ "", "" })

AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 100 , .T., .F. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )


DEFINE MSDIALOG O_DLG TITLE "Negociação de Títulos Atrasados" FROM aSize[7],0 to aSize[6]+30,aSize[5]*.8 PIXEL

@ 017,007 Say "Títulos Atrasados" Size 150,010 FONT oFont1 COLOR CLR_HBLUE PIXEL OF o_Dlg
@ 030,007 LISTBOX oLbx1 FIELDS HEADER "","Prefixo","Numero","Parcela","Tipo","Valor","Dt. Vencto " SIZE 310  , 120 OF o_Dlg ;
PIXEL ON dblClick((a_VetTit[oLbx1:nAt,1] := !a_VetTit[oLbx1:nAt,1]),( U_SomaVal(a_VetTit[oLbx1:nAt,1],a_VetTit[oLbx1:nAt,6])))
//                                                                                 Flag         ,   Valor
oLbx1:SetArray(a_VetTit)
oLbx1:bLine:={|| {Iif(a_VetTit[oLbx1:nAt,1],oOk,oNo),a_VetTit[oLbx1:nAt,2],a_VetTit[oLbx1:nAt,3],a_VetTit[oLbx1:nAt,4],a_VetTit[oLbx1:nAt,5],Trim(Transform(a_VetTit[oLbx1:nAt,6],"@E 999,999,999.99")),StoD(a_VetTit[oLbx1:nAt,7])}}

//E1_PREFIXO, E1_NUM, E1_TIPO
@ 160,007 Say "Parcelas Negociadas" Size 150,010 FONT oFont1 COLOR CLR_HBLUE PIXEL OF o_Dlg
@ 173 , 007 LISTBOX oLbx2 VAR cVar FIELDS HEADER "Prefixo","Numero","Parcela","Tipo","Dt. Vencto", "Valor","Valor Simulado" SIZE 310 , 110 OF o_Dlg ;
PIXEL ON dblClick(oLbx2:Refresh())

oLbx2:SetArray(a_VetParc)
oLbx2:bLine := {|| {a_VetParc[oLbx2:nAt,1],a_VetParc[oLbx2:nAt,2],a_VetParc[oLbx2:nAt,3],a_VetParc[oLbx2:nAt,4],a_VetParc[oLbx2:nAt,5],;
RTrim(Transform(a_VetParc[oLbx2:nAt,6],"@E 999,999,999.99")),RTrim(Transform(a_VetParc[oLbx2:nAt,7],"@E 999,999,999.99")) }}


@ 030,325 Say "Data para Negociação" Size 063,008  COLOR CLR_BLACK PIXEL OF o_Dlg
@ 038,325 MsGet oDataNeg Var d_DataNeg Valid U_Cab998Atu() Size 054,009  COLOR CLR_BLACK  Picture "@!"  PIXEL OF o_Dlg


@ 055,325 Say "Condição de Pagamento" Size 063,008  COLOR CLR_BLACK PIXEL OF o_Dlg
@ 063,325 MsGet oCond Var c_Cond Size 054,009 Valid U_fCab999Par(n_VlTotTit,c_Cond) F3 "SE4" COLOR CLR_BLACK  Picture "@!"  PIXEL OF o_Dlg


@ 080,325 Say "Valor Total" Size 036,008 COLOR CLR_BLACK PIXEL OF o_Dlg
@ 088,325 MsGet oVlTotTit Var n_VlTotTit  Size 054,009 COLOR CLR_BLACK Picture "@E 999,999,999.99" When .F. PIXEL OF o_Dlg


@ 170,325 Say "Vl. Médio das Parcelas" Size 063,008 COLOR CLR_BLACK PIXEL OF o_Dlg
@ 180,320 Say oSay Var c_Say       Size    054,008 COLOR CLR_BLACK PIXEL OF o_Dlg
@ 178,333 MsGet ValParc Var n_ValParc  Size 054,009 COLOR CLR_BLACK Picture "@E 999,999,999.99" When .F. PIXEL OF o_Dlg


@ 220,325 Button "Efetiva Negociação" 	 Size 050,012 Action U_Cab999Grav() PIXEL OF o_Dlg//
@ 240,325 Button "Imprime Termo" 		 Size 050,012 Action U_Cabr999(c_Cliente,c_Loja,n_SomaValJM,a_Vetor,a_VetParc,n_ValParc) PIXEL OF o_Dlg

ACTIVATE MSDIALOG O_DLG CENTERED ON INIT EnchoiceBar(o_Dlg,{||o_Dlg:End()},{||o_Dlg:End()})

Return(.T.)

*-----------------------------------------------------------------*
User Function SomaVal(l_Marcado,n_Valor)
*-----------------------------------------------------------------*
* Funcção para soma dos valores
*-----------------------------------------------------------------*

n_tux := 0

If l_Marcado
	
	n_VlTotTit += n_Valor
	
Else
	
	n_VlTotTit -= n_Valor
	
EndIf

oVlTotTit:Refresh()

If !Empty(c_Cond)
	U_fCab999Par(n_VlTotTit,c_Cond)
Endif

Return


*--------------------------------------------------------------------------------------------------------------------------------*
User Function fCab999Par(n_ValTot,c_Cond)
*--------------------------------------------------------------------------------------------------------------------------------*
* Preenchimento do Listbox com as parcelas de acordo com a condição escolhida          *
*--------------------------------------------------------------------------------------------------------------------------------*

Local n_z := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n_i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local l_Ret        		:= .T.
Local a_aux        		:= {}
Local n_Cont      		:= 0
Local _x                    := 0
Local aTotMes           := {0,0}
Local dVencAnt
Local i

n_SomaValJM           := 0

a_VetParc         		:= {}

If !Empty(c_Cond) .And. !Empty(d_DataNeg)
	For n_i := 1 To Len(a_VetTit)
		
		If a_VetTit[n_i,1]
			
			a_Vetor :=  Condicao(a_VetTit[n_i,6],c_Cond,,d_DataNeg)
//			a_Vetor :=  Condicao(a_VetTit[n_i,6],c_Cond,,dDataBase)
			
			For n_z:=1 To Len(a_Vetor)
				
				aAdd(a_VetParc,{ "","","","",CtoD(""), 0, 0 })
				
				n_ValJM	:= U_CABA997(StoD(a_VetTit[n_i,7]),a_Vetor[n_z,1],a_Vetor[n_z,2],.F.) // Valor com Juro + Multa
				
				a_VetParc[len(a_VetParc),1] := a_VetTit[n_i,2]
				a_VetParc[len(a_VetParc),2] := a_VetTit[n_i,3]
				a_VetParc[len(a_VetParc),3] := a_VetTit[n_i,4]
				a_VetParc[len(a_VetParc),4] := a_VetTit[n_i,5]
				a_VetParc[len(a_VetParc),5] := a_Vetor[n_z,1]
				a_VetParc[len(a_VetParc),6] := a_Vetor[n_z,2]
				a_VetParc[len(a_VetParc),7] := a_Vetor[n_z,2]+ n_ValJM
				
				n_SomaValJM += a_Vetor[n_z,2]+ n_ValJM
				
				
			Next n_z
			
		EndIf
		
	Next n_i
	
	
	a_VetParc := aSort(a_VetParc,,, {|x,y| x[5] < y[5] })
	
	nContTit := 0
	aEVal(a_VetTit,{|x| If(x[1],nContTit++,)})
	
	If nContTit > 1
		dVencAnt := If(len(a_VetParc) > 0, a_VetParc[1,5] ,"")
		aTotMes := {0,0}
		
		For i:=1 to len(a_VetParc)
			
			If dVencAnt <> a_VetParc[i,5]
				aAdd(a_VetParc,{ "TOTAL","DO","VENCTO","",dVencAnt, aTotMes[1], aTotMes[2] })
				aTotMes := {0,0}
				dVencAnt := a_VetParc[i,5]
			Endif
			
			aTotMes[1] += a_VetParc[i,6]
			aTotMes[2] += a_VetParc[i,7]
			
		Next
		
		aAdd(a_VetParc,{ "TOTAL","DO","VENCTO","",dVencAnt, aTotMes[1], aTotMes[2] })
		
	Endif
	
	//    a_VetParc := aSort(a_VetParc,,, {|x,y| x[5] < y[5] })
	
	oLbx2:SetArray(a_VetParc)
	oLbx2:bLine := {|| {a_VetParc[oLbx2:nAt,1],a_VetParc[oLbx2:nAt,2],a_VetParc[oLbx2:nAt,3],a_VetParc[oLbx2:nAt,4],a_VetParc[oLbx2:nAt,5],;
	RTrim(Transform(a_VetParc[oLbx2:nAt,6],"@E 999,999,999.99")),RTrim(Transform(a_VetParc[oLbx2:nAt,7],"@E 999,999,999.99")) }}
	
	n_ValParc  := (n_SomaValJM/Len(a_Vetor) )
	
	c_Say := AllTrim(Str( Len ( a_Vetor )  ))+ " x"
	
	oLbx2:Refresh()
	ValParc:Refresh()
	oSay:Refresh()
	
Else
	
	Aviso("Atenção","Verifique se a Condição de Pagamento e a Data para Negociação estão informados corretamente!", {"Ok"} )
	//	Aviso("Atenção","Informe uma Condição de Pagamento!", {"Ok"} )
	
	l_Ret := .F.
	
EndIf


Return l_Ret

*---------------------------------------------------------------------------*
User Function Cab999Grav()
*---------------------------------------------------------------------------*
* Execução da baixa dos Titulos Selecionados                                           *
*---------------------------------------------------------------------------*

Local n_i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n_x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local	nContTit := 0



aEVal(a_VetTit,{|x| If(x[1],nContTit++,)})

If !Empty(c_Cond) .and. nContTit > 0
	
	For n_i := 1 To Len(a_VetTit)
		
		If a_VetTit[n_i,1]
			
			lCABE999 := 	.F.
			lMsErroAuto := .F.
			
			aVetor := {  {"E1_PREFIXO"	  ,a_VetTit[n_i,2]      ,Nil},;
			{"E1_NUM"		  					  ,a_VetTit[n_i,3]      ,Nil},;
			{"E1_PARCELA"	  				  ,a_VetTit[n_i,4]      ,Nil},;
			{"E1_TIPO"       						  ,a_VetTit[n_i,5]      ,Nil},;
			{"AUTMOTBX"	  					  ,"NEG"                 ,Nil},;  
			{"AUTDTBAIXA"	  					  ,dDataBase             ,Nil},;
			{"AUTDTCREDITO"  				  ,dDataBase             ,Nil},;
			{"AUTHIST"	      					  ,'Baixa por Negociacao',Nil},;
			{"AUTVALREC"	  					  ,a_VetTit[n_i,6]       ,Nil }}
			
			MSExecAuto({|x,y| fina070(x,y)},aVetor,3) //Inclusao
			
			If lMsErroAuto
				
				l_Erro  := .T.
				mostraerro()
				
			Endif
			lCABE999 := 	.T.
		EndIf                                                                                     
		
		
		
	Next n_i
	c_nParc := 0
	For n_x := 1  To Len(a_VetParc)
		
		If  a_VetParc[n_x,1] != "TOTAL"
			c_nParc ++
			dbSelectArea("SZ6")
			RecLock("SZ6",.T.)
			
			SZ6->Z6_FILIAL   := xFilial("SZ6")
			SZ6->Z6_CHAVE    := a_VetParc[n_x][1]+a_VetParc[n_x][2]+a_VetParc[n_x][3]+a_VetParc[n_x][4]
			SZ6->Z6_DATATIT  := a_VetParc[n_x][5]
			SZ6->Z6_VALTIT   := a_VetParc[n_x][6]
			SZ6->Z6_SEQ		  := alltrim(str(c_nParc))  + "/" + ALLTRIM(STR(Len(a_VetParc)))
			SZ6->Z6_CLIENTE  := c_cliente
			SZ6->Z6_LOJACLI  := c_loja      
			SZ6->Z6_GERADO  := "N"
			SZ6->Z6_DATAMOV := DATE()
			MsUnLock()
			
		EndIf
		
	Next n_x
	ALERT("Informações do Parcelamento gravadas com Sucesso!")
Else
	
	Aviso("Atenção","Informe uma Condição de Pagamento e Marque no Minimo um título!", {"Ok"} )
	l_Ret := .F.
	
EndIf

*---------------------------------------------------------------------------*
User Function Cab998Atu()
*---------------------------------------------------------------------------*
* Atualiza os valores e as Datas caso seja trocada a Data
*---------------------------------------------------------------------------*

If !Empty(c_Cond)
	U_fCab999Par(n_VlTotTit,c_Cond)
Endif

Return





Return
