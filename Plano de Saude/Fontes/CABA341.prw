#Include "PROTHEUS.CH"       
#include "TBICONN.CH" 
#include "topconn.ch"     
#INCLUDE 'UTILIDADES.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "REPORT.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO4     º Autor ³ AP6 IDE            º Data ³  24/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ CFaturamento prefeitura                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±                                                                      
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA339(c_Comp, c_CodInt, c_CodEmp, c_Matric)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cCadastro := "Cadastro de . . ." 
Private cComp := '201509'
Private cCodInt := '0001'
Private cCodEmp  := '0024'
Private cMatric := '020379'
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array (tambem deve ser aRotina sempre) com as definicoes das opcoes ³
//³ que apareceram disponiveis para o usuario. Segue o padrao:          ³
//³ aRotina := { {<DESCRICAO>,<ROTINA>,0,<TIPO>},;                      ³
//³              {<DESCRICAO>,<ROTINA>,0,<TIPO>},;                      ³
//³              . . .                                                  ³
//³              {<DESCRICAO>,<ROTINA>,0,<TIPO>} }                      ³
//³ Onde: <DESCRICAO> - Descricao da opcao do menu                      ³
//³       <ROTINA>    - Rotina a ser executada. Deve estar entre aspas  ³
//³                     duplas e pode ser uma das funcoes pre-definidas ³
//³                     do sistema (AXPESQUI,AXVISUAL,AXINCLUI,AXALTERA ³
//³                     e AXDELETA) ou a chamada de um EXECBLOCK.       ³
//³                     Obs.: Se utilizar a funcao AXDELETA, deve-se de-³
//³                     clarar uma variavel chamada CDELFUNC contendo   ³
//³                     uma expressao logica que define se o usuario po-³
//³                     dera ou nao excluir o registro, por exemplo:    ³
//³                     cDelFunc := 'ExecBlock("TESTE")'  ou            ³
//³                     cDelFunc := ".T."                               ³
//³                     Note que ao se utilizar chamada de EXECBLOCKs,  ³
//³                     as aspas simples devem estar SEMPRE por fora da ³
//³                     sintaxe.                                        ³
//³       <TIPO>      - Identifica o tipo de rotina que sera executada. ³
//³                     Por exemplo, 1 identifica que sera uma rotina de³
//³                     pesquisa, portando alteracoes nao podem ser efe-³
//³                     tuadas. 3 indica que a rotina e de inclusao, por³
//³                     tanto, a rotina sera chamada continuamente ao   ³
//³                     final do processamento, ate o pressionamento de ³
//³                     <ESC>. Geralmente ao se usar uma chamada de     ³
//³                     EXECBLOCK, usa-se o tipo 4, de alteracao.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aRotina padrao. Utilizando a declaracao a seguir, a execucao da     ³
//³ MBROWSE sera identica a da AXCADASTRO:                              ³
//³                                                                     ³
//³ cDelFunc  := ".T."                                                  ³
//³ aRotina   := { { "Pesquisar"    ,"AxPesqui" , 0, 1},;               ³
//³                { "Visualizar"   ,"AxVisual" , 0, 2},;               ³
//³                { "Incluir"      ,"AxInclui" , 0, 3},;               ³
//³                { "Alterar"      ,"AxAltera" , 0, 4},;               ³
//³                { "Excluir"      ,"AxDeleta" , 0, 5} }               ³
//³                                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta um aRotina proprio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
		             {"Visualizar","AxVisual",0,2} ,;
		             {"Incluir","U_CA341INC(1)",0,3} ,;
		             {"Alterar","U_CA341INC(2)",0,4} ,;
		             {"Excluir","AxDeleta",0,5} }
		
Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "PC1"

dbSelectArea("PC1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa a funcao MBROWSE. Sintaxe:                                  ³
//³                                                                     ³
//³ mBrowse(<nLin1,nCol1,nLin2,nCol2,Alias,aCampos,cCampo)              ³
//³ Onde: nLin1,...nCol2 - Coordenadas dos cantos aonde o browse sera   ³
//³                        exibido. Para seguir o padrao da AXCADASTRO  ³
//³                        use sempre 6,1,22,75 (o que nao impede de    ³
//³                        criar o browse no lugar desejado da tela).   ³
//³                        Obs.: Na versao Windows, o browse sera exibi-³
//³                        do sempre na janela ativa. Caso nenhuma este-³
//³                        ja ativa no momento, o browse sera exibido na³
//³                        janela do proprio SIGAADV.                   ³
//³ Alias                - Alias do arquivo a ser "Browseado".          ³
//³ aCampos              - Array multidimensional com os campos a serem ³
//³                        exibidos no browse. Se nao informado, os cam-³
//³                        pos serao obtidos do dicionario de dados.    ³
//³                        E util para o uso com arquivos de trabalho.  ³
//³                        Segue o padrao:                              ³
//³                        aCampos := { {<CAMPO>,<DESCRICAO>},;         ³
//³                                     {<CAMPO>,<DESCRICAO>},;         ³
//³                                     . . .                           ³
//³                                     {<CAMPO>,<DESCRICAO>} }         ³
//³                        Como por exemplo:                            ³
//³                        aCampos := { {"TRB_DATA","Data  "},;         ³
//³                                     {"TRB_COD" ,"Codigo"} }         ³
//³ cCampo               - Nome de um campo (entre aspas) que sera usado³
//³                        como "flag". Se o campo estiver vazio, o re- ³
//³                        gistro ficara de uma cor no browse, senao fi-³
//³                        cara de outra cor.                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return      

User Function CA341INC( n_Opc, c_Ano , c_Mes )   
	
	Local c_Perg := "CABA339"

	ParSX1( c_Perg )   
	
	If !Pergunte(c_Perg) 
	
		Return  
	
	EndIf  
	/*
	dbSelectArea("PC1")
	dbSetOrder(1)
	If n_Opc == 1 .AND. dbSeek(xFilial("PC1") + "0024" + c_Ano + c_Mes )  
	    
		Alert("Mes já incluso")
		Return  
    
	EndIf 
	
	dbSelectArea("PC1")
	dbSetOrder(1)
	If n_Opc == 1 .and. dbSeek(xFilial("PC1") + "0024" + c_Ano + c_Mes )  
	    
		Alert("Mes já incluso")
		Return  
    
	EndIf
        */
	u_CA341PRIN(cComp, cCodInt, cCodEmp, cMatric) 

Return


**'-----------------------------------------------------------------------------------------------------'**
**'-----------------------------------------------------------------------------------------------------'**
User Function CA341PRIN(cComp, cCodInt, cCodEmp, cMatric)   
**'-----------------------------------------------------------------------------------------------------'**

	Private a_CposFat 	:= {}
	Private a_StruFat 	:= {}  
	Private a_CposCon 	:= {}
	Private a_StruCon 	:= {}   
 
	Private c_CampoOk 	:= "XOK"    
	Private c_Status 	:= "XSTATS"    
	//Private c_AliasFat  := "QRYPC0"//GetNextAlias()
	Private c_AliasCon  := "QRYPC2"//GetNextAlias()

	Private oTela
	Private oPanel1
	Private oSay1
	Private oSay2
	Private oSay2
	Private oFoldRes
	Private oPanel2
	Private oBtImpFat
	Private oBbASE
	Private oBtImpCon
	Private oPanel3
	Private oBtn1     
	Private oBrFat
	Private oBrCon
	
	Private c_Ano := MV_PAR01
	Private c_Mes := MV_PAR02  
	Private onOk       := LoadBitMap(GetResources() , "LBNO_OCEAN" )     
	Private oAma       := LoadBitMap(GetResources() , "BR_AMARELO" )     
	Private oAzl       := LoadBitMap(GetResources() , "BR_AZUL_CLARO" )   

	Define FONT oFonNao 	NAME "Arial Black"  SIZE 0,15  Bold  
	Define FONT oFonSim 	NAME "Arial Black"  SIZE 0,15    

	Private c_AliasFat  := GetNextAlias()
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/                       '

	oTela      	:= MSDialog():New( 111,233,649,1187,"Faturamento Prefeitura",,,.F.,,,,,,.T.,,,.T. )
	oPanel1 	:= TPanel():New( 004,004,"",oTela,,.F.,.F.,,,460,020,.T.,.F. )
	oSay1      	:= TSay():New( 008,008,{||"Competência:"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLUE,CLR_WHITE,032,008)
	oSay2      	:= TSay():New( 008,044,{||c_Ano + "/" + c_Mes},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oFoldRes   	:= TFolder():New( 028,004,{"Resumo","Base Consolidada","Titulos Gerados","Cobrança FASS","Cobranca Individual"},{},oTela,,,,.T.,.F.,460,224,) 
    
	oBtImpFat  	:= TButton():New( 045,012,"1 - Importar Fatura",oFoldRes:aDialogs[1],{ || ImpFat() } ,130,016,, iif(PC1->PC1_VLFATU <> 0,oFonSim, oFonNao),,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }     
    oBtImpCon  	:= TButton():New( 065,012,"2 - Importar Consignado",oFoldRes:aDialogs[1],{ || ImpConsig() } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      	
	oBtImpFat  	:= TButton():New( 085,012,"3 - Gerar Base",oFoldRes:aDialogs[1],{ || MontaBase(.T.) } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      
  //	oBtImpFat  	:= TButton():New( 085,060,"6 - Gerar Base Fil",oFoldRes:aDialogs[1],{ || MontaBase(.F., cMatric) } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      

  //	oBtImpFat  	:= TButton():New( 024,024,"4 - Gerar Reprocessar",oFoldRes:aDialogs[1],{ || ReprocBase(cComp, cCodInt, cCodEmp, cMatric) } ,068,012,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      

	oBtImpFat  	:= TButton():New( 105,012,"4 - Gera Planilha",oFoldRes:aDialogs[1],{ || PlaBase( ) } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      

   	oBtImpFat  	:= TButton():New( 125,012,"5 - Definir Boletos",oFoldRes:aDialogs[1],{ || ImpBol( ) } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      

   	oBtImpFat  	:= TButton():New( 145,012,"6 - Baixar Títulos",oFoldRes:aDialogs[1],{ || B_XPARPRE( ) } ,130,016,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      

	
	**'Fatura'**   
	
	oPanel2    	:= TPanel():New( 004,376,"",oFoldRes:aDialogs[2],,.F.,.F.,,,076,200,.T.,.F. )
    oBbASE  	:= TButton():New( 004,004,"Gerar Planilha",oPanel2,{ || PlaBase( c_AliasFat ) } ,068,012,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      
	fMonStFt(@a_CposFat, @a_StruFat)
	
	fBrBase(@a_CposFat, @a_StruFat, @oFoldRes)
   //	FilBase()
	
	// fBrFatura(@a_CposFat, @a_StruFat, @oFoldRes)    	
   //	FilFatura()
    
   	oBrFat:Refresh()
   	oTela:Refresh()
   	
	**'Consignado'** 	 
	
	oPanel3    	:= TPanel():New( 004,376,"",oFoldRes:aDialogs[3],,.F.,.F.,,,076,200,.T.,.F. )
	//oBtImpCon  	:= TButton():New( 004,004,"Importar",oPanel3,{ || ImpConsig(), FilConsig() } ,068,012,,,,.T.,,"",,,,.F. ) // { || nOpca := 0 , oDlg:End() }      	


 	//fMonStCon(@a_CposCon, @a_StruCon)
//	fBrConsig(@a_CposCon, @a_StruCon, @oFoldRes)    	
   //	FilConsig()
   	
   		   	
	
	oTela:Activate(,,,.T.)
                                                                       
Return

**'---------------------------------------------------------------------------------------------------------'**
**'---------------------------------------------------------------------------------------------------------'**
Static Function fMonStFt(a_CposFat, a_StruFat) 

Aadd(a_CposFat,{" ",c_CampoOk,"C",1,0,})
Aadd(a_StruFat,{c_CampoOk,"C",1,0}) 

Aadd(a_CposFat,{" ",c_Status,"C",10,0,})
Aadd(a_StruFat,{c_Status,"C",10,0})   

DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("PC5"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "PC5") 
	
	iF x3Uso(SX3->X3_USADO)
	
		Aadd(a_CposFat,{Trim(X3_TITULO),X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMALC,""})
		Aadd(a_StruFat,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) 
   
	eNDiF
	
	dbSkip()
Enddo
            /*

	Aadd(a_CposFat,{"Mat Pref","PC0_MATPRE","C",7,0,""})
	Aadd(a_StruFat,{"PC0_MATPRE","C",7,0}) 
	
	Aadd(a_CposFat,{"Mat Caberj","PC0_MATCAB","C",17,0,""})
	Aadd(a_StruFat,{"PC0_MATCAB","C",17,0}) 

	Aadd(a_CposFat,{"Padrao","PC0_PADRAO","C",3,0,""})
	Aadd(a_StruFat,{"PC0_PADRAO","C",3,0})  
                        CC
	Aadd(a_CposFat,{"Valor","PC0_DESPAD","C",30,0,""})
	Aadd(a_StruFat,{"PC0_DESPAD","C",30,0})  
		
	Aadd(a_CposFat,{"Emissao","PC0_VLCOTA","N",17,2,""})
	Aadd(a_StruFat,{"PC0_VLCOTA","N",17,2})
 
	Aadd(a_CposFat,{"Emissao","PC0_VLDENT","N",17,2,""})
	Aadd(a_StruFat,{"PC0_VLDENT","N",17,2})
	
	Aadd(a_CposFat,{"Emissao","PC0_VLPLAN","N",17,2,""})
	Aadd(a_StruFat,{"PC0_VLPLAN","N",17,2})

	Aadd(a_CposFat,{"Emissao","PC0_VLFASS","N",17,2,""})
	Aadd(a_StruFat,{"PC0_VLFASS","N",17,2})

	Aadd(a_CposFat,{"Emissao","PC0_VLCOMP","N",17,2,""})
	Aadd(a_StruFat,{"PC0_VLCOMP","N",17,2})
              */
      
Return

**'--------------------------------------------------------------------------------------------------'**
Static Function fBrFatura(a_CposFat,a_StruFat, oFoldRes)  
**'--------------------------------------------------------------------------------------------------'**
   
	Local nIt := 0 

	//Private c_AliasFat  := "QRYPC0"//GetNextAlias()
	Private c_AliasInd  := "u_"+c_AliasFat     
	Private cChave		:= "PC0_CPF"
    
	**'Monta estrutura da tabela'**
 //	fMonStFt()
	
	If Select(c_AliasFat) <> 0
		(c_AliasFat)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasFat)
		TcDelFile(c_AliasFat)
	Endif

	DbCreate(c_AliasFat,a_StruFat,"TopConn")
	If Select(c_AliasFat) <> 0
		(c_AliasFat)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasFat,c_AliasFat,.T.,.F.)
	(c_AliasFat)->(DbCreateIndex(c_AliasInd , cChave, {|| &cChave}, .F. ))
	(c_AliasFat)->(DbCommit())
	(c_AliasFat)->(DbClearInd())
	(c_AliasFat)->(DbSetIndex(c_AliasInd ))  

	DbSelectArea(c_AliasFat)
	(c_AliasFat)->(DbGoTop())
	
	oBrFat:=TcBrowse():New(004,005,380,240,,,,oFoldRes:aDialogs[2],,,,,,,oTela:oFont,,,,,.T.,c_AliasFat,.T.,,.F.,,,.F.)     // 420 380
	
	For nIt := 1 To Len(a_CposFat)
		c2 := If(nIt == 1," ",a_CposFat[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasFat+"->"+c_CampoOk+"),onOk,oOk)}"),&("{||"+c_AliasFat+"->"+a_CposFat[nIt,2]+"  }"))
		
		c4 := If(nIt == 1,5,CalcFieldSize(a_CposFat[nIt,3],a_CposFat[nIt,4],a_CposFat[nIt,5],"",a_CposFat[nIt,1]))
		c5 := If(nIt == 1,"",a_CposFat[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)
        /*
       	c2 := If(nIt == 2," ",a_CposFat[nIt,1])
	   //	c3 :=  &("{|| If("+c_AliasFat+"->STATUS== ' ',OBRANCO , If("+c_AliasFat+"->STATUS == 'S',OVERDE , If("+c_AliasFat+"->STATUS == 'T',OAZUL , If("+c_AliasFat+"->STATUS == 'D',OCINZA , If("+c_AliasFat+"->STATUS == 'N',OPRETO , OAMARELO )))))}")
		c4 := If(nIt == 2,5,CalcFieldSize(a_CposFat[nIt,3],a_CposFat[nIt,4],a_CposFat[nIt,5],"",a_CposFat[nIt,1]))
		c5 := If(nIt == 2,"",a_CposFat[nIt,6])
		c6 := If(nIt == 2,.T.,.F.)
           */
		oBrFat:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	   	oBrFat:bLDblClick   := {|| fAtuFat(c_AliasFat,c_CampoOk     )}
	Next
	
	oBrFat:bHeaderClick := {|| fAtuFat(c_AliasFat,c_CampoOk,,.T.)}
	    
Return    


Static Function FilFatura()
    
    Local c_Qry := ""
    
    c_Qry += " SELECT ' ' XOK, PC0_CPF, PC0_MATPRE,PC0_MATCAB,PC0_PADRAO,PC0_DESPAD,PC0_VLCOTA,PC0_VLDENT,PC0_VLPLAN,PC0_VLFASS,PC0_VLCOMP"
    c_Qry += " FROM " + RETSQLNAME("PC0") +  " "
    c_Qry += " WHERE PC0_FILIAL = '" + XFILIAL("PC0") +  "' "
    c_Qry += "       AND PC0_COMPET = '" + c_Ano + c_Mes + "' "
      
	If TcCanOpen("QRYPC0")
		TcDelFile("QRYPC0")
	Endif
	     
	
	//cQuery := ChangeQuery(cQuery)
	If Select("QRYPC0") <> 0 ; ("QRYPC0")->(DbCloseArea()) ; Endif
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYPC0",.T.,.T.)
	
	For ni := 2 to Len(a_StruFat)
		If a_StruFat[ni,2] != 'C'
			TCSetField("QRYPC0", a_StruFat[ni,1], a_StruFat[ni,2],a_StruFat[ni,3],a_StruFat[ni,4])
		Endif
	Next
	
	cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
	Copy To &cTmp2 
	
	dbCloseArea()
	
	dbUseArea(.T.,,cTmp2,"QRYPC0",.T.)
	
	//DbSelectArea(c_AliasFat)
	("QRYPC0")->(DbGoTop())
	
	If ("QRYPC0")->(Eof())
		ApMsgInfo("Não foram encontrados registros com os parametros informados !")
		lRet := .F.
	Else
		
		//If !lExcBord  //200
		//   oGet01:bWhen := {|| .F.} ; oGet02:bWhen := {|| .F.} ; oGet03:bWhen := {|| .F.} ; oGet04:bWhen := {|| .F.}
		//   oGet06:bWhen := {|| .F.} ; oGet05:bWhen := {|| .F.} ; oGet07:bWhen := {|| .F.} ; oCom02:bWhen := {|| .F.}//; oGet08:bWhen := {|| .F.}
		//Endif
		
		
	Endif
	
  	
//  	oTela:Refresh()

Return

**'--------------------------------------------------------------------------------------------------'**
**'- Função para marcar/desmarcar itens da aba fatura                                               -'**
**'--------------------------------------------------------------------------------------------------'**
Static Function fAtuFat(cTmpAlias,cCampoOk,cGet,lTodos)
**'--------------------------------------------------------------------------------------------------'**

	Local cMarca := " "//Space(TamSx3(cCampoOk)[1])

	SA1->(DbSetOrder(1))
	If lTodos <> Nil .And. lTodos
		(c_AliasFat)->(DbGoTop())
		cMarca := If(Empty((c_AliasFat)->&(cCampoOk)),"X","")
		While (c_AliasFat)->(!Eof())
			(c_AliasFat)->(RecLock(c_AliasFat,.F.))
			(c_AliasFat)->&(cCampoOk) := cMarca
			(c_AliasFat)->(MsUnLock())
			If Empty((c_AliasFat)->&(cCampoOk))
				nTotReg --
			Else
				nTotReg ++
			Endif
			(c_AliasFat)->(DbSkip())
		End
		(cTmpAlias)->(DbGoTop())
	Else
		(c_AliasFat)->(RecLock(c_AliasFat,.F.))
		(c_AliasFat)->&(cCampoOk) := If(Empty((c_AliasFat)->&(cCampoOk)),"X","")
		(c_AliasFat)->(MsUnLock())
		If Empty((c_AliasFat)->&(cCampoOk))
			nTotReg --
		Else
			nTotReg ++
		Endif
	Endif
	
	oBrRio:Refresh()
	oTela:Refresh()

Return(.T.)


*'------------------------------------------------------------------'*
*'-- Importa Fatura                                               --'*
*'------------------------------------------------------------------'*
Static Function ImpFat()     
*'------------------------------------------------------------------'*


Local l_Erro := .F.
                        
Private cTitRotina 		:= "Importa arquivo de fatura"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 			:= {}
Private l_Deleta 		:= .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg

c_Separador := ';'

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg   
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	Processa({||l_Erro := fImpFat()},"Importa arquivo de fatura...")
EndIf

Return
	
*'------------------------------------------------------------------'*
*'-- Insere PC0                                                   --'*
*'------------------------------------------------------------------'*
Static Function fImpFat()
*'------------------------------------------------------------------'*

Local c_Arq		:= c_dirimp
Local n_QtdLin	:= 0
Local n_TotLin	:= 0
Local nInserido	:= 0
Local aBuffer	:= {}
Local l_Erro	:= .F.
Local cMsg 		:= ''
Local cBusca	:= ''
Local cTEC		:= ''
Local lHasFile	:= .T.
Local cMatric	:= ''
Local cNomePro	:= ''

DbSelectArea('PC0')   


If !Empty(c_Arq)

	ProcRegua(0)
	
	For n_TotLin := 1 to 5
		IncProc('Abrindo o arquivo...')
	Next

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	cMsg := "Arquivo a ser importado não localizado!" + CRLF
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	lHasFile	:= .F.
	
EndIf 

If !l_Erro .and. lHasFile

	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))   
	
	ProcRegua(n_TotLin)   
	
	n_Qtd := 0
	n_Total := 0     
	
	c_Sql := "UPDATE PC0010 SET D_E_L_E_T_ = '*' WHERE PC0_COMPET = '" + MV_PAR01 + MV_PAR02 +  "' "
	
	If TcSqlExec(c_Sql) < 0
		
		// 	Return
		
	Endif
		
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
	
		c_Buffer   := FT_FREADLN()
		
		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		c_Cpf 		:= StrZero(Val(aBuffer[2]),11)    
		c_MatPref 	:= replace(aBuffer[3], '.', '')   
		c_MatPref 	:= replace(c_MatPref, '-', '')   
		c_PlanoPref	:= aBuffer[4]   
		n_QtdMat    := val(aBuffer[5])   
		n_Cota		:= val(replace(aBuffer[6], ',', '.')  ) 
		c_Condic	:= aBuffer[7]   	
		n_VlDental  := val(replace(aBuffer[8], ',', '.')  )   	
		c_Orgao		:= aBuffer[9]   
		c_Faixa		:= aBuffer[10]   

		n_VlPlan	:= replace(aBuffer[11], '.', '')  
		n_VlPlan	:= val(replace(n_VlPlan, ',', '.')  )   
	
		n_VlFass    := replace(aBuffer[12], '.', '')     
		n_VlFass    := val(replace(n_VlFass, ',', '.')  )   
 
		n_Compl		:= val(replace(aBuffer[16], ',', '.')  )  
		
		n_Qtd++
   
		n_Total += n_Compl + n_VlPlan + n_VlDental
 
 		PC0->(Reclock('PC0',.T.))
		
			PC0->PC0_CPF    	:= c_Cpf
			PC0->PC0_MATPRE    	:= c_MatPref
			PC0->PC0_PADRAO    	:= c_PlanoPref
			PC0->PC0_QTDMAT    	:= n_QtdMat
			PC0->PC0_VLCOTA    	:= n_Cota
			PC0->PC0_VLDENT    	:= n_VlDental
			PC0->PC0_VLPLAN    	:= n_VlPlan
			PC0->PC0_VLFASS    	:= n_VlFass
			PC0->PC0_VLCOMP    	:= n_Compl
			PC0->PC0_CONDIC    	:= c_Condic
			PC0->PC0_ORGAO     	:= c_Orgao
			PC0->PC0_FXETAR    	:= c_Faixa
			PC0->PC0_COMPET    	:= c_Ano + c_Mes
		
  		PC0->(MsUnlock())
		
		nInserido++
		
		FT_FSKIP()
			
	EndDo
	
	FT_FUSE()
	
EndIf  

	dbSelectArea("PC1")
	dbSetOrder(1)
	If !dbSeek(xFilial("PC1") + "0024" + c_Ano + c_Mes )    

		PC1->(Reclock('PC1',.T.))
			
				PC1->PC1_ANO       	:= c_Ano
				PC1->PC1_MES       	:= c_Mes
				PC1->PC1_CODEMP    	:= '0024'
				PC1->PC1_STATUS    	:= "F"
				PC1->PC1_DTINC     	:= DATE()
				PC1->PC1_VLFATU    	:= n_Total
			
	  	PC1->(MsUnlock())   
   
	Else   
	
		PC1->(Reclock('PC1',.F.))
			
			PC1->PC1_VLFATU    	:= n_Total
			
	  	PC1->(MsUnlock()) 
	  	
  	EndIf

If !l_Erro .and. lHasFile
	MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC0'),AllTrim(SM0->M0_NOMECOM))
EndIf

Return l_Erro   


*'------------------------------------------------------------------'*
*'-- Importa Consig                                               --'*
*'------------------------------------------------------------------'*
Static Function ImpConsig()
*'------------------------------------------------------------------'*

Local l_Erro := .F.
                        
Private cTitRotina 		:= "Importa arquivo de consignações"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 			:= {}
Private l_Deleta 		:= .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg

c_Separador := ';'

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg   
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	Processa({||l_Erro := fImpConsig()},"Importa arquivo de consignados...")
EndIf

Return
	
*'------------------------------------------------------------------'*
*'-- Insere PC2                                                   --'*
*'------------------------------------------------------------------'*
Static Function fImpConsig()
*'------------------------------------------------------------------'*
    
	Local c_Arq		:= c_dirimp
	Local n_QtdLin	:= 0
	Local n_TotLin	:= 0
	Local nInserido	:= 0
	Local aBuffer	:= {}
	Local l_Erro	:= .F.
	Local cMsg 		:= ''
	Local cBusca	:= ''
	Local cTEC		:= ''
	Local lHasFile	:= .T.
	Local cMatric	:= ''
	Local cNomePro	:= ''
	

	Local c_Cpf 		:= ""
	Local c_MatPref 	:= ""
	Local c_MatPref 	:= ""
	Local c_QtdPen		:= ""
	Local c_Fonte     	:= ""
	Local c_Rubrica		:= ""
	Local c_Especie		:= ""
	Local n_VlComand  	:= 0
	Local n_VlComand  	:= 0
	Local c_Situac		:= ""
	Local c_Motivo		:= ""
	Local c_PosFoll		:= ""
	Local d_Compet		:= dDataBase

DbSelectArea('PC2')   


If !Empty(c_Arq)

	ProcRegua(0)
	
	For n_TotLin := 1 to 5
		IncProc('Abrindo o arquivo...')
	Next

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	cMsg := "Arquivo a ser importado não localizado!" + CRLF
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	lHasFile	:= .F.
	
EndIf 


c_Sql := "UPDATE PC2010 SET D_E_L_E_T_ = '*' WHERE PC2_COMPET = '" + MV_PAR01 + MV_PAR02 +  "' "

If TcSqlExec(c_Sql) < 0
	
	// 	Return
	
Endif



If !l_Erro .and. lHasFile

	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))   
	
	ProcRegua(n_TotLin)
		
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
	
		c_Buffer   := FT_FREADLN()
		
		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		c_Cpf 		:= StrZero(Val(aBuffer[3]),11)    
		c_MatPref 	:= replace(aBuffer[4], '.', '')   
		c_MatPref 	:= replace(c_MatPref, '-', '')   
		c_QtdPen	:= aBuffer[5]   
		c_Fonte     := aBuffer[1]   
		c_Rubrica	:= aBuffer[6]
		c_Especie	:= aBuffer[10]   //10	
		n_VlComand  := replace(aBuffer[9], '.', '')  
		n_VlComand  := val(replace(n_VlComand, ',', '.')  )   	
		
		If upper( substr(aBuffer[13], 1, 1)) == 'D'//P
		     
		n_VlDescon  := replace(aBuffer[11], '.', '')  
		n_VlDescon  := val(replace(n_VlDescon, ',', '.')  )   	
		
		Else

			n_VlDescon  := 0

		EndIf
	
		c_Situac	:= aBuffer[13]   
		c_Motivo	:= aBuffer[14]   
		c_PosFoll	:= aBuffer[12]   
		d_Compet	:= ctod( aBuffer[7] )
		c_Acao      := aBuffer[16]
		c_Vinculo   := aBuffer[15]
		
					
		PC2->(Reclock('PC2',.T.))
		
			PC2->PC2_CPF    	:= c_Cpf
			PC2->PC2_MATPRE    	:= c_MatPref
			PC2->PC2_NUMPEN    	:= c_QtdPen
			PC2->PC2_FONTEP    	:= c_Fonte
			PC2->PC2_RUBLIC    	:= c_Rubrica
			PC2->PC2_TIPUSU    	:= c_Especie
			PC2->PC2_VLRCOM    	:= n_VlComand
			PC2->PC2_VLDESC    	:= n_VlDescon
			PC2->PC2_SITUAC    	:= c_Situac
			PC2->PC2_MOTIVO    	:= c_Motivo
			PC2->PC2_POSFOL     := c_PosFoll
			PC2->PC2_COMPET    	:= c_Ano + c_Mes
			PC2->PC2_ACAO      	:= c_Acao
			PC2->PC2_VINCUL    	:= c_Vinculo
		
  		PC2->(MsUnlock())
		
		nInserido++
		
		FT_FSKIP()
			
	EndDo
	
	FT_FUSE()
	
EndIf

If !l_Erro .and. lHasFile
	MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC0'),AllTrim(SM0->M0_NOMECOM))
EndIf

Return l_Erro  

**'---------------------------------------------------------------------------------------------------------'**
**'---------------------------------------------------------------------------------------------------------'**
Static Function fMonStCon(a_CposCon, a_StruCon)

	Aadd(a_CposCon,{" ",c_CampoOk,"C",1,0,})
	Aadd(a_StruCon,{c_CampoOk,"C",1,0})    

	Aadd(a_CposCon,{"CPF","PC2_CPF   ","C",11,0,""})
	Aadd(a_StruCon,{"PC2_CPF   ","C",11,0}) 

	Aadd(a_CposCon,{"Mat Pref","PC2_MATPRE","C",7,0,""})
	Aadd(a_StruCon,{"PC2_MATPRE","C",7,0}) 
	
	Aadd(a_CposCon,{"Mat Caberj","PC2_MATCAB","C",17,0,""})
	Aadd(a_StruCon,{"PC2_MATCAB","C",17,0}) 
		
	Aadd(a_CposCon,{"Vlr Comandado","PC2_VLRCOM","N",17,2,""})
	Aadd(a_StruCon,{"PC2_VLRCOM","N",17,2})
 
	Aadd(a_CposCon,{"Vlr Descontado","PC2_VLDESC","N",17,2,""})
	Aadd(a_StruCon,{"PC2_VLDESC","N",17,2})
	
	Aadd(a_CposCon,{"Situacao","PC2_SITUAC","C",1,0,""})
	Aadd(a_StruCon,{"PC2_SITUAC","C",1,0})

	Aadd(a_CposCon,{"Motivo","PC2_MOTIVO","C",50,0,""})
	Aadd(a_StruCon,{"PC2_MOTIVO","C",50,0})

	Aadd(a_CposCon,{"Motivo","PC2_POSFOL","C",1,0,""})
	Aadd(a_StruCon,{"PC2_POSFOL","C",1,0})

 	Aadd(a_CposCon,{"Dt Inclusão","PC2_DATINC","D",8,0,""})
	Aadd(a_StruCon,{"PC2_DATINC","D",8,0})     

 	Aadd(a_CposCon,{"Dt Bloqueio","PC2_DATBLO","D",8,0,""})
	Aadd(a_StruCon,{"PC2_DATBLO","D",8,0})     

Return

**'--------------------------------------------------------------------------------------------------'**
Static Function fBrConsig(a_CposCon,a_StruCon, oFoldRes)  
**'--------------------------------------------------------------------------------------------------'**
   
	Local nIt := 0 

	Private c_AliasCon  := "QRYPC2"//GetNextAlias()
	Private c_AliasInd  := "u_"+c_AliasCon     
	Private cChave		:= "PC2_CPF"
    
	**'Monta estrutura da tabela'**
 //	fMonStFt()
	
	If Select(c_AliasCon) <> 0
		(c_AliasCon)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasCon)
		TcDelFile(c_AliasCon)
	Endif

	DbCreate(c_AliasCon,a_StruCon,"TopConn")
	If Select(c_AliasCon) <> 0
		(c_AliasCon)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasCon,c_AliasCon,.T.,.F.)
	(c_AliasCon)->(DbCreateIndex(c_AliasInd , cChave, {|| &cChave}, .F. ))
	(c_AliasCon)->(DbCommit())
	(c_AliasCon)->(DbClearInd())
	(c_AliasCon)->(DbSetIndex(c_AliasInd ))  

	DbSelectArea(c_AliasCon)
	(c_AliasCon)->(DbGoTop())
	
	oBrCon:=TcBrowse():New(020,005,380,240,,,,oFoldRes:aDialogs[3],,,,,,,oTela:oFont,,,,,.T.,c_AliasCon,.T.,,.F.,,,.F.)     // 420 380
	
	For nIt := 1 To Len(a_CposCon)
		c2 := If(nIt == 1," ",a_CposCon[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasCon+"->"+c_CampoOk+"),onOk,oOk)}"),&("{||"+c_AliasCon+"->"+a_CposCon[nIt,2]+"  }"))
		
		c4 := If(nIt == 1,5,CalcFieldSize(a_CposCon[nIt,3],a_CposCon[nIt,4],a_CposCon[nIt,5],"",a_CposCon[nIt,1]))
		c5 := If(nIt == 1,"",a_CposCon[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)
 
 		oBrCon:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	   	oBrCon:bLDblClick   := {|| fAtuFat(c_AliasCon,c_CampoOk     )}     
	   	
	Next
	
	oBrCon:bHeaderClick := {|| fAtuFat(c_AliasCon,c_CampoOk,,.T.)}
	    
Return    


Static Function FilConsig()
    
    Local c_Qry := ""
    
    c_Qry += " SELECT ' ' XOK, PC2_CPF, PC2_MATPRE,PC2_MATCAB,PC2_VLRCOM,PC2_VLDESC,PC2_SITUAC,PC2_MOTIVO,PC2_POSFOL,PC2_DATINC,PC2_DATBLO "
    c_Qry += " FROM " + RETSQLNAME("PC2") +  " "
    c_Qry += " WHERE PC2_FILIAL = '" + XFILIAL("PC2") +  "' "
    c_Qry += "       AND PC2_COMPET = '" + c_Ano + c_Mes + "' "
      
	If TcCanOpen("QRYPC2")
		TcDelFile("QRYPC2")
	Endif
	
	//cQuery := ChangeQuery(cQuery)
	If Select("QRYPC2") <> 0 ; ("QRYPC2")->(DbCloseArea()) ; Endif
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYPC2",.T.,.T.)
	
	For ni := 2 to Len(a_StruCon)
		If a_StruCon[ni,2] != 'C'
			TCSetField("QRYPC2", a_StruCon[ni,1], a_StruCon[ni,2],a_StruCon[ni,3],a_StruCon[ni,4])
		Endif
	Next
	
	cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
	Copy To &cTmp2 
	
	dbCloseArea()
	
	dbUseArea(.T.,,cTmp2,"QRYPC2",.T.)
	
	//DbSelectArea(c_AliasFat)
	("QRYPC2")->(DbGoTop())
	
	If ("QRYPC2")->(Eof())
		ApMsgInfo("Não foram encontrados registros com os parametros informados !")
		lRet := .F.
	Else
		
		//If !lExcBord  //200
		//   oGet01:bWhen := {|| .F.} ; oGet02:bWhen := {|| .F.} ; oGet03:bWhen := {|| .F.} ; oGet04:bWhen := {|| .F.}
		//   oGet06:bWhen := {|| .F.} ; oGet05:bWhen := {|| .F.} ; oGet07:bWhen := {|| .F.} ; oCom02:bWhen := {|| .F.}//; oGet08:bWhen := {|| .F.}
		//Endif
		
		
	Endif
	
  	
//  	oTela:Refresh()

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ParSX1       ºAutor  ³Jean Schulz     º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria parametros para rotina.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ParSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Ano") 			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{"Ano"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Mes")			,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{"Mes"},{""},{""})

Return


Static Function B_XPARPRE()  

Private cPerg := "CABA339A" 
Private c_Ano := mv_par01
Private c_Mes := mv_par02

Ajust_SX1(cPerg)

If !Pergunte(cPerg,.T.)
	Return
End

Pergunte(cPerg,.F.)    

If !MsgYesNo("Tem certeza que deseja baixar os títulos da competencia " + c_Mes + "/" + c_Ano + " na data " + dtoc(stod(alltrim(str(mv_par01)))) +"?")
	         
	 Return
	     
EndIf     

	Processa({||l_Erro := F_XPARPRE()},"Baixando...")

Return

Static function F_XPARPRE()
                    
dDataTmp  := dDataBase
dDataBase := stod(alltrim(str(mv_par01)))                    
                                                                                                   
	c_Qry := " select max(E5_LOTE)  LOTE  "
	c_Qry += " from se5010            "
	c_Qry += " where e5_filial = '01' "
	c_Qry += " and E5_RECPAG = 'R'    "
	c_Qry += " and LENGTH(TRIM(E5_LOTE)) = 8 "
	c_Qry += " and d_e_l_e_t_ = ' ' "
	
	TcQuery c_Qry ALIAS "TMPLOTE" NEW     
	
	While !tmplote->( EOF() ) 
	    
	    c_Lote := soma1( tmplote->LOTE )
	
		tmplote->( dbSkip() )
	
	EndDo      
		
	c_Qry := " select distinct BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG MATRICULA, "
	c_Qry += " BA3_MATEMP CPF_TIT,                                              "
	c_Qry += " BA1_NOMUSR NOME,                                                 "
	c_Qry += " E1_NUM NUM_TIT,                                                  "
	c_Qry += " PC5_VLRTFA VALOR_BAIXAR,                                         "
	c_Qry += " E1_VALOR VALOR_TITULO                                            "
	c_Qry += " from " + RETSQLNAME("BA3") + " inner join " + RETSQLNAME("BA1") + " " 
	c_Qry += "                   on BA1_FILIAL = ' '                            "
	c_Qry += "                   and BA1_CODINT= BA3_CODINT                     "
	c_Qry += "                   and BA1_CODEMP = BA3_CODEMP                    "
	c_Qry += "                   and BA1_MATRIC = BA3_MATRIC                    "
         
	c_Qry += "             left outer join " + RETSQLNAME("PC5") + " " 
    c_Qry += "                   on PC5_COMPET = '" + c_Ano + c_Mes +"' "
    c_Qry += "                   and PC5_CODEMP = BA1_CODEMP "
	c_Qry += "                   and PC5_MATRIC = BA1_MATRIC "
	c_Qry += "                   and PC5_TIPUSU = 'T'   "
	c_Qry += "                   and PC5010.D_E_L_E_T_ = ' '  "
                  
	c_Qry += "             inner join " + RETSQLNAME("SE1") + "   "
	c_Qry += "             on E1_FILIAL = '01' "
	c_Qry += "             and E1_CODINT = BA1_CODINT  "
	c_Qry += "             and E1_CODEMP = BA1_CODEMP "
	c_Qry += "             and E1_MATRIC = BA1_MATRIC  "
	c_Qry += "             and E1_ANOBASE = '" + c_Ano + "'  "
	c_Qry += "             and E1_MESBASE = '" + c_Mes + "'    "
	c_Qry += "             and SE1010.D_E_L_E_T_ = ' ' "
	c_Qry += "             and E1_SALDO > 0   " 
//	c_Qry += "             and e1_plnucob not in ('000100068790','000100068656','000100068713')  " 
	
  //	c_Qry += "             inner join CPF_DENTAL_PREF on pc5_compet = '201605' and pc5_cpf = cpf_1  "
            
	c_Qry += " where BA3_CODEMP = '0024'  "
	c_Qry += " and BA3010.D_E_L_E_T_ = ' ' "
	c_Qry += " and BA1010.D_E_L_E_T_ = ' '  "
	//c_Qry += " and substr(BA3_XGRPR,1, 1) in ( 'B', 'F') "
	c_Qry += " and e1_matric <> ' ' "
	//c_Qry += " and e1_vencrea <> '20160725' "
	c_Qry += " and BA1_TIPUSU = 'T' "
	c_Qry += " and e1_tipo = 'DP' "
	//c_Qry += " and BA3_grpcob <> '2002' "
	c_Qry += " AND PC5_VLRTFA <> 0  "                       
	
		      
	TCQUERY c_Qry ALIAS "TMPEX" NEW  

	     n_TotBx := 0                
	While !TMPEX->(EOF())
	                     
	     BaixaTitulo( "NOR","PLS", TMPEX->NUM_TIT ,' ','DP',dDataBase,"BX. AUTOM. PREFEITURA",iif(TMPEX->VALOR_BAIXAR > TMPEX->VALOR_TITULO , TMPEX->VALOR_TITULO, TMPEX->VALOR_BAIXAR),  , c_Lote) 
	     n_TotBx+= TMPEX->VALOR_BAIXAR
	     
		TMPEX->( dbSkip() )
	
	EndDo                                         
	
			Reclock( "SE5" , .T. )
				SE5->E5_FILIAL	:= xFilial()
				SE5->E5_BANCO	:= "033"
				SE5->E5_AGENCIA	:= "3003 "
				SE5->E5_CONTA	:= "13081236"
				SE5->E5_VALOR	:= n_TotBx
				SE5->E5_RECPAG	:= "R"
				SE5->E5_HISTOR	:= "BX. AUTOM. DEB PREF" + c_Lote
				SE5->E5_DTDIGIT	:= dDataBase
				SE5->E5_DATA	:= dDataBase
				SE5->E5_NATUREZ	:= "BX.PREV"
				SE5->E5_LOTE	:= c_Lote
				SE5->E5_TIPODOC := "BL"
				SE5->E5_DTDISPO	:= dDataBase
			
			MsUnlock()	
			
dDataBase := dDataTmp                  
		
	
Return


Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo,dDtBaixa,cHisBaixa,nVlrBaixa, n_TotBx, c_Lote)
	
Local lRet := .F.

Private lmsErroAuto := .f.
Private lmsHelpAuto := .t. // para mostrar os erros na tela     

nTpMov := 1  

dbSelectArea("SE1")                                    
dbSetOrder(1)
If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)) .and. cNumero <> '002324762'

	If SE1->E1_SALDO > 0
		nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, nVlrBaixa)
		SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
		SA6->(MsSeek(xFilial("SA6")+"0333003 13081236  "))

		aCamposSE5 := {}
		aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
		aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
		aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
		aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
		aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
     	aAdd(aCamposSE5, {"E1_LOTE"		, c_Lote			, Nil})
		aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
	  	aAdd(aCamposSE5, {"AUTBANCO"	, SA6->A6_COD		, Nil})
		aAdd(aCamposSE5, {"AUTAGENCIA"	, SA6->A6_AGENCIA	, Nil})
		aAdd(aCamposSE5, {"AUTCONTA"	, SA6->A6_NUMCON	, Nil})

		aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})

		msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)

		If lMsErroAuto
		   	lRet := .F.
		   //	aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		  	MostraErro()
		   	SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "F" // RETORNO RIO PREVIDENCIA - ERRO - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"F", "X5_DESCRI")
			SE1->(MsUnlock()) 
			
		Else 
		    
			SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "E" // RETORNO RIO PREVIDENCIA - OK - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"E", "X5_DESCRI")
			SE1->(MsUnlock())
		 	//Informa o lote no movimento totalizador
			If nTpMov == 1
					SE5->(Reclock("SE5",.F.))
					SE5->E5_TIPODOC	:= "BA"
					SE5->E5_LOTE	:= c_Lote
					SE5->(MsUnlock())			
			EndIf 
			  
		   //	n_TotBx+= nVlrBaixa
			
		//	lRet := .T.
		EndIf
	Else
  //		aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
	EndIf

EndIf     
	
Return lRet

   
Static Function MontaBase(l_Completa, c_MatFil) 

Processa({||l_Erro := fMontaBase(l_Completa, c_MatFil)},"Gerando Base...")  

Return

Static Function fMontaBase( l_Completa, c_MatFil )

	Local c_Qry    := ""  
	Local c_FrtDay := c_Ano + c_Mes + "01"
	Local c_LasDay := DTOS(LASTDAY(STOD(c_Ano + c_Mes + "01")))
	Local c_LasDPx := DTOS(LASTDAY(STOD(c_Ano + strzero( val(c_Mes)-1,2) + "01")))
	Local n_TotFam := 0
	Local n_TotDep := 0
	Local n_ValTabe:= 0  
	Local n_ValDesc:= 0
	Local n_ValOpc := 0    
	Local n_TotTabe:= 0
	Local n_TotDesc:= 0
	Local n_TotOpc := 0        
	
	Private A_GRAVAPC5 := {}  
	Private a_DifPad   := {}    
	
	If c_Mes == '01'    
	
		c_LasDPx :=  trim(str((val(c_Ano) - 1))) + "1231"
	
	EndIf   
	
	If !Empty( PC1->PC1_BASE ) 
	
		If !MsgYesNo("Base já processada, deseja reprocessar?")
	         
		//	Return
	     
		Else
		
			c_Sql := "UPDATE PC5010 SET D_E_L_E_T_ = '*' WHERE PC5_COMPET = '" + c_Ano + c_Mes +  "' "    
			
			If TcSqlExec(c_Sql) < 0
		
			   	Alert("NAO APAGOU PROCESSAMENTO ANTERIOR, NÃO FOI REPROCESSADO. CONTACTAR A TI") 
			  // 	Return
		
			Endif

		
		EndIf		
	
	EndIf
	
	c_Qry += " SELECT DECODE(BA1_TIPUSU, 'T', '9', '1') ,RETORNA_VLR_FAT_PREF('" + c_Ano + c_Mes + "',  TRIM(BA3_MATEMP) ) VLR_FATURA, "
    c_Qry += "        RETORNA_VLR_CONSIG_PREF('" + c_Ano + c_Mes + "',TRIM(BA1_CPFUSR), 'D' )  VLR_C_DEP,"
    c_Qry += "        RETORNA_VLR_CONSIG_PREF('" + c_Ano + c_Mes + "',TRIM(BA3_MATEMP), 'T' )  VLR_C_TIT, IDADE_S(BA1_DATNAS, '" + c_LasDPx + "') IDADE, BA1.*, BA3.*"
    
    c_Qry += "        ,( SELECT PC2_SITUAC||' - ' || trim(PC2_ACAO) || ' - ' || PC2_MOTIVO  FROM PC2010 WHERE PC2_COMPET = '" + c_Ano + c_Mes + "' AND PC2_CPF = TRIM(BA3_MATEMP) AND rownum = 1 and pc2_acao <> ' ') ACAO_PC2"

	c_Qry += " FROM " + RETSQLNAME("BA3") + " BA3 INNER JOIN " + RETSQLNAME("BA1") + " BA1 ON "
	c_Qry += "             BA1_FILIAL = ' ' "
	c_Qry += "             AND BA1_CODINT = BA3_CODINT "
	c_Qry += "             AND BA1_CODEMP = BA3_CODEMP "
	c_Qry += "             AND BA1_MATRIC = BA3_MATRIC "
   //	c_Qry += "             INNER JOIN CPF_BOLETAR ON CPF = trim(BA3_MATEMP) "

	c_Qry += " WHERE BA3_FILIAL = ' '  "
	c_Qry += " AND BA3_CODINT = '0001' "
	c_Qry += " AND BA3_CODEMP = '0024' "
	c_Qry += " AND BA3_SUBCON = '000000003' "
  	//c_Qry += " AND ba3_grpcob <> '2001' "
	c_Qry += " AND BA1_DATINC <= '" + c_LasDay  + "' "
	c_Qry += " AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >='" + c_Ano + c_Mes + "01" + "') "
	c_Qry += " AND BA1.D_E_L_E_T_ = ' ' "
	c_Qry += " AND BA3.D_E_L_E_T_ = ' ' "

    //c_Qry += " AND rownum <= 50 "                   	
    If .F.
    	c_Qry += " AND trim(ba3_matemp) = '00154620564' "      
    EndIf    
    	
	c_Qry += " ORDER BY BA1_CODEMP, BA1_MATRIC, DECODE(BA1_TIPUSU, 'T', '9', '1')  "     
	
	Memowrit("C:\tEMP1\caba341.txt",c_Qry)
	
	TcQuery c_Qry ALIAS "TMPFAM" NEW     
	              
	c_MatLoop := ""      
	c_MatFin := ""      
	
	cc := 0
	While !TMPFAM->( EOF() )      
	    
	    If !Empty(c_MatLoop) .AND. c_MatLoop <> TMPFAM->( BA1_CODEMP + BA1_MATRIC + BA1_TIPREG )
	    
	    	a_Cobranca 	:= {} 
	    	
	    	GravaPC5( a_GravaPC5, n_TotFam )  
	    	
	    	If c_MatFin <> TMPFAM->( BA1_CODEMP + BA1_MATRIC  )  

				n_TotFam 	:= 0
				n_TotUsu 	:= 0   
				n_TotDep    := 0//
				n_ValTabe	:= 0  
				n_ValDesc	:= 0
				n_ValOpc 	:= 0   
				n_TotTabe	:= 0
				n_TotDesc	:= 0
				n_TotOpc 	:= 0   

			EndIf
	
			a_GravaPC5 := {}
			
	    EndIf    
	    
	    c_MatLoop 	:= TMPFAM->( BA1_CODEMP + BA1_MATRIC + BA1_TIPREG )
	    c_MatFin 	:= TMPFAM->( BA1_CODEMP + BA1_MATRIC )  
	    
	    
	    
	    a_Cobranca 	:= RetValCob(  TMPFAM->BA1_CODINT, TMPFAM->BA1_CODEMP, TMPFAM->BA1_MATRIC , TMPFAM->BA1_TIPREG, TMPFAM->BA1_TIPUSU, str(TMPFAM->IDADE), TMPFAM->BA3_CODPLA,;
	    						  TMPFAM->BA3_CODCLI, c_Ano, c_Mes )   //l_Ret, n_ValorBBU, n_ValorBFY, n_ValorBZX

 		n_ValDesc := a_Cobranca[06] 
		n_ValTabe := a_Cobranca[05] 
		n_ValOpc  := a_Cobranca[07] 	   
		n_VlrPad  := a_Cobranca[09] 	   
		n_VlrRAC  := a_Cobranca[10] 	   
		
		n_TotFam += n_ValTabe + n_ValDesc + n_ValOpc  
		n_TotUsu := n_ValTabe + n_ValDesc + n_ValOpc   
		n_TotDep += iIf( TMPFAM->BA1_TIPUSU == 'T', 0, TMPFAM->VLR_C_DEP ) 
		
		
		n_TotTabe += n_ValTabe      
		n_TotDesc += n_ValDesc   
		n_TotOpc  += n_ValOpc    
		
		l_Boleto := .F. 

		c_Obs2 := ""
		c_Ok   := ""
		n_Dif  := 0

		If a_Cobranca[1] .AND. n_TotFam < (TMPFAM->VLR_FATURA + TMPFAM->VLR_C_TIT + TMPFAM->VLR_C_DEP)   
		
			c_Obs2 := "007 - Valor cobrado menor que o recebido" 
			c_Ok   := "N"     
		   
			n_Dif := (TMPFAM->VLR_FATURA + TMPFAM->VLR_C_TIT + TMPFAM->VLR_C_DEP) - n_TotFam
		                                                  
		ElseIf a_Cobranca[1] .AND. n_TotFam > (TMPFAM->VLR_FATURA + TMPFAM->VLR_C_TIT + n_TotDep)    //(n_ValTabe  + n_ValDesc + n_ValOpc
			
		
			n_Dif := (TMPFAM->VLR_FATURA + TMPFAM->VLR_C_TIT + TMPFAM->VLR_C_DEP) - n_TotFam
			
			If SUBSTR(TMPFAM->ACAO_PC2,1,1) == 'N'
			                
				l_Boleto := .T.
				c_Obs2 := "009 - " + TMPFAM->ACAO_PC2        
				c_Ok   := "N"      
				
			Else 
			
			c_Obs2 := "008 - Valor cobrado maior que o recebido"        
			c_Ok   := "N"      
			
			EndIf
			
			 
				
		ElseIf !a_Cobranca[1] 
		  
			c_Obs2 := a_Cobranca[8]	
			c_Ok   := "N"

		EndIf	 
		
		/*
		
		n_Pos := aScan(a_DifPad, {|X| X[1] == n_Dif}) 
		
		If n_Pos == 0     
		
			a_DifPad[n_Pos][2]++
		
		Else  
		
			aadd(a_DifPad, {n_Dif, 1})
		
		EndIf
		
		*/		
				
	    aadd( a_GravaPC5, {xFilial("PC5") ,; //1
							c_Ano + c_Mes ,; //2
							TMPFAM->BA1_CPFUSR,;    //3
							' ' ,;//4
							TMPFAM->BA1_CODINT,;//5
							TMPFAM->BA1_CODEMP,;//6
							TMPFAM->BA1_MATRIC,;//7
							TMPFAM->BA1_TIPREG,;//8
							TMPFAM->BA1_NOMUSR,;//9
							TMPFAM->BA1_DATBLO,;//10
							TMPFAM->BA1_DATINC,;//11
							n_ValDesc,;//12
							n_ValOpc,;//13
							n_ValTabe,;//14
							n_TotFam,;//15
							c_Ok ,;//16
							TMPFAM->BA1_TIPUSU,;//17
							TMPFAM->VLR_FATURA ,;//18
							TMPFAM->VLR_C_TIT,; //19
							TMPFAM->VLR_C_DEP ,;//20
							TMPFAM->VLR_FATURA + TMPFAM->VLR_C_TIT + TMPFAM->VLR_C_DEP,;//21 n_TotDep
							trim(TMPFAM->BA3_MATEMP)  ,;//22 
						    c_Obs2 ,; //23
						    l_Boleto,; // 24
						    n_Dif,; //25
						    n_TotUsu,;  //26
						    n_VlrPad,;//27
						    n_VlrRAC,; //28
						    n_TotDep } )  //29
	    
		TMPFAM->( dbSkip() )
	
	EndDo 
	
	TMPFAM->( dbSkip(-1) )  
	
	If !Empty(c_MatLoop) .AND. c_MatLoop <> TMPFAM->( BA1_CODEMP + BA1_MATRIC )
		
		a_Cobranca 	:= {}
		
		GravaPC5( a_GravaPC5, n_TotFam )
		
		n_TotFam := 0
		n_ValTabe:= 0
		n_ValDesc:= 0
		n_ValOpc := 0
		a_GravaPC5 := {}
		
	EndIf 
	
	PC1->(Reclock('PC1',.F.))
			
		PC1->PC1_BASE      	:= "S"
			
	PC1->(MsUnlock()) 
	  	 
	
	alert("fim")
	
	TMPFAM->( dbCloseArea() )
	
Return      

Static Function RetValCob( c_CodInt, c_CodEmp, c_Matric, c_tipReg, c_TipUsu, c_Idade, c_CodPla, c_CodCli, c_Ano, c_Mes)  

	Local l_Ret 	 := .T.  
	Local n_ValorBDK := 0
	Local n_ValorBFY := 0  
	Local n_ValorBZX := 0 
	Local n_ValorRAC := 0 
	Local n_ValorTab := 0 
	Local a_Ret 	 := {} 
	Local c_CodFai   := "" 
	Local c_Obs 	 := ""       
	
	c_Idade := iif(val(c_Idade) < 0, "0", c_Idade)

	//COLUMN E1_VENCORI AS DATE
	BeginSql Alias "TMPBDK"
	SELECT BDK_VALOR,
			BDK_CODFAI
	      FROM %Table:BDK%
	      WHERE BDK_FILIAL = %xFilial:BDK%
	            AND BDK_CODINT = %Exp:c_CodInt%
	            AND BDK_CODEMP = %Exp:c_CodEmp%
	            AND BDK_MATRIC = %Exp:c_Matric%
	            AND BDK_TIPREG = %Exp:c_tipReg%
	            AND %Exp:c_Idade%  BETWEEN  BDK_IDAINI AND BDK_IDAFIN 
	            AND D_E_L_E_T_ = ' '
		ORDER BY %Order:BDK%
	EndSql 
	
	nCount := 0
	While !TMPBDK->( EOF() )  
	                      
	    n_ValorBDK := TMPBDK->BDK_VALOR
	    c_CodFai   := TMPBDK->BDK_CODFAI
	    nCount++
			     
		TMPBDK->( dbSkip() )
	
	EndDo  
	
	TMPBDK->( dbCloseArea() )  
	
	If nCount == 0
 	
 		l_Ret := .F.
		c_Obs := "002 - Sem faixa usuario"    
		
	ElseIf nCount <> 1  
	
		l_Ret := .F.
		c_Obs := "001 - Mais de uma usuario"    
 	
 	EndIf
  
 	      
 	
 	c_Qry := " SELECT VALOR "
 	c_Qry += " FROM TABELA_PREFEITURA_2016 "
 	c_Qry += " WHERE CODPLA = '" + c_CodPla + "' "
 	c_Qry += "       AND TIPUSU = DECODE(TRIM(TIPUSU), '', ' ', '" + c_TipUsu + "') "
 	c_Qry += "       AND " + c_Idade + " BETWEEN IDAINI AND INDAFIN "
 	
 	TcQuery c_Qry ALIAS "TMPTABPAD" NEW 
 	
 	If !TMPTABPAD->( EOF() )
 	     
 		n_ValorTab := TMPTABPAD->VALOR
 	
 	EndIf      
 	
 	TMPTABPAD->( dbCloseArea() )
 	/*
 	
 	c_Qry := " Select sum(e1_saldo) saldo "    
 	c_Qry += " from se1010 "
 	c_Qry += " where e1_filial = '01' "
 	c_Qry += " and e1_cliente = '" + c_CodCli + "' "
 	c_Qry += " and e1_tipo    = 'RA' "
 	c_Qry += " and e1_saldo   <> 0 "
 	c_Qry += " and e1_anobase = '" + c_Ano + "' "
 	c_Qry += " and e1_mesbase = '" + c_Mes + "'
 	c_Qry += " and se1010.D_E_L_E_T_ = ' ' "
 	
 	TcQuery c_Qry ALIAS "TMPRAC" NEW 
 	
 	If !TMPRAC->( EOF() )
 	     
 		n_ValorRAC := TMPRAC->saldo
 	
 	EndIf      
 	
 	TMPRAC->( dbCloseArea() )

 	   */
 	a_Ret := {l_Ret,  c_CodEmp, c_Matric, c_tipReg, n_ValorBDK, n_ValorBFY, n_ValorBZX, c_Obs, n_ValorTab, n_ValorRAC} 
 	   
Return a_Ret

Static Function GravaPC5( a_GravaPC5, n_TotTabe )  

	Local l_Ret := .T. 
	Local n_Count := 1 
	
		dbSelectArea("PC5")
        
        For n_Count := 1 to Len ( a_GravaPC5 )
		
			 RecLock("PC5",.T.) 
			 
			   //	PC5->PC5_FILIAL := a_GravaPC5[01]
				PC5->PC5_COMPET := a_GravaPC5[n_Count][02]
				PC5->PC5_CPF    := a_GravaPC5[n_Count][03]
				PC5->PC5_MATPRE := a_GravaPC5[n_Count][04]
				PC5->PC5_CODINT := a_GravaPC5[n_Count][05]
				PC5->PC5_CODEMP := a_GravaPC5[n_Count][06]
				PC5->PC5_MATRIC := a_GravaPC5[n_Count][07]
				PC5->PC5_TIPREG := a_GravaPC5[n_Count][08]
				PC5->PC5_NOME   := a_GravaPC5[n_Count][09]                            
				PC5->PC5_DATBLO := stod(a_GravaPC5[n_Count][10])
				PC5->PC5_DATINC := stod(a_GravaPC5[n_Count][11])
				PC5->PC5_VLRDES := a_GravaPC5[n_Count][12]
				PC5->PC5_VLROPC := a_GravaPC5[n_Count][13]
				PC5->PC5_VLRTAB := a_GravaPC5[n_Count][14]
				
				PC5->PC5_VLRTCB := iif( a_GravaPC5[n_Count][17] == 'T', n_TotTabe , 0)
				PC5->PC5_VLRUSU := a_GravaPC5[n_Count][26]
			   
				PC5->PC5_FMLOK  := a_GravaPC5[n_Count][16]
				PC5->PC5_TIPUSU := a_GravaPC5[n_Count][17]
				
				PC5->PC5_VLRFAT := iif( a_GravaPC5[n_Count][17] == 'T',a_GravaPC5[n_Count][18], 0)
				PC5->PC5_VLRCNT := iif( a_GravaPC5[n_Count][17] == 'T',a_GravaPC5[n_Count][19], 0)
				PC5->PC5_VLRCND := iif( a_GravaPC5[n_Count][17] == 'T',a_GravaPC5[n_Count][29], a_GravaPC5[n_Count][20])
			   
				PC5->PC5_VLRTFA := iif( a_GravaPC5[n_Count][17] == 'T',a_GravaPC5[n_Count][18] + a_GravaPC5[n_Count][19] + a_GravaPC5[n_Count][29], 0)
				
				PC5->PC5_CPFTIT := a_GravaPC5[n_Count][22]
				PC5->PC5_OBS   	:= iif( a_GravaPC5[n_Count][17] == 'T',a_GravaPC5[n_Count][23], ' ')  
				
				PC5->PC5_BOLETO := IIF(a_GravaPC5[n_Count][17] == 'T' .and. a_GravaPC5[n_Count][24], 'S', 'N')
				PC5->PC5_VLRPAD := a_GravaPC5[n_Count][27]
				PC5->PC5_VLRRAC := a_GravaPC5[n_Count][28]
			   
			   
			   //	PC5->PC5_DIFERE := a_GravaPC5[n_Count][25]
				
			MSUnLock()
			
		Next
			
 	Return l_Ret		        
 	
 	
Static Function ReprocBase( c_Comp, c_CodInt, c_CodEmp, c_Matric )   
                      
	Local a_AreaPC5 := GetArea("PC5")
	
	dbSelectArea("PC5")  
	dbSetOrder(2)
	If dbSeek(xFilial("PC5") + c_Comp + c_CodInt + c_CodEmp + c_Matric)//PC5_FILIAL+PC5_COMPET+PC5_CODINT+PC5_CODEMP+PC5_MATRIC+PC5_TIPREG                                                                                                                 
	     
		While !PC5->( EOF() ) .AND. PC5->(PC5_COMPET+PC5_CODINT+PC5_CODEMP+PC5_MATRIC) == c_Comp + c_CodInt + c_CodEmp + c_Matric
		                    
	 		RecLock("PC5",.F.) 

				dbdelete() 

			MSUnLock()
	     
		    PC5->( dbSkip() )
		
		EndDo
	
	EndIf  
	
	MontaBase(.F., c_Matric)
	
	RestArea( a_AreaPC5 )


Return
 	
Static Function GeraPlanilha()
      
	Local a_AreaPC5 := GetArea( "PC5" ) 
	Local a_Vet     := {}   
		
	c_Qry := " select  distinct pc5_compet competencia,   "
	c_Qry += "         pc5_cpf     cpf,                   "
	c_Qry += "        pc5_matpre matricula_prefeitura,    "
	c_Qry += "        pc5_codint operadora,               "
	c_Qry += "        pc5_codemp empresa,                 "
	c_Qry += "        pc5_matric matric_caberj,           "
	c_Qry += "        pc5_tipreg tipreg  ,                "
	c_Qry += "        pc5_nome   nome ,                   "
	c_Qry += "        to_date(trim(pc5_datblo), 'YYYYMMDD')  data_bloq,   "
	c_Qry += "        to_date(trim(pc5_datinc), 'YYYYMMDD') data_inc,     "
	c_Qry += "        pc5_vlrdes valor_desconto,                          "
	c_Qry += "        pc5_vlropc valor_odonto,                            "
	c_Qry += "        pc5_tipusu tipo_usuario,                            "
	c_Qry += "        pc5_vlrtcb valor_total_familia,                     "
	c_Qry += "        pc5_vlrfat valor_fass,                              "
	c_Qry += "        pc5_vlrcnt valor_consignado_titular,                "
	c_Qry += "        pc5_vlrcnd valor_consignado_dependente,             "
	c_Qry += "        pc5_vlrtfa valor_total_recebido,                    "
	c_Qry += "        pc5_cpftit cpf_titular,                             "
	c_Qry += "        pc5_obs obs,                                        "
	c_Qry += "        pc5_boleto gera_bloeto                              "
	c_Qry += " from pc5010                                                "
	c_Qry += " where pc5_tipusu = 'T'                                     "
	c_Qry += " and pc5_compet = '" + c_Ano + c_Mes + "'                   "
	
	TcQuery c_Qry ALIAS "TMPLPLA" NEW  
	
	While !TMPLPLA->( EOF() )   	
	
		RestArea( a_AreaPC5 )	
		
		aadd (a_Vet, { 	TMPLPLA->competencia,;
						TMPLPLA->cpf,;
						TMPLPLA->matricula_prefeitura,;
						TMPLPLA->operadora,;
						TMPLPLA->empresa,;
						TMPLPLA->matric_caberj,;
						TMPLPLA->tipreg,;
						TMPLPLA->nome,;
						TMPLPLA->data_bloq,;
						TMPLPLA->data_inc,;
						TMPLPLA->valor_desconto,;
						TMPLPLA->valor_odonto,;
						TMPLPLA->tipo_usuario,;
						TMPLPLA->valor_total_familia,;
						TMPLPLA->valor_fass,;
						TMPLPLA->valor_consignado_titular,;
						TMPLPLA->valor_consignado_dependente,;
						TMPLPLA->valor_total_recebido,;
						TMPLPLA->cpf_titular,;
						TMPLPLA->obs,;
						TMPLPLA->gera_bloeto })                   
		
			TMPLPLA->( dbSkip() )   
	
		EndDo
	
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})	

Return	


User Function xxIncDes()
      
c_Qry := " SELECT * "
c_Qry += " FROM BBU010                "
c_Qry += " WHERE BBU_CODEMP = '0024'  "
c_Qry += " AND D_E_L_E_T_ = ' '       "
c_Qry += " AND NOT EXISTS ( SELECT * FROM BFY010 WHERE BFY_CODEMP = BBU_CODEMP "
c_Qry += "                                       AND BBU_MATRIC = BFY_MATRIC   "
c_Qry += "                                       AND BBU_CODFAI = BFY_CODFAI   "
c_Qry += "                                       AND (BFY_VALOR = 9 OR BFY_VALOR = 491.94 )             "
c_Qry += "                                       AND D_E_L_E_T_ = ' ')         "
                                      
TcQuery c_Qry ALIAS "TMPDES" NEW   

While !TMPDES->( EOF() )          

		RecLock("BFY",.T.)
		BFY->BFY_FILIAL := xFilial("BFY")
		BFY->BFY_CODOPE := TMPDES->BBU_CODOPE
		BFY->BFY_CODEMP := TMPDES->BBU_CODEMP
		BFY->BFY_MATRIC := TMPDES->BBU_MATRIC
		BFY->BFY_CODFOR := '101'
		BFY->BFY_CODFAI := TMPDES->BBU_CODFAI
		BFY->BFY_TIPUSR := TMPDES->BBU_TIPUSR
		BFY->BFY_GRAUPA := TMPDES->BBU_GRAUPA
		BFY->BFY_QTDDE  := 0
		BFY->BFY_QTDATE := 999
	    BFY->BFY_VALOR  := 9.00
		BFY->BFY_AUTOMA := "1" 
		BFY->BFY_TIPO   := "1"
	   
		BFY->(MsUnlock())
     
	
	TMPDES->( dbSkip() )
	
EndDo        

Return                   


User Function Pfr_PegaFam(c_CPF, c_Ano, c_Mes, c_Titu, l_Fam, c_PrfPla, n_VlPlan)
    
    Local a_Critica := {}
    Local Ret       := {}
    Local l_Ret     := .T.  
    Local c_CodInt := "0001"
    Local c_CodEmp := "0024"
    Local c_LastDay := DTOS(LASTDAY(STOD(c_Ano + c_Mes + "01")))
	
    Local n_ValDesc := 0     
 	Local n_ValTabe := 0 
	Local n_ValOpc  := 0
	Local n_ValPad  := 0
	Local n_Tot     := 0
	Local n_TotTabe := 0
	Local n_TotDesc := 0
	Local n_TotOpc  := 0
	Local n_TotFam  := 0
                              
	BeginSql Alias "TMPFAM"
	
   		SELECT IDADE_S(BA1_DATNAS, %Exp:c_LastDay% ) IDADE, BA3.*, BA1.*
      	FROM  %Table:BA3% BA3 INNER JOIN %Table:BA1% BA1 ON 
      								BA1_FILIAL = %xFilial:BA1% 
      								AND BA1_CODINT = BA3_CODINT 
      								AND BA1_CODEMP = BA3_CODEMP 
      								AND BA1_MATRIC = BA3_MATRIC
      								
      								
      	WHERE BA3_FILIAL = %xFilial:BA3%
            AND BA3_CODINT = %Exp:c_CodInt%
            AND BA3_CODEMP = %Exp:c_CodEmp%
            AND TRIM(BFY_MATEMP) = %Exp:c_CPF% 
            AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >  %Exp:c_LastDay%  )
            AND BA1_TIPUSU = %Exp:c_Titu%
            AND BA3.D_E_L_E_T_ = ' '
            AND BA1.D_E_L_E_T_ = ' '
           
	ORDER BY %Order:BA3%  
	
	EndSql    	
		
	nCount := 0
	While !TMPFAM->( EOF() )  

		a_Cobranca := RetValCob(  	TMPFAM->BA1_CODINT, TMPFAM->BA1_CODEMP, TMPFAM->BA1_MATRIC , TMPFAM->BA1_TIPREG, ;
									TMPFAM->BA1_TIPUSU, str(TMPFAM->IDADE))
			     
 		n_ValDesc := a_Cobranca[6] 
		n_ValTabe := a_Cobranca[5] 
		n_ValOpc  := a_Cobranca[7] 	   
		n_ValPad  := a_Cobranca[9] 	   
		n_Tot     := n_ValTabe + n_ValDesc + n_ValOpc  
        
		c_CodPla := ConvPlano(c_PrfPla,TMPFAM->BA1_TIPUSU,1)
        
	
		If l_Fam

			n_TotTabe += n_ValTabe      
			n_TotDesc += n_ValDesc   
			n_TotOpc  += n_ValOpc    
	    	n_TotFam += n_ValTabe + n_ValDesc + n_ValOpc  
            
		EndIF
	
		If c_CodPla <> TMPFAM->BA1_CODPLA

		    aadd(a_Critica, {'001', 'PLANO DIFERENTE' }) 
			
		EndIf                   
		
		
		If n_VlPlan < TMPFAM->BA1_CODPLA

		    aadd(a_Critica, {'002', 'RECEBIMENTO A MENOR' }) 
			
		EndIf   
		
		If n_VlPlan > TMPFAM->BA1_CODPLA

		    aadd(a_Critica, {'003', 'RECEBIMENTO A MAIOR' }) 
			
		EndIf

		AADD(a_Ret, { IIf (TMPFAM->BA1_SUBCON == '000000001', 'MED','ODO'),;
					TMPFAM->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),;
					TMPFAM->BA1_CODPLA,;
					TMPFAM->BA1_DATBLO,;
					n_Tot,;
					a_Critica})		  

		TMPFAM->( dbSkip() )
	
	EndDo          
	
Return a_Ret


/*
 A_RET
 
 1 - TIPO (ODO/MED)
 2 - MATRICULA
 3 - PLANO
 4 - DATA_BLOQ
 5 - VALOR_PLANO
 6 - CRITICA
 	ERRO 1 - MATRICULA INEXISTENTE
 	ERRO 2 - PLANO DIFERENTE
 	ERRO 3 - SEM DESCONTO
 	ERRO 4 - VALOR ODONTO INCONPATIVEL
 	ERRO 5 - VALOR DIFERENTE
 */
 
Static Function ConvDDDPlano(cPadrao, cMedOdo, cTipoRet)

Local cCD_PREVIRIO	:= ' '
Local cDS_PREVIRIO	:= ' '
Local cCODPLAOPE	:= ' '
Local cDESPLAOPE	:= ' '
Local cTIPOPLA		:= ' '
Local cSql     		:= ' '
Local cRet     		:= ' '

//cTipoRet	===>	"C"  ->  Retornara o Codigo do Plano que consta na BI3; "N"  ->	 Retornara o Nome do Plano

If cMedOdo == 'MED'
	cSQL := "SELECT PLANO_PREF CD_PREVIRIO, DS_PREVIRIO , PLANO_MEDICO CODPLA, DS_MEDICO DESPLA, 'MED' TIPO" 	+ CRLF
ElseIf cMedOdo == 'ODO'	
	cSQL := "SELECT PLANO_PREF CD_PREVIRIO, DS_PREVIRIO , PLANO_ODONTO CODPLA, DS_ODONTO DESPLA, 'ODO' TIPO" 	+ CRLF
EndIf

cSQL += "FROM PLANO_PREF_CAB" 																					+ CRLF 
cSQL += "WHERE trim(PLANO_PREF) = '" + cPadrao + "'" 																	+ CRLF 
cSQL += "ORDER BY 1,3,5"																						+ CRLF	 
	
TcQuery cSQL ALIAS "TMPPLA" NEW

dbSelectArea( "TMPPLA" )    

If !TMPPLA->(EOF())
	
	cCD_PREVIRIO	:= AllTrim(TMPPLA->CD_PREVIRIO)
	cDS_PREVIRIO	:= AllTrim(TMPPLA->DS_PREVIRIO)
	cCODPLAOPE		:= AllTrim(TMPPLA->CODPLA)
	cDESPLAOPE		:= AllTrim(TMPPLA->DESPLA)
	cTIPOPLA		:= AllTrim(TMPPLA->TIPO)

EndIf

TMPPLA->(DbCloseArea())

If cTipoRet == 'C'
	cRet := cCODPLAOPE
ElseIf cTipoRet == 'N' 
	cRet := cDESPLAOPE
EndIf

Return cRet


**'--------------------------------------------------------------------------------------------------'**
Static Function fBrBase(a_CposFat,a_StruFat, oFoldRes)  
**'--------------------------------------------------------------------------------------------------'**
   
	Local nIt := 0 

	
	Private c_AliasInd  := "u_"+c_AliasFat     
	Private cChave		:= "PC5_CPF"
    
	**'Monta estrutura da tabela'**
 //	fMonStFt()
	
	If Select(c_AliasFat) <> 0
		(c_AliasFat)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasFat)
		TcDelFile(c_AliasFat)
	Endif

	DbCreate(c_AliasFat,a_StruFat,"TopConn")
	If Select(c_AliasFat) <> 0
		(c_AliasFat)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasFat,c_AliasFat,.T.,.F.)
	(c_AliasFat)->(DbCreateIndex(c_AliasInd , cChave, {|| &cChave}, .F. ))
	(c_AliasFat)->(DbCommit())
	(c_AliasFat)->(DbClearInd())
	(c_AliasFat)->(DbSetIndex(c_AliasInd ))  

	DbSelectArea(c_AliasFat)
	(c_AliasFat)->(DbGoTop())
	
	oBrFat:=TcBrowse():New(014,005,380,240,,,,oFoldRes:aDialogs[2],,,,,,,oTela:oFont,,,,,.T.,c_AliasFat,.T.,,.F.,,,.F.)     // 420 380
	
	For nIt := 1 To Len(a_CposFat) 
	
		c2 := If(nIt == 1," ",a_CposFat[nIt,1] )
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasFat+"->"+c_CampoOk+"),onOk,oOk)}"),;
		       iif( nIt == 2,&("{|| IIF ("+c_AliasFat+"->"+c_Status+" == '009','001','002' )} "),;
		       &("{||"+c_AliasFat+"->"+a_CposFat[nIt,2]+"  }")))                                
		       
//		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasFat+"->"+c_CampoOk+"),onOk,oOk)}"),&("{||"+c_AliasFat+"->"+a_CposFat[nIt,2]+"  }"))
//		c3 := If(nIt == 1,&("{|| If("+c_AliasFat+"->"+c_CampoOk+" == '009','BR_AMARELO',oOk)}"),&("{||"+c_AliasFat+"->"+a_CposFat[nIt,2]+"  }"))
		
		c4 := If(nIt == 1,5,CalcFieldSize(a_CposFat[nIt,3],a_CposFat[nIt,4],a_CposFat[nIt,5],"",a_CposFat[nIt,1]))
		c5 := If(nIt == 1,"",a_CposFat[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)
        /*
       	c2 := If(nIt == 2," ",a_CposFat[nIt,1])
	   //	c3 :=  &("{|| If("+c_AliasFat+"->STATUS== ' ',OBRANCO , If("+c_AliasFat+"->STATUS == 'S',OVERDE , If("+c_AliasFat+"->STATUS == 'T',OAZUL , If("+c_AliasFat+"->STATUS == 'D',OCINZA , If("+c_AliasFat+"->STATUS == 'N',OPRETO , OAMARELO )))))}")
		c4 := If(nIt == 2,5,CalcFieldSize(a_CposFat[nIt,3],a_CposFat[nIt,4],a_CposFat[nIt,5],"",a_CposFat[nIt,1]))
		c5 := If(nIt == 2,"",a_CposFat[nIt,6])
		c6 := If(nIt == 2,.T.,.F.)
           */
	   	oBrFat:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	   //	oBrFat:bLDblClick   := {|| fAtuFat(c_AliasFat,c_CampoOk     )}
	Next                                  
	nAt := 1
//	oBrFat:bHeaderClick := {|| fAtuFat(c_AliasFat,c_CampoOk,,.T.)}
	    
Return 
                               
Static Function GETDCCLR(nLinha,nCor)
	Local nRet := 16777215
	if Empty(aItens[nLinha,3]) //neste exemplo, se tiver conteudo na 3ª coluna pinte-a da cor informada no parametro
		nRet := nCor
	ElseIf (aItens[nLinha,2]=="010021") //se na coluna 2 tiver o conteudo informado pinte de outra cor
		nRet := 4227327
	Else
		nRet := 16777215
	Endif
Return nRet


Static Function FilBase()
    
    Local c_Qry := ""
    
    c_Qry += " SELECT ' ' XOK, SUBSTR(PC5_OBS,1,3) XSTATS, PC5.*"
    c_Qry += " FROM " + RETSQLNAME("PC5") +  " PC5"
    c_Qry += " WHERE PC5_FILIAL = '" + XFILIAL("PC5") +  "' "
    c_Qry += "       AND PC5_COMPET = '" + c_Ano + c_Mes + "' "
      
	If TcCanOpen(c_AliasFat)
		TcDelFile(c_AliasFat)
	Endif
	     
	
	//cQuery := ChangeQuery(cQuery)
	If Select(c_AliasFat) <> 0 ; (c_AliasFat)->(DbCloseArea()) ; Endif
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),c_AliasFat,.T.,.T.)
	
	For ni := 2 to Len(a_StruFat)
		If a_StruFat[ni,2] != 'C'
			TCSetField(c_AliasFat, a_StruFat[ni,1], a_StruFat[ni,2],a_StruFat[ni,3],a_StruFat[ni,4])
		Endif
	Next
	
	cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
	Copy To &cTmp2 
	
	dbCloseArea()  
	
	dbUseArea(.T.,,cTmp2,c_AliasFat,.T.)
	
	//DbSelectArea(c_AliasFat)
	(c_AliasFat)->(DbGoTop())
	
	If (c_AliasFat)->(Eof())
		ApMsgInfo("Não foram encontrados registros com os parametros informados !")
		lRet := .F.
	Else
		
	Endif
	
Return    

Static Function PlaBase( c_AliasFat )  

	Processa({||l_Erro := fPlaBase( c_AliasFat )},"Gerando base...")      

Return       

Static Function fPlaBase( c_AliasFat )

    Local c_Compet := mv_par01  + mv_par02
	Local c_Qry := ""
	Local a_Vet := {}
	Local a_Tit := {}  
	Local c_LastDay := DTOS(LASTDAY(STOD(c_Compet + "01")))
	
	Local nOrdem                        // publica variavel 
	Private cDirDocs := MsDocPath()     // priva variavel com o caminho do arquivo temporario na rotina 
	Private cNomeArq := CriaTrab(,.F.) 
	                                                              // executa a funcao excel com o arquivo temporario gerado 
	
	c_Qry:= " SELECT  DISTINCT 		PC5_COMPET COMPETENCI,    "
	c_Qry+= "        PC5_CPF     	CPF,    "
	c_Qry+= "        PC5_MATPRE 	MAT_PREF,    "
	c_Qry+= "        PC5_CODINT 	OPERADORA,    "
	c_Qry+= "        PC5_CODEMP 	EMPRESA,    "
	c_Qry+= "        PC5_MATRIC 	MAT_CABERJ, "   
	c_Qry+= "        PC5_TIPREG 	TIPREG  ,   " 
	c_Qry+= "        PC5_NOME   	NOME ,    "
	c_Qry+= "        TO_DATE(TRIM(PC5_DATBLO), 'YYYYMMDD')  DT_BLOQ,    "
	c_Qry+= "        TO_DATE(TRIM(PC5_DATINC), 'YYYYMMDD') 	DT_INC,    "
	c_Qry+= "        to_char(PC5_VLRDES) VLR_DESCON,    "
	c_Qry+= "        to_char(PC5_VLROPC) VLR_ODONTO,    "
	c_Qry+= "        PC5_TIPUSU TP_USUARIO,  "
	c_Qry+= "        to_char(IDADE_S(BA1_DATNAS, '" + c_LastDay + "')) IDADE, "
	c_Qry+= "        BA1_CODPLA PLANO, "
	c_Qry+= "        CAST( RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) as char(40)) DESCPLANO, "
	c_Qry+= "        round(PC5_VLRTCB, 2) VLR_TOT_FA,    "
	c_Qry+= "        round(PC5_VLRUSU, 2) VLR_USUARI, "
	c_Qry+= "        round(PC5_VLRFAT, 2) VLR_FASS,    "
	c_Qry+= "        round(PC5_VLRCNT, 2) VLR_CON_T,    "
	c_Qry+= "        round(PC5_VLRCND, 2) VLR_CON_D, "   
	c_Qry+= "        round(PC5_VLRTFA, 2) VLR_RECEB,    "
/*
	c_Qry+= "        to_char(PC5_VLRTCB) VLR_TOT_FA,    "
	c_Qry+= "        to_char(PC5_VLRUSU) VLR_USUARI, "
	c_Qry+= "        to_char(PC5_VLRFAT) VLR_FASS,    "
	c_Qry+= "        to_char(PC5_VLRCNT) VLR_CON_T,    "
	c_Qry+= "        to_char(PC5_VLRCND) VLR_CON_D, "   
	c_Qry+= "        to_char(PC5_VLRTFA) VLR_RECEB,    "
*/

	c_Qry+= "        PC5_CPFTIT CPF,    "
	c_Qry+= "        PC5_OBS 	OBS,    "
	c_Qry+= "        (Select pc2_acao from PC2010 where pc2_compet = '" + c_Compet + "' and pc2_cpf = pc5_cpf and pc2_acao <> ' ' and rownum = 1)    acao_pre,     "
	c_Qry+= "        PC5_BOLETO GERA_BOLE , "
	c_Qry+= "        round(( Select sum(pc0_vlcomp) "
	c_Qry+= "        from pc0010 "
	c_Qry+= "        where pc0_compet = '" + c_Compet + "' "
	c_Qry+= "         and pc0_cpf = pc5_cpf),2) complem, "
	c_Qry+= "         pc5_obs, BA3_MOTBLO "



	c_Qry+= " FROM " + RetSqlName("PC5") + " PC5 INNER JOIN  " + RetSqlName("BA1") + " BA1 ON BA1_FILIAL = '  ' " 
	c_Qry+= "                        AND BA1_CODINT = '0001'  "
	c_Qry+= "                        AND BA1_CODEMP = '0024'  "
	c_Qry+= "                        AND BA1_MATRIC = PC5_MATRIC  "
	c_Qry+= "                        AND BA1_TIPREG = PC5_TIPREG  " 
	
	  
	c_Qry+= "                        INNER JOIN BA3010 ON BA3_FILIAL = ' ' " 
	c_Qry+= "                        AND BA3_CODINT = BA1_CODINT "
	c_Qry+= "                        AND BA3_CODEMP = BA1_CODEMP "
	c_Qry+= "                        AND BA3_MATRIC = BA1_MATRIC "
	
	c_Qry+= " WHERE  "
	c_Qry+= " PC5_COMPET = '" + c_Compet + "'  "
//	c_Qry+= " and pc5_matric = '101574'  "
	c_Qry+= " AND PC5.D_E_L_E_T_ = ' ' "
	c_Qry+= " AND BA1.D_E_L_E_T_ = ' ' "
	c_Qry+= " ORDER BY 7 "
	                                                              
	IF SELECT ("TMPBASE") > 0                                                                                                                                                                                                                          // para saber se nao esta em branco 
	   TMPBASE->(DBCLOSEAREA())                                                       // se esta em branco sai da rotina 
	ENDIF   
 
	TCQUERY c_Qry NEW ALIAS "TMPBASE"                        
	
	TMPBASE->( dbGoTop() )
	
	EXPEXCEL("TMPBASE")                                                               // executa a funcao excel com o arquivo temporario gerado 
	IF SELECT ("TMPBASE") > 0                                                                                                                                                                                                                          // para saber se nao esta em branco 
	   TMPBASE->(DBCLOSEAREA())                                                       // se esta em branco sai da rotina 
	ENDIF   
	                                                                        // fecha o loop 
	FErase(cDirDocs+"\"+cNomeArq+".DBF")                                           // apaga o temporario 
	
	//TMPFAT->( dbCloseArea() )	                                                                        // fecha o loop 
	FErase(cDirDocs+"\"+cNomeArq+".DBF")                                           // apaga o temporario 
	
	//TMPFAT->( dbCloseArea() )
	
Return    .T.

STATIC FUNCTION EXPEXCEL(AREA)   

Local cPath    := AllTrim(GetTempPath()) 
Local oExcelApp 
Local cArquivo := cNomeArq 
dbSelectArea(AREA)               

X := cDirDocs+"\"+cArquivo+".DBF"       	    	//
COPY TO &X VIA "DBFCDXADS"  
CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , cPath, .T. )   
//CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , "\interface\exporta\Base Prefeitura\" , .T. )   //"M:\Protheus_Data\interface\exporta\Base Prefeitura\" , .T. )   

 //"C:\01\"+cArquivo+".xls" )     

IF FRENAME( cPath+cArquivo+".DBF" ,  cPath +cArquivo+".xls"   ) = -1     
//IF FRENAME( "\interface\exporta\Base Prefeitura\"+cArquivo+".DBF" ,  "\interface\exporta\Base Prefeitura\"+cArquivo+".xls"   ) = -1     

    MsgAlert("Erro na operação: " + STR(FERROR()))
 
	BREAK    

EndIf

If ! ApOleClient( 'MsExcel' ) 
   MsgStop('MsExcel nao instalado') 
   Return Nil       

EndIf 

oExcelApp := MsExcel():New() 
oExcelApp:WorkBooks:Open(cPath +cArquivo+".xls" ) // Abre uma planilha 
oExcelApp:SetVisible(.T.) 

Return Nil    

*'------------------------------------------------------------------'*
*'-- Importa Fatura                                               --'*
*'------------------------------------------------------------------'*
Static Function ImpBol()     
*'------------------------------------------------------------------'*


Local l_Erro := .F.
                        
Private cTitRotina 		:= "Importa arquivo de boletos"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 			:= {}
Private l_Deleta 		:= .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg

c_Separador := ';'

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg   
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	Processa({||l_Erro := fImpBol()},"Importa arquivo de fatura...")
EndIf

Return
	
*'------------------------------------------------------------------'*
*'-- Insere PC0                                                   --'*
*'------------------------------------------------------------------'*
Static Function fImpBol()
*'------------------------------------------------------------------'*

Local c_Arq		:= c_dirimp
Local n_QtdLin	:= 0
Local n_TotLin	:= 0
Local nInserido	:= 0
Local aBuffer	:= {}
Local l_Erro	:= .F.
Local cMsg 		:= ''
Local cBusca	:= ''
Local cTEC		:= ''                                                  

Local lHasFile	:= .T.
Local cMatric	:= ''
Local cNomePro	:= ''
Local nProc		:= 0

DbSelectArea('PC0')   

If !Empty(c_Arq)

	ProcRegua(0)
	
	For n_TotLin := 1 to 5
		IncProc('Abrindo o arquivo...')
	Next

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	cMsg := "Arquivo a ser importado não localizado!" + CRLF
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	lHasFile	:= .F.
	
EndIf 

If !l_Erro .and. lHasFile 

    //Leonardo Portella - 30/03/16
    //c_Sql := " update update ba3010 set BA3_XGRPR = 'FASS', BA3_COBNIV = '0' "
	c_Sql := " UPDATE BA3010 SET BA3_XGRPR = 'FASS', BA3_COBNIV = '0', BA3_TIPPAG = '09', BA3_PORTAD = '237', BA3_AGEDEP = '3369', BA3_CTACOR = '8895' WHERE "
	
	c_Sql += " ba3_filial = ' ' "
	c_Sql += " and ba3_codint = '0001' "
	c_Sql += " and ba3_codemp in ('0024') "
	c_Sql += " and ba3_subcon = '000000003' "
	c_Sql += " AND D_E_L_E_T_ = ' ' "
	
	If TcSqlExec(c_Sql) < 0
   		Alert(TcSqlError() + ' - Erro no UPDATE' ) 
   		return
	Else
	
	alert("Base Ajustada")
	Endif

	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))   
	
	ProcRegua(n_TotLin)   
	
	n_Qtd := 0
	n_Total := 0
		
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
	
		c_Buffer   := FT_FREADLN()
		
		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		c_Cpf 		:= StrZero(Val(aBuffer[1]),11)   
		c_oBS 		:= aBuffer[2] 
		
		//Leonardo Portella - 30/03/16 - Início - Deslocado para buscar na PC5 antes de buscar na BA3 com o PC5_MATRIC
		
		dbSelectArea("PC5")
		dbSetOrder(1)
		If dbSeek( xFilial("PC5") + c_Ano + c_Mes + c_Cpf )
			
	 		PC5->(Reclock('PC5',.F.))
			
				PC5->PC5_BOLFIN    	:= "S"
				PC5->PC5_OBSFIN    	:= c_oBS
			
	  		PC5->(MsUnlock())
			
		Else
		
		  //	Alert('Não localizou PC5: ' + c_Ano + c_Mes + c_Cpf)
		
		EndIf
    
		//Leonardo Portella - 30/03/16 - Fim
   	
   		c_Sql := " UPDATE BA3010 SET BA3_XGRPR = 'BOLE', BA3_COBNIV = '1', BA3_TIPPAG = '09', BA3_PORTAD = '237', BA3_AGEDEP = '3369', BA3_CTACOR = '8895' WHERE "

	
 		c_Sql += " ba3_filial = ' ' "
		c_Sql += " and ba3_codint = '0001' "
		c_Sql += " and ba3_codemp in ('0024') "
		c_Sql += " and ba3_subcon = '000000003' "
		c_Sql += " and trim(ba3_matemp) = '" + c_Cpf + "' "
		c_Sql += " AND D_E_L_E_T_ = ' ' "
		
		If TcSqlExec(c_Sql) < 0
	   		Alert(TcSqlError() + ' - Erro no UPDATE' )
		else
		c:=1
		EndIf
	
		/*
		dbSelectArea("BA3")
		dbSetOrder(5)
		If dbSeek( xFilial("BA3") + '00010024' + PC5->PC5_CPF )
//		If dbSeek( xFilial("BA3") + '00010024' + PC5->PC5_CPF )
			
	 		BA3->(Reclock('BA3',.F.))
			
				BA3->BA3_XGRPR    	:= "BOLE"
				BA3->BA3_COBNIV    	:= "1"
			
	  		BA3->(MsUnlock())
	  		
	  		nProc++
			
		Else
		
			alert('Não localizou BA3: Matric [ ' + PC5->PC5_MATRIC + ' ]')
		
		EndIf
        */

    	//Leonardo Portella - 30/03/16 - Início - Deslocado para buscar na PC5 antes de buscar na BA3 com o PC5_MATRIC
		
		/*
		dbSelectArea("PC5")
		dbSetOrder(1)
		If dbSeek( xFilial("PC5") + c_Ano + c_Mes + c_Cpf )
			
	 		PC5->(Reclock('PC5',.F.))
			
				PC5->PC5_BOLFIN    	:= "S"
			
	  		PC5->(MsUnlock())
			
		Else
		
			alert('Não localizou PC5: ' + c_Ano + c_Mes + c_Cpf)
		
		EndIf
        */
        
        //Leonardo Portella - 30/03/16 - Fim
		
    
    	/*    
		c_Sql := " update se1010 set E1_XSERNF = 'BOL', E1_FORMREC = '09' , E1_PORTADO = '237', E1_agedep = '3369', e1_conta = '8895' "
		c_Sql += " where e1_filial = '01' "
		c_Sql += " and e1_codint = '0001' "
		c_Sql += " and e1_codemp = '0024' "
		c_Sql += " and e1_matric = '" + PC5->PC5_MATRIC + "' "
		c_Sql += " and e1_anobase = '" + c_Ano + "' "
		c_Sql += " and e1_mesbase = '" + c_Mes + "' "
	   	c_Sql += " and e1_tipo = 'DP' "
	   	c_Sql += " and e1_numbor = ' ' "
		c_Sql += " and d_e_L_e_t_ = ' ' "
		
		If TcSqlExec(c_Sql) < 0
	   		Alert(PC5->PC5_MATRIC)
		Endif
			*/	

		nInserido++

		FT_FSKIP()
			
	EndDo
	
	FT_FUSE()
	
EndIf
   
If !l_Erro .and. lHasFile
	//MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC0'),AllTrim(SM0->M0_NOMECOM))
	MsgAlert("Processados " + AllTrim(Transform(nProc,'@E 999,999,999')) + " de " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC5'),AllTrim(SM0->M0_NOMECOM))
EndIf

Return l_Erro


Static Function ConvPlano(cPadrao, _cTipUsu, _nOpc)
	
	Local cSql	:= " "
	Local cRet	:= " "
	
	cSQL := "SELECT " 												+ CRLF
	cSQL += "	PLANO_PREF CD_PREVIRIO, DS_PREVIRIO, "				+ CRLF
	cSQL += "	PLANO_MEDICO CODPLA, TIP_USU, DS_MEDICO"			+ CRLF
	cSQL += "FROM " 													+ CRLF
	cSQL += "	PLANO_PREF_CAB_NV "									+ CRLF
	cSQL += "WHERE "													+ CRLF
	cSQL += "	TRIM(PLANO_PREF) = '" + AllTrim(cPadrao) + "'"	+ CRLF
	
	If AllTrim(cPadrao) $ "283|284"
		
		cSQL += "	AND TIP_USU = '" + _cTipUsu + "'" 				+ CRLF
		
	EndIf
	
	TcQuery cSQL ALIAS "TMPPLA" NEW
	
	dbSelectArea( "TMPPLA" )
	
	If !TMPPLA->(EOF())
		
		If _nOpc = 1
			
			cRet := Trim(TMPPLA->CODPLA)
			
		ElseIf _nOpc = 2
			
			cRet := Trim(TMPPLA->DS_MEDICO)
			
		EndIf
		
	EndIf
	
	TMPPLA->(DbCloseArea())
	
Return cRet  
************************************************************************************************************


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Jean Schulz          º Data ³ 26/10/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria / ajusta as perguntas da rotina                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Ajust_SX1(cPerg)

//	PutSx1(cPerg,"01",OemToAnsi("Arquivo a importar:"),"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
//  PutSx1(cPerg,"02",OemToAnsi("Movimento Bancário:"),"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Total","","","","Unitário","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"01",OemToAnsi("Data Baixa"),"","","mv_ch1","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	
Return  