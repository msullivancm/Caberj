
User Function ListaDep()

Local aSalvAmb := {}
Local aVetor   := {}
Local oDlg     := Nil
Local oLbx     := Nil
Local cTitulo  := "Consulta Participantes"

dbSelectArea("SZ2")
aSalvAmb := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SZ2")+SA1->A1_COD)

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While !Eof() .And. Z2_FILIAL == xFilial("SZ2") .And. Z2_CODCLI==SA1->A1_COD
   aAdd( aVetor, { Z2_NUMASS,Z2_CODPLN,Z2_CODDEP,Z2_NOME,Z2_DTNASC,idadeAss(Z2_DTNASC),Z2_DATINC,Z2_DATEXC,Z2_INDJUD,Z2_OBSJUD,Z2_OPTINT } )
	dbSkip()
End

If Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existe dados a consultar", {"Ok"} )
   Return
Endif

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

@ 10,10 LISTBOX oLbx FIELDS HEADER ;
   "Matrícula", "Plano", "Cod. Dep.","Nome", "Dt. Nascimento","Idade", "Dt. Inclusão", "Dt. Exclusão","Ind. Judicial","Obs. Judicial","Opt. Integralização" ;  	//nome do cabecalho
   SIZE 230,095 OF oDlg PIXEL	

//define com qual vetor devera trabalhar
oLbx:SetArray( aVetor )
//lista o conteudo dos vetores, variavel nAt eh a linha pintada (foco) e o numero da coluna
oLbx:bLine := {|| {aVetor[oLbx:nAt,1],;
                   aVetor[oLbx:nAt,2],;
                   aVetor[oLbx:nAt,3],;
                   aVetor[oLbx:nAt,4],;
                   aVetor[oLbx:nAt,5],;
                   aVetor[oLbx:nAt,6],;
                   aVetor[oLbx:nAt,7],;
                   aVetor[oLbx:nAt,8],;
                   aVetor[oLbx:nAt,9],;
                   aVetor[oLbx:nAt,10],;
                   aVetor[oLbx:nAt,11]}}
	                    
DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER

RestArea( aSalvAmb )
Return .T.

//CALCULA A IDADE
Static function idadeAss(dataN)
local idade:=0

idade:=year(DATE())-year(dataN) 
if (((month(dataN)*100) + day(dataN))> ((month(DATE())*100)+day(date())))
  idade:=idade-1
endif
return(idade)