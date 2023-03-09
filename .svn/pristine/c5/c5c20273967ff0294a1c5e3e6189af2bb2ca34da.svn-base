#include 'protheus.ch'
#include 'topconn.ch'

#define cEol chr(13)+chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVERSXS    บAutor  ณLeandro Carvalho    บ Data ณ  03/05/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ   Compara sxs E GERA um htm com os dados  alteradios       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User function VERSXS

Local   n_opc   := 2
Local   oDlg1
Local   c_alias     := SPACE(3)
Local   c_tab       := SPACE(2)
Local   c_par       := SPACE(10)
Local   c_indice    := SPACE(3)
Local   c_consulta  := SPACE(6)
Local   c_campo     := SPACE(10)

aItens := { "SX2 - Arquivos" , "SX3 - Campos" ,"SX5 - Tabela Generica" , "SX6 - Parametros" , "SX7 - Gatilhos" , "SXB - Consulta Padrใo" , "SIX - Indices" }

Private o_radio
Private n_radio  := 0
Private cPatMod  := "N:\Protheus_Data\SIGADOC\DOCUMENTACOES\ALTERACOES\Modelos\"
Private cPatgrv  := "N:\Protheus_Data\SIGADOC\DOCUMENTACOES\ALTERACOES\"
Private c_dirimp := "\system\                              "
Private  a_nao_tem    := {}
Private  a_nome      := {}
Private	a_ti_di      :=  {}
Private	a_difer      :=  {}
Private  c_arquivo
Private  _localdriver
Private  c_ext


While n_opc <>  0
	
	n_opc   := 0
	n_Radio := 0
	
	a_nao_tem := {}
	a_nome    := {}
	a_difer   :=  {}
	
	//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS - VERSXS.PRW(56)   Command has no effect 
	//c_arquivo
	
	DEFINE MSDIALOG oDlg1 FROM 000,000 TO 230,310 PIXEL TITLE "Verifica็ใo "
	
	@ 001,003 TO 070,120 LABEL "" OF oDlg1 PIXEL
	@ 008,008 RADIO o_Radio VAR n_Radio ITEMS "SX2 - Arquivos" , "SX3 - Campos" ,"SX5 - Tabela Generica" , "SX6 - Parametros" , "SX7 - Gatilhos" , "SXB - Consulta Padrใo" , "SIX - Indices"  SIZE 100,009 PIXEL OF oDlg1
	
	@ 075,008 SAY   "Arquivo do Sx que serแ comparado"      SIZE 130,008 PIXEL OF oDlg1
	@ 085,008 MSGET c_dirimp                                SIZE 130,010 WHEN .F. PIXEL OF oDlg1
	
	DEFINE SBUTTON FROM 003,124 TYPE 1 OF oDlg1 ENABLE ONSTOP "Confirma" ACTION IIf ( n_Radio<>0  , (oDlg1:End() , n_opc :=1 ) , alert("Selecione uma op็ใo") )
	DEFINE SBUTTON FROM 020,124 TYPE 2 OF oDlg1 ENABLE ONSTOP "Sair..."  ACTION (oDlg1:End() , n_opc :=0 )
	
	//	@ 085, 140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg1    Action(c_dirimp := cGetFile('*.*','',1,,.T.,GETF_RETDIRECTORY))
	@ 085, 140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg1    Action(c_dirimp := cGetFile( "DBF |S?????.DBF|DTC |S?????.DTC", "Selecione o Arquivo para ser Comparado:" ))
	ACTIVATE MSDIALOG oDlg1 CENTER VALID (n_Radio<>0)  .and. file(c_dirimp)
	
	If n_opc = 1
		
		c_dirimp := alltrim(c_dirimp)
		c_ext    := UPPER(substr(c_dirimp , ( len(c_dirimp) -  2 )  , 3 ) )
	
		IF c_ext  = 'DBF'
			_localdriver := "DBFCDXADS"
		Else
			_localdriver := "CTREECDX"
		Endif
		
		c_alias   := substr(aItens[n_Radio] , 1 , 3 )
		Do Case
			Case n_Radio = 1 // "SX2" - Arquivos"
				Processa( {|x|	Comp_ara(  "SX2"+Alltrim(cempant)+"0" , "X2_CHAVE"                 , 1 ) } )
			Case n_Radio = 2 // "SX3 - Campos"
				Processa( {|x|	Comp_ara(  "SX3"+Alltrim(cempant)+"0" , "X3_CAMPO"                 , 2 , "X3_ORDEM|X3_USADO" )} )
			Case n_Radio = 3 // "SX5 - Tabelas Genericas"
				Processa( {|x|	Comp_ara(  "SX5"+Alltrim(cempant)+"0" , "X5_FILIAL+X5_TABELA+X5_CHAVE", 1 ,  , "TOP" )} )
			Case n_Radio = 4 // "SX6 - Parametros"
				Processa( {|x|	Comp_ara(  "SX6"+Alltrim(cempant)+"0" , "X6_FIL+X6_VAR"            , 1  )} )
			Case n_Radio = 5 // "SX7 - Gatilhos"
				Processa( {|x|	Comp_ara(  "SX7"+Alltrim(cempant)+"0" , "X7_CAMPO+X7_SEQUENC"      , 1  )} )
			Case n_Radio = 6 // "SXB - Consulta Padrใo"
				Processa( {|x|	Comp_ara(  "SXB"+Alltrim(cempant)+"0" , "XB_ALIAS+XB_TIPO+XB_SEQ+XB_COLUNA"  , 1 )} )
			Case n_Radio = 7 // "SIX - Indices"
				Processa( {|x| Comp_ara(  "SIX"+Alltrim(cempant)+"0" , "INDICE+ORDEM"             , 1 )} )
		Endcase
		
		Processa( {|x| lista(c_alias) } )
		
	Endif
	
Enddo


Return
*-----------------------------------------------------------------------------*
Static Function abresx5( c_file )
*-----------------------------------------------------------------------------*
* Abre o top conect do sx5
*-----------------------------------------------------------------------------*




Local cRet := "COMPARA"
cBDSiga    := "SIGAPROD"
c_file     :=  UPPER(c_file)  

cQuery := "SELECT * FROM "+cBDSiga+".dbo."+c_File

If Select("COMPARA") > 0
	DbSelectArea("COMPARA")
	DbCloseArea()
Endif

TCQUERY cQuery NEW ALIAS "COMP2"

DbSelectArea("SX5")
aStru := DbStruct()

cArq := CriaTrab(aStru)

DbSelectArea("COMP2")
Copy To &cArq
DbCloseArea()

DbUseArea( .T. ,_localdriver, cArq , "COMPARA", NIL, .F. )

Return( cRet )


*------------------------------------------------------------------------------------*
Static function Comp_ara( c_nomearq  , c_ind , n_setorder , c_ignor , c_aliastop )
*------------------------------------------------------------------------------------*
* Compara os SXS
*------------------------------------------------------------------------------------*

Local M := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local c_arquivo := alltrim(c_dirimp)
Local c_indice  := c_ind
Local c_alias   := substr(c_nomearq , 1 , 3 )
Local a_2camp   := {}

c_ignor    := IIF(ValType(c_ignor)<>"U", c_ignor, "")
c_aliastop := IIF(ValType(c_aliastop)<>"U",abresx5( c_nomearq ),"")

Private  n_cont := 0

if Len(c_aliastop) = 0
	If  !file(c_arquivo)
		Alert("arquivo "+c_arquivo+" Nao existe")
	Endif
	
	Dbusearea(.t.,_localdriver,c_arquivo,"COMPARA",.T.,.T.)    // SX3 QUE SE UTILIZARA COMO BASE
endif
cInd := CriaTrab(NIL,.F.)
DbSelectArea("COMPARA")
IndRegua("COMPARA",cInd, c_indice ,,,"Selecionando Registros...")


DbSelectArea(c_alias)
Procregua( LastRec() )
Dbsetorder( n_setorder )
DbGoTop()

For M:=1 to FCount()
	
	Aadd ( a_nome , fieldname(m) )
	
Next
if c_alias = "SX2"
	aAdd( a_nome , "Documentado ?" )
endif

c_ind := C_ALIAS+"->("+C_IND+")"

While !Eof()
	
	a_camp := {}
	
	For M:=1 to FCount()
		
		Aadd ( a_camp , fieldget(m) )
		
	Next
	
	DbSelectArea("COMPARA")
	a_2camp := {}
	For m := 1 to FCount()
		aAdd( a_2camp , Fieldname(m) )
	Next m
	n_Campos := Len( a_nome )
	
	if aScan( a_2Camp ,{ |x| x = 'R_E_C_N_O_' }) <> 0
		n_Campos++
	elseif c_alias = "SX2"
		n_Campos--
	endif
	
	If FCount() <> n_Campos
		ALERT("Estruturas diferentes")
		Exit
	Endif
	
	
	If DbSeek(&c_ind)
		
		
		//If c_alias == "SX3"
		
		For M:=1 to FCount()
			//If alltrim(Fieldname(m)) <> "X3_ORDEM"
			If !(alltrim(Fieldname(m)) $ c_ignor)
				c_compara := c_alias+"->"+Fieldname(m)+ " =  COMPARA->"+Fieldname(M)
				If !&c_compara
					//Aadd(	a_difer ,  { SX3->X3_CAMPO ,  Fieldname(m) , &("COMPARA->"+Fieldname(m)) , &("SX3->"+Fieldname(m))   } )
					Aadd(	a_difer ,  { &C_IND ,  Fieldname(m) , &("COMPARA->"+Fieldname(m)) , &(c_alias+"->"+Fieldname(m))   } )
				Endif
			Endif
		Next
		
		//Endif
		
	Else
		if c_Alias = 'SX2'
			xPos := aScan( a_nome ,{ |x| x = "X2_CHAVE" })
			
			aAdd( a_Camp , IIF(File(cPatgrv+"ARQUIVOS\"+a_Camp[xPos]),"Sim","Nao") )
			
		endif
		
		Aadd( a_nao_tem , a_camp )
		
	Endif
	
	DbSelectArea(c_alias)
	Incproc()
	Dbskip()
	
Enddo

DbSelectarea("COMPARA")
dbclosearea()

Return

*------------------------------------------------------------------------------------*
Static function lista(c_alias)
*------------------------------------------------------------------------------------*
* Lista as diferencas encontradas
*------------------------------------------------------------------------------------*

Local n_k , n_v

a_ti_di := {}
Aadd( a_ti_di ,  { "Campo do "+c_alias , "Campo Difer" , c_alias+" Base comparacao   " , c_alias+" Base em uso" } )


Procregua( (len(a_nome)+ len(a_difer)))


MakeDir("C:\SIGAHTM")

vArq  := "C:\SIGAHTM\ver"+c_alias+".HTM"
Arqhtm:= MsfCreate(vArq)

cLin:= "<HTML>"+cEol
cLin+= "	<HEAD>"+cEol
cLin+= '	<META HTTP-EQUIV="Content-Type:application/vnd.ms-excel"> '+cEol
cLin+= "	<TITLE>Campos nao encontrados na Base de comparacao que Existem na base em uso</TITLE>"+cEol
cLin+= "	</HEAD>"+cEol
cLin+= "	<BODY>"+cEol
cLin+= "		<CENTER>"+cEol



If len(a_nao_tem) > 0
	*----------------------*
	* Lista os Campos criados
	*----------------------*
	cLin+= "			<H1>Sxs Criados</H1>"+cEol
	cLin+= "			<TABLE BORDER=1 STYLE='border-collapse: collapse;'> "+cEol
	cLin+= "				<TR>"+cEol
	For n_k  := 1 to len(a_nome)
		cLin+= "					<TH>"+a_nome[n_k]+"</TH>"+cEol  // cabecalho
	Next
	cLin+= "				</TR>"+cEol
	For n_k := 1 to len(a_nao_tem) 												 // Lista os campos com suas propriedades
		cLin+= "				<TR>"+cEol
		For n_v:= 1 to len(a_nao_tem[n_k ])
			If valtype(a_nao_tem[n_k][n_v]) = 'N'
				cLin+= "					<TD>"+STR(a_nao_tem[n_k ][n_v],15,2)+"</TD>"+cEol
			Else
				cLin+= "					<TD>"+a_nao_tem[n_k ][n_v]+"</TD>"+cEol
			Endif
		Next
		cLin+= "				</TR>"+cEol
		Incproc()
		
		fWrite(Arqhtm,cLin)
		cLin:= " "
		
	Next
	
	cLin+= "			</TABLE>"+cEol
	
	fWrite(Arqhtm,cLin)
	cLin:= " "
	
Endif

IF len(a_difer) > 0
	cLin+= "			<H1>Campos Alterados</H1>"+cEol
	cLin+= "			<TABLE BORDER=1 STYLE='border-collapse: collapse;'> "+cEol
	cLin+= "				<TR>"+cEol
	For n_k := 1 to len(a_ti_di[1])
		cLin+= "					<TH>"+A_TI_DI[1][n_k]+"</TH>"+cEol
	Next
	cLin+= "				</TR>"+cEol
	For n_k := 1 to len(a_difer)
		cLin+= "				<TR>"+cEol
		For n_v := 1 to len(a_difer[n_k])
			If valtype (a_difer[n_k][n_v]) = 'N'
				cLin+= "					<TD>"+STR(a_difer[n_k][n_v],15,2)+"</TD>"+cEol
			Else
				cLin+= "					<TD>"+a_difer[n_k][n_v]+"</TD>"+cEol
			Endif
		Next
		cLin+= "				</TR>"+cEol
		Incproc()
		
		fWrite(Arqhtm,cLin)
		cLin:= " "
		
	Next
	
	cLin+= "			</TABLE>"+cEol
	
	fWrite(Arqhtm,cLin)
	cLin:= " "
	
	
Endif

cLin+= "		</CENTER>		 "+cEol
cLin+= "	</BODY>"+cEol
cLin+= "</HTML>"+cEol

fWrite(Arqhtm,cLin)


fClose(Arqhtm)

Shellexecute("open","VER"+c_alias+".HTM"," ","C:\SIGAHTM\",1)

Return
