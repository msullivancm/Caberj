#include "protheus.ch"
#include "msgraphi.ch"
#include "fileio.ch"


*'------------------'*
*'Includes especiais'*
*'------------------'*

#INCLUDE "UTILIDADES.CH"

*'-------------------------------------------------------------------------'*
*' Programa  ³Menu      |Autor  ³Leonardo Portella   | Data ³  13/02/12    '*
*'-------------------------------------------------------------------------'*
*' Desc.     ³ Menu com: Folder, consulta F3, ComboBox, CheckBox,          '*
*'           ³ RadioButton, Sbutton, Button entre outros                   '*
*'-------------------------------------------------------------------------'*
*' Uso       ³ Consulta de utilização das funções. Tipos de botões.        '*
*'-------------------------------------------------------------------------'*

**********************************************************************************************************************************

User Function Menu

nRet := 1

While nRet > 0

	If nRet == 1
		nRet := MenuUteis()
	ElseIf nRet == 2	
		nRet := MenuExemplos()
	EndIf

EndDo

Return

**********************************************************************************************************************************

Static Function MenuUteis

Local nRet := 0

SetPrvt("oDlg1","oFld1","oGrp1","oSay1","oSBtn1","oBtn1","oBtn2","oBtn3","oBtn4","oBtn5","oBtn6","oBtn7")
SetPrvt("oBtn8","oBtn9")

oDlg1      := MSDialog():New( 092,230,445,812,"Utilidades",,,.F.,,,,,,.T.,,,.T. ) 

oFld1      := TFolder():New( 044,017,,{},oDlg1,,,,.T.,.F.,256,092,) 

oGrp1      := TGroup():New( 008,017,040,273,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

oSay1      := TSay():New( 016,025,{||"Funções úteis"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)

oBtn1      := TButton():New( 060,028,"Funções"				,oDlg1,{||u_Funcoes()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 076,028,"Classes"				,oDlg1,{||u_Classes()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 092,028,"Cores"				,oDlg1,{||LogErros(u_TriColor(.T.),'Cor')}	,037,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 108,028,"Bitmaps"				,oDlg1,{||LogErros(u_Bitmaps(),'Bitmaps')}	,037,012,,,,.T.,,"",,,,.F. )
oBtn5      := TButton():New( 060,072,"Fontes Texto"		,oDlg1,{||u_Dialogo()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn6      := TButton():New( 076,072,"SQL"					,oDlg1,{||u_JoinSQL()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn7      := TButton():New( 092,072,"Funções Texto"		,oDlg1,{||u_FuncsTexto()}					,037,012,,,,.T.,,"",,,,.F. )
oBtn8      := TButton():New( 108,072,"Botões"				,oDlg1,{||u_Botoes()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn9      := TButton():New( 060,116,"Alertas"				,oDlg1,{||u_Alertas()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn10     := TButton():New( 076,116,"Sel. Usr. Prot."		,oDlg1,{||u_CadUsr()}						,037,012,,,,.T.,,"",,,,.F. )
oBtn11     := TButton():New( 092,116,"Func. to User."		,oDlg1,{||u_FunToUser()}					,037,012,,,,.T.,,"",,,,.F. )
oBtn11     := TButton():New( 108,116,"Teste variavel"		,oDlg1,{||u_ExTstVar()}			  			,037,012,,,,.T.,,"",,,,.F. )
oBtn12     := TButton():New( 060,160,"USERGA e GI"			,oDlg1,{||LogToNome()}			  			,037,012,,,,.T.,,"",,,,.F. )
 
oBtnBmp := TBtnBmp2():New(290,45,26,26,'TK_REFRESH',,,,{||nRet := 2,oDlg1:End()},oDlg1,,,.T. )
oBtnBmp:cToolTip := "Alternar modo..."

oSBtn1     := SButton():New( 148,248,1,{||oDlg1:End()},oDlg1,,"", )

oDlg1:Activate(,,,.T.)

Return nRet                                                                                             

**********************************************************************************************************************************

User Function Botoes

Local cAtencao := "Atenção"                                                           

DEFINE MSDIALOG oDlgX TITLE "Botões" FROM 0,0 TO 130,310 PIXEL

	DEFINE SBUTTON FROM  4, 5  TYPE  1 ACTION (MsgInfo("Tipo  1",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 18, 5  TYPE  2 ACTION (MsgInfo("Tipo  2",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 32, 5  TYPE  3 ACTION (MsgInfo("Tipo  3",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 46, 5  TYPE  4 ACTION (MsgInfo("Tipo  4",cAtencao)) ENABLE OF oDlgX
	
	DEFINE SBUTTON FROM  4,35  TYPE  5 ACTION (MsgInfo("Tipo  5",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 18,35  TYPE  6 ACTION (MsgInfo("Tipo  6",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 32,35  TYPE  7 ACTION (MsgInfo("Tipo  7",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 46,35  TYPE  8 ACTION (MsgInfo("Tipo  8",cAtencao)) ENABLE OF oDlgX
	
	DEFINE SBUTTON FROM  4,65  TYPE  9 ACTION (MsgInfo("Tipo  9",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 18,65  TYPE 10 ACTION (MsgInfo("Tipo 10",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 32,65  TYPE 11 ACTION (MsgInfo("Tipo 11",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 46,65  TYPE 12 ACTION (MsgInfo("Tipo 12",cAtencao)) ENABLE OF oDlgX
	
	DEFINE SBUTTON FROM  4,95  TYPE 13 ACTION (MsgInfo("Tipo 13",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 18,95  TYPE 14 ACTION (MsgInfo("Tipo 14",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 32,95  TYPE 15 ACTION (MsgInfo("Tipo 15",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 46,95  TYPE 16 ACTION (MsgInfo("Tipo 16",cAtencao)) ENABLE OF oDlgX
	
	DEFINE SBUTTON FROM  4,125 TYPE 17 ACTION (MsgInfo("Tipo 17",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 18,125 TYPE 18 ACTION (MsgInfo("Tipo 18",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 32,125 TYPE 19 ACTION (MsgInfo("Tipo 19",cAtencao)) ENABLE OF oDlgX
	DEFINE SBUTTON FROM 46,125 TYPE 20 ACTION (MsgInfo("Tipo 20",cAtencao)) ENABLE OF oDlgX
	
ACTIVATE MSDIALOG oDlgX CENTERED	
	
Return

**********************************************************************************************************************************

User Function Alertas

DEFINE MSDIALOG oDlgX TITLE "Alertas" FROM 0,0 TO 130,300 PIXEL

	  @ 8 ,5 BUTTON "&MsgInfo"    SIZE 40,10 PIXEL ACTION MsgInfo("Informação","Mensagem") OF oDlgX
	  @ 20,5 BUTTON "M&sgAlert"   SIZE 40,10 PIXEL ACTION MsgAlert("Alerta 1","Mensagem") OF oDlgX
	  @ 32,5 BUTTON "Ms&gStop"    SIZE 40,10 PIXEL ACTION MsgStop("Stop","Mensagem") OF oDlgX
	  @ 44,5 BUTTON "RetryCancel" SIZE 40,10 PIXEL ACTION MsgRetryCancel("Título","Mensagem") OF oDlgX

	  @ 8,55 BUTTON "&Help 1"     SIZE 40,10 PIXEL ACTION {||;
	  		If (u_lProtheus(),;
	  			Help("",1,"","HELP","Help Padrão Protheus",1,0),;
	  			)} OF oDlgX //help padrao siga, o nome eh a chave no sigaadv.hlp
	  			
	  @ 20,55 BUTTON "Msg&YesNo"    SIZE 40,10 PIXEL ACTION MsgYesNo("Aceitar ?","Mensagem") OF oDlgX
	  @ 32,55 BUTTON "Msg&NoYes"    SIZE 40,10 PIXEL ACTION MsgNoYes("Aceitar ?","Mensagem") OF oDlgX
	  @ 44,55 BUTTON "A&viso"    	SIZE 40,10 PIXEL ACTION {||;
	  		If (u_lProtheus(),;
		  		Aviso("Titulo 1","Corpo para Mensagem",{"Ok","Cancelar"}),;
		  		)} OF oDlgX 
	          
	  @ 8 ,105 BUTTON "&Probl./Solução"  SIZE 40,10 PIXEL ACTION ;
	  		  ShowHelpDlg("Título", {"Problema","1","2","3","4","5","6"},,{"Solução","1","2","3","4","5","6"},);
	  		  OF oDlgX    
	  		  
	  @ 20,105 BUTTON "Msg&Run"  SIZE 40,10 PIXEL ACTION MsgRun("Não interrompe o processamento","Esperando ... ",{||u_testeMsgRun()}); 
     		  OF oDlgX   
     		  
      aButtons := {}		  
      aAdd(aButtons, { 1,.T.,{|| MsgInfo("Ok") }} )
      aAdd(aButtons, { 2,.T.,{|| Alert("Sair") }} )
                                                                                
	  @ 32,105 BUTTON "&FormBatch" SIZE 40,10 PIXEL ACTION {||;
		  			If (u_lProtheus(),u_Procx(),)};
	  		  		OF oDlgX    

ACTIVATE MSDIALOG oDlgX CENTERED

Return

**********************************************************************************************************************************

Static Function MenuExemplos
           
Local nRet 	   := 0
Local oDlg     := Nil
Local cNome    := space(20)
Local nCodigo  := 0
Local dInicial := CtoD(space(8))
Local cDir     := space(250)
Local cArq     := space(250)
Local cPath    := "Selecione diretório"
Local cExt     := "Arquivo DBF | *.DBF" //  | *.DBF => arquivo que aparece no Drop Down 
Local cViaF3   := Space(10)
Local cCombo   := Space(10)
Local aCombo   := {}
Local aRadio   := {}
Local cAtencao := "Atenção"                                                               
Local lChk     := .F.
Local nRadio   := 0   
Local oMemo    := Nil
Local cMemo    := " " 
Private cEOL   := chr(13)+chr(10) 

//+----------------------------------------------------------------------------
//| Atribuição as matrizes
//+----------------------------------------------------------------------------
aAdd( aCombo, "Opcao 1" )
aAdd( aCombo, "Opcao 2" )
aAdd( aCombo, "Opcao 3" )
aAdd( aCombo, "Opcao 4" )
aAdd( aCombo, "Opcao 5" )

aAdd( aRadio, "Disco" )
aAdd( aRadio, "Impressora" )
aAdd( aRadio, "Scanner" )

//+------------------------------------------------------------------------------------------------
//| Definição da janela e seus conteúdos
//+------------------------------------------------------------------------------------------------
DEFINE MSDIALOG oDlg TITLE "Leonardo - Consulta de utilização das funções e Tipos de botões. ";
      FROM 0,0 TO 380,500 OF oDlg PIXEL//alt x larg
      
      @ 05,05  TO 70,245 LABEL "Fornecedor" OF oDlg PIXEL //1 pixel do Label = 2 pixels do Dialog
      @ 15,15  SAY "Nome"     PIXEL OF oDlg   //linha, coluna
      @ 13,45  MSGET cNome    PICTURE "@!" SIZE 80,10 PIXEL OF oDlg
      @ 30,15  SAY "Código"   PIXEL OF oDlg PIXEL
      @ 28,45  MSGET nCodigo  PICTURE "@!" SIZE 80,10 PIXEL OF oDlg
      @ 45,15  SAY "Data inicial" PICTURE OF oDlg PIXEL
      @ 43,45  MSGET dInicial PICTURE "@!99/99/9999" SIZE 80,10 PIXEL OF oDlg
      
      //criacao do folder, onde o objeto é "oFld" dentro do oDlg
/*->*/@ 80,05 FOLDER oFld OF oDlg PROMPT "&Buscas", "&Consultas", "B&otões", "&Alertas", "&Memo", "&Funções", "O&utros";
      PIXEL SIZE 240,078
      
      //+----------------------------------------------------------------------------
	  //| Campos da 1ª pasta (Buscas)
      //+----------------------------------------------------------------------------
	  @ 10, 10 SAY "Arquivo:"                   SIZE  65, 8 PIXEL OF oFld:aDialogs[1]
	  @ 20, 10 MSGET cArq PICTURE "@!"          SIZE 180,10 PIXEL OF oFld:aDialogs[1]
	  @ 19,200 BUTTON "..."                     SIZE  30,10 PIXEL OF oFld:aDialogs[1];
	                    ACTION cArq:=AllTrim(cGetFile(cExt,SubStr(cExt,1,12),,,.T.,1)) 
      
	  //+----------------------------------------------------------------------------
	  //| Campos da 2ª pasta (Consultas)
      //+----------------------------------------------------------------------------
      @ 06, 10 SAY "Consulta via [F3]"            SIZE  65, 8 PIXEL OF oFld:aDialogs[2]
/*->*/@ 16, 10 MSGET cViaF3 F3 "SA2" PICTURE "@!" SIZE 180,10 PIXEL OF oFld:aDialogs[2]//cria a consulta F3
      @ 30, 10 SAY "Consulta via ComboBox"        SIZE  65, 8 PIXEL OF oFld:aDialogs[2]
/*->*/@ 40, 10 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 180,10 PIXEL OF oFld:aDialogs[2]/*retorna o 
      número da posicao do aCombo, depois deve ser feita validacao no aCombo*/
      
      //+----------------------------------------------------------------------------
	  //| Botões da 3ª pasta (Botões)
	  //+----------------------------------------------------------------------------
	  DEFINE SBUTTON FROM  4, 75 TYPE  1 ACTION (MsgInfo("Tipo  1",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 18, 75 TYPE  2 ACTION (MsgInfo("Tipo  2",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 32, 75 TYPE  3 ACTION (MsgInfo("Tipo  3",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 46, 75 TYPE  4 ACTION (MsgInfo("Tipo  4",cAtencao)) ENABLE OF oFld:aDialogs[3]

	  DEFINE SBUTTON FROM  4,105 TYPE  5 ACTION (MsgInfo("Tipo  5",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 18,105 TYPE  6 ACTION (MsgInfo("Tipo  6",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 32,105 TYPE  7 ACTION (MsgInfo("Tipo  7",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 46,105 TYPE  8 ACTION (MsgInfo("Tipo  8",cAtencao)) ENABLE OF oFld:aDialogs[3]

	  DEFINE SBUTTON FROM  4,135 TYPE  9 ACTION (MsgInfo("Tipo  9",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 18,135 TYPE 10 ACTION (MsgInfo("Tipo 10",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 32,135 TYPE 11 ACTION (MsgInfo("Tipo 11",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 46,135 TYPE 12 ACTION (MsgInfo("Tipo 12",cAtencao)) ENABLE OF oFld:aDialogs[3]

	  DEFINE SBUTTON FROM  4,165 TYPE 13 ACTION (MsgInfo("Tipo 13",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 18,165 TYPE 14 ACTION (MsgInfo("Tipo 14",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 32,165 TYPE 15 ACTION (MsgInfo("Tipo 15",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 46,165 TYPE 16 ACTION (MsgInfo("Tipo 16",cAtencao)) ENABLE OF oFld:aDialogs[3]

	  DEFINE SBUTTON FROM  4,195 TYPE 17 ACTION (MsgInfo("Tipo 17",cAtencao)) ENABLE OF oFld:aDialogs[3]
	  DEFINE SBUTTON FROM 18,195 TYPE 18 ACTION (MsgInfo("Tipo 18",cAtencao)) ENABLE OF oFld:aDialogs[3]
 	  DEFINE SBUTTON FROM 32,195 TYPE 19 ACTION (MsgInfo("Tipo 19",cAtencao)) ENABLE OF oFld:aDialogs[3]
/*->*/DEFINE SBUTTON FROM 46,195 TYPE 20 ACTION (MsgInfo("Tipo 20",cAtencao)) ENABLE OF oFld:aDialogs[3]
//--->botão com bitmap é SBUTTON, deve se definir a função chamada 

      /*variável do check, neste caso a msg é no momento do clique mas pode ser considerada no OK para 
      alguma validação*/
/*->*/@ 05, 10 CHECKBOX oChk VAR lChk PROMPT "Check Box" SIZE 40,10 PIXEL OF oFld:aDialogs[3] ;
          ON CLICK(Iif(lChk,MsgInfo("Habilitado",cAtencao),MsgAlert("Desabilitado",cAtencao)))   
          
      @ 18,10  SAY "Spin"     PIXEL OF oFld:aDialogs[3]
      nSpinBox := -10
/*->*/oSpinBox := tSpinBox():new(15, 23, oFld:aDialogs[3], {|x| nSpinBox := x }, 30, 13)
      oSpinBox:setRange(-50, 50)
      oSpinBox:setStep(5)//pulo
      oSpinBox:setValue(nSpinBox)//nSpinBox == valor atual do SpinBox
            
      //variavel numérica   //colocar a qtd de itens no array até 10
/*->*/@ 30, 10 RADIO oRadio VAR nRadio ITEMS aRadio[1],aRadio[2],aRadio[3] SIZE 40,10 PIXEL OF ;
            oFld:aDialogs[3] ;
            ON CHANGE ;		//no momento do clique
                (If(nRadio==1,MsgInfo("Opcão 1",cAtencao),;
                 If(nRadio==2,MsgInfo("Opção 2",cAtencao),;
                              MsgInfo("Opção 3",cAtencao))))
                
      //+----------------------------------------------------------------------------
	  //| Botões da 4ª pasta (Alertas)
	  //+----------------------------------------------------------------------------
	  @ 8,35 BUTTON "&MsgInfo"    SIZE 40,10 PIXEL ACTION MsgInfo("Informação","Mensagem");
	          OF oFld:aDialogs[4]
	  @ 20,35 BUTTON "M&sgAlert"   SIZE 40,10 PIXEL ACTION MsgAlert("Alerta 1","Mensagem");
	  		  OF oFld:aDialogs[4]
	  @ 32,35 BUTTON "Ms&gStop"    SIZE 40,10 PIXEL ACTION MsgStop("Stop","Mensagem");
	  		  OF oFld:aDialogs[4]
	  @ 44,35 BUTTON "RetryCancel" SIZE 40,10 PIXEL ACTION MsgRetryCancel("Título","Mensagem");
	  		  OF oFld:aDialogs[4]
								//help especifico, eh necessario ter os dois ultimos parametros//help padrao siga, o nome eh a chave no sigaadv.hlp
	  @ 8,95 BUTTON "&Help 1"     SIZE 40,10 PIXEL ACTION {||;
		  			If (u_lProtheus(),;
		  			Help("",1,"","HELP","Help Padrão Protheus",1,0),)};
	          OF oFld:aDialogs[4] 
                                               //help padrao siga, o nome eh a chave no sigaadv.hlp
	  @ 20,95 BUTTON "Msg&YesNo"    SIZE 40,10 PIXEL ACTION MsgYesNo("Aceitar ?","Mensagem");
	  		  OF oFld:aDialogs[4]
	  @ 32,95 BUTTON "Msg&NoYes"    SIZE 40,10 PIXEL ACTION MsgNoYes("Aceitar ?","Mensagem");
	  		  OF oFld:aDialogs[4]
			//ate 5 opcoes,tipo - define o tamanho da janela,subtitulo
			//fazer tratamento caso o usuario clique no "X"
	  @ 44,95 BUTTON "A&viso"    SIZE 40,10 PIXEL ACTION {||;
		  			If (u_lProtheus(),;
		  			Aviso("Titulo 1","Corpo para Mensagem",{"Ok","Cancelar"}),)};
	          OF oFld:aDialogs[4] 
	          
	  @ 8 ,155 BUTTON "&Probl./Solução"  SIZE 40,10 PIXEL ACTION ;
	  		  ShowHelpDlg("Título", {"Problema","1","2","3","4","5","6"},,{"Solução","1","2","3","4","5","6"},);
	  		  OF oFld:aDialogs[4]    
	  		  
	  @ 20,155 BUTTON "Msg&Run"  SIZE 40,10 PIXEL ACTION MsgRun("Não interrompe o processamento","Esperando ... ",{||u_testeMsgRun()}); 
     		  OF oFld:aDialogs[4]   
     		  
      aButtons := {}		  
      aAdd(aButtons, { 1,.T.,{|| MsgInfo("Ok") }} )
      aAdd(aButtons, { 2,.T.,{|| Alert("Sair") }} )
                                                                                
	  @ 32,155 BUTTON "&FormBatch" SIZE 40,10 PIXEL ACTION {||;
		  			If (u_lProtheus(),u_Procx(),)};
	  		  		OF oFld:aDialogs[4]    
	  		  
		 
	  //+----------------------------------------------------------------------------
	  //| Campos da 5ª pasta (Memo)
      //+----------------------------------------------------------------------------  
 
	  cMemo := space(50)

      oMemo := tMultiGet():New(10,10,{|u|if(Pcount()>0,cMemo:=u,cMemo)},oFld:aDialogs[5],150,40,,,,,,.T.)
	  @ 10,180 BUTTON "Mostrar Texto" SIZE 40,10 PIXEL ACTION MsgInfo(cMemo) OF oFld:aDialogs[5]  
	  
	  //+----------------------------------------------------------------------------
	  //| Campos da 6ª pasta (Funções)
      //+----------------------------------------------------------------------------
      
	  @ 10,10  BUTTON "Árvore"        SIZE 40,10 PIXEL ACTION u_Arvore()            OF oFld:aDialogs[6] 
	  @ 20,10  BUTTON "Funções"       SIZE 40,10 PIXEL ACTION u_Funcoes()           OF oFld:aDialogs[6]   
      @ 30,10  BUTTON "Gráfico"       SIZE 40,10 PIXEL ACTION u_Grafico()           OF oFld:aDialogs[6]  
      @ 40,10  BUTTON "Tri. Color"    SIZE 40,10 PIXEL ACTION u_TriColor(.F.)       OF oFld:aDialogs[6]  
      @ 10,70  BUTTON "Grid Calend."  SIZE 40,10 PIXEL ACTION u_CalenGrid()         OF oFld:aDialogs[6]
      @ 20,70  BUTTON "Calendário"    SIZE 40,10 PIXEL ACTION u_Calendario()        OF oFld:aDialogs[6]  
      @ 30,70  BUTTON "Calculadora"   SIZE 40,10 PIXEL ACTION MsCalculator()        OF oFld:aDialogs[6]  
      @ 40,70  BUTTON "Exec. Windows" SIZE 40,10 PIXEL ACTION u_FuncsWin()          OF oFld:aDialogs[6]
      @ 10,130 BUTTON "Pont. Mouse"   SIZE 40,10 PIXEL ACTION u_PontMouse()         OF oFld:aDialogs[6] 
      @ 20,130 BUTTON "Fontes"        SIZE 40,10 PIXEL ACTION {||Fontes := GetFontList(), u_ExibeArray(Fontes, "Fontes")}   OF oFld:aDialogs[6]
      @ 30,130 BUTTON "Menu"          SIZE 40,10 PIXEL ACTION u_XMenu()             OF oFld:aDialogs[6] 
	  @ 40,130 BUTTON "Browse"        SIZE 40,10 PIXEL ACTION u_TCBrowse()          OF oFld:aDialogs[6] 
	  @ 10,190 BUTTON "EditFont"      SIZE 40,10 PIXEL ACTION u_Dialogo()           OF oFld:aDialogs[6] 
  	  @ 20,190 BUTTON "TelaAutoAjust" SIZE 40,10 PIXEL ACTION {||u_TelaAutoAjust()} OF oFld:aDialogs[6]
	  
	  oTButSetDtBr := TButton():New( 30, 190, "SetdBrit",oFld:aDialogs[6],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButSetDtBr:bAction  := {||u_SetDBrit()}
	  oTButSetDtBr:cToolTip := "Set Date To British - coloca no formato dd/mm/aa"  
	  
	  oTButNxtNum := TButton():New( 40, 190, "NextNumero",oFld:aDialogs[6],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButNxtNum:bAction  := {||if(u_lProtheus(),alert(NextNumero("SC7",1,"C7_NUM",.F., "000007")),)}
	  oTButNxtNum:cToolTip := "Próximo número disponível"    
	  
	  //+----------------------------------------------------------------------------
	  //| Campos da 7ª pasta (Outros)
      //+----------------------------------------------------------------------------
 	  
	  oTButFcTxt := TButton():New( 10, 10, "Funcs Texto",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButFcTxt:bAction  := {||u_FuncsTexto()}
	  oTButFcTxt:cToolTip := "Algumas funções de texto úteis"  
	  
	  oTBtPainel := TButton():New( 20, 10, "Painel",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTBtPainel:bAction  := {||u_Painel()}
	  oTBtPainel:cToolTip := "Painel"  
	  
	  oTBtTimer := TButton():New( 30, 10, "Timer",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTBtTimer:bAction  := {||u_Timer()}
	  oTBtTimer:cToolTip := "Temporizador"  	  
	   
	  oTBtTimer := TButton():New( 40, 10, "Borda e Al.",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTBtTimer:bAction  := {||u_SemBorda()}
	  oTBtTimer:cToolTip := "Dialog sem bordas e alinhamento"  
	  
	  oTButClass := TButton():New( 10, 70, "Classes",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_Classes()}
	  oTButClass:cToolTip := "Classes, métodos e variáveis"       
	  
	  oTButClass := TButton():New( 20, 70, "Bitmaps",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_Bitmaps()}
	  oTButClass:cToolTip := "Bitmaps e seus nomes" 
	  
	  oTButClass := TButton():New( 30, 70, "tSplitter",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_TSplitter()}
	  oTButClass:cToolTip := "tSplitter. Divide a tela"  
	  
	  oTButClass := TButton():New( 40, 70, "tPaintPanel",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_TPaintPanel()}
	  oTButClass:cToolTip := "Drag and drop de um container para outro" 
	  
      oTButClass := TButton():New( 10,130, "TReport",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||If(u_lProtheus(),u_ex_TRep(),)}
	  oTButClass:cToolTip := "Exemplo de TReport"       
	  
	  oTButClass := TButton():New( 20,130, "SQL",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_JoinSQL()}
	  oTButClass:cToolTip := "Exemplos interessantes: SQL"
	  
	  oTButClass := TButton():New( 30,130, "Regua Proc",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_ReguaProc()}
	  oTButClass:cToolTip := "Exemplo de criação de réguas de processamento em dialogs (usa tMeter)"
	  
	  oTButClass := TButton():New( 40,130, "TryCatch",oFld:aDialogs[7],,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	  oTButClass:bAction  := {||u_TryCatch()}
	  oTButClass:cToolTip := 'Exemplo de tratamento de erros (#INCLUDE "TRYEXCEPTION.CH")'

	  //+----------------------------------------------------------------------------
	  //| Botões da MSDialog
	  //+----------------------------------------------------------------------------
	  //Estes botões estão fora da pasta!!!!
	  
	  oBtnBmp := TBtnBmp2():New(330,15,26,26,'TK_REFRESH',,,,{||nRet := 1,oDlg:End()},oDlg,,,.T. )
      oBtnBmp:cToolTip := "Alternar modo..."

	  @ 165,050 BUTTON "&Ok"           SIZE 40,15 PIXEL ACTION oDlg:End()
      @ 165,110 BUTTON "&Sair"         SIZE 40,15 PIXEL ACTION oDlg:End()
      @ 165,170 BUTTON "&Expandir ==>" SIZE 40,15 PIXEL ACTION Expande(oDlg,.T.)
/*->*/@ 165,270 BUTTON "<== &Reduzir " SIZE 40,15 PIXEL ACTION Expande(oDlg,.F.)
//--->botões normais onde se define o texto, tamanho e função
      
	  @ 30,255  TO 60,315 LABEL "Exemplo de Relatório" OF oDlg PIXEL
	  DEFINE SBUTTON FROM 40, 270 TYPE  6  ACTION (u_Relat())  ENABLE OF oDlg
	  
	  @ 70,255  TO 100,315 LABEL "Exemplo de Árvores" OF oDlg PIXEL
	  DEFINE SBUTTON FROM 80, 270 TYPE  15 ACTION (u_Arvore()) ENABLE OF oDlg
      
ACTIVATE MSDIALOG oDlg CENTERED            

Return nRet   

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function SetDBrit() 

      cData := "19830425"
	  alert(StoD(cData))   
	  
	  Set Date To British
	  
	  msgalert(StoD(cData))
	  
Return 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Classes()

Local i := 0

Local cTit      	:= "Classes: seus métodos e parâmetros"

Private aClasses 	:= __ClsArr() 
Private aClassOrd 	:= {}
Private oFont   	:= TFont():New("Courier New",,15,,.T.)//Courier New é fonte monoespaçada 
Private cPesquisa 	:= "Pesquisar..."
Private cTGet     	:= PadR(cPesquisa,50," ")
Private oList1		:= Nil

aSort(aClasses,,,{|x,y| x[1] < y[1]})
  
For i := 1 to len(aClasses)
	aAdd(aClassOrd, aClasses[i][1])
Next

//Pixel Style DS_MODALFRAME - remover o botão sair/cancelar do dialog
DEFINE DIALOG oDlg TITLE cTit FROM 0,0 TO 400,600 PIXEL Style DS_MODALFRAME 
   
   oDlg:lEscClose  := .F. //cancela o sair pela tecla 'ESC'
   
   oTButton1 := TButton():New( 181, 5, "Sair",oDlg,,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
   oTButton1:bAction  := {||oDlg:End()}
   oTButton1:cToolTip := "Observe que não tem o botão Sair (x) no dialog" + chr(13) + chr(10) + "e a tecla 'ESC' não funciona." +;
   						 chr(13) + chr(10) + "Bom quando precisa validar alguma coisa na saída."

   nList  := 1
   
   @ 05,05 MSGET oTGet VAR cTGet PICTURE "@!" SIZE 80,08 PIXEL OF oDlg
   oTGet:bLostFocus := {||GeraClass(oScr, If(nList <= 0,1,nList), cTGet),oList1:SetArray(aClassOrd)}//bloco executado quando perde o foco

   oScr   := TScrollBox():New(oDlg,00,90,202,210,.T.,.T.,.T.)
   
   cClasse:= ""
   oList1 := TListBox():New(20,05,{|u|if(Pcount()>0,(cClasse:=u,nList:=aScan(aClasses,{|x|x[1] == cClasse})),nList),GeraClass(oScr, nList)},aClassOrd,80,150,,oDlg,,,,.T.)
   //oList1:Select(nList)
   
ACTIVATE DIALOG oDlg CENTERED ON INIT GeraClass(oScr, nList)

Return

/*************************************************************************************************************************************************/

Static Function GeraClass(oScr, nList, cFiltro)

Local i := 0
     
Local cTexto      := ""
Local nVermelho   := 595191   //vermelho mais vivo que o CLR_RED 
Local nAzul       := 14196776
Local nLin        := 0
Local nAltLin     := 9
Local nEnt        := 4 
Local aBuffer	  := {}     

Default cFiltro := ''

	oScr:FreeChildren() //Elimina, libera todos os objetos da classe onde este método é chamado. Método da classe TSrvObject.

	cFiltro 	:= allTrim(cFiltro)           
	
	If cFiltro == cPesquisa 
		cFiltro := ''
	EndIf
	
	If !empty(cFiltro)    

		aClassOrd	:= {}         
		aClasses 	:= __ClsArr() 
		
		aSort(aClasses,,,{|x,y| x[1] < y[1]})
		
		For i := 1 to len(aClasses)    
			If At(cFiltro,aClasses[i][1]) > 0
				aAdd(aClassOrd, aClasses[i][1])
				aAdd(aBuffer,aClasses[i])
			EndIf
		Next

		nList 		:= 1
		aClasses 	:= aClone(aBuffer)
		
	EndIf
	
	If nList > len(aClasses)
		nList := 1	
	ElseIf nList <= 0
		nList := 1
	EndIf
	
	If len(aClasses) > 0
			
	   	cTexto := aClasses[nList][1]
	   	oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
	   	oSay:SetText(cTexto)    
	   	nLin += nAltLin + nEnt
	   
	   	If !empty(aClasses[nList][2])
		   cTexto := 'Herda de: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := len(cTexto)*(3.5)
		   cTexto := aClasses[nList][2]
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin + nEnt  
	   	EndIf
	   
	   	For i := 1 to len(aClasses[nList][3]) 
		   cTexto := 'Variável: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := len(cTexto)*(3.5)
		   cTexto := If(!empty(aClasses[nList][3][i][1]),aClasses[nList][3][i][1],"")
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin  
	   	Next
	   
	   	nLin += nEnt
	   
	   	For i := 1 to len(aClasses[nList][4]) 
		   cTexto := 'Método: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := len(cTexto)*(3.5)
		   cTexto := If(!empty(aClasses[nList][4][i][1]),aClasses[nList][4][i][1],"")
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin  
	   	Next

	EndIf
	
Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function FuncsTexto() 

Local cTit      := "Funções de Texto"
Private lChkTds := lCheck1 := lCheck2 := lCheck3 := lCheck4 := lCheck5 := lCheck6 := lCheck7 := lCheck8 := lCheck9 := .T.
Private oFont   := TFont():New("Courier New",,15,,.T.)//Courier New é fonte monoespaçada 

DEFINE DIALOG oDlg TITLE cTit FROM 0,0 TO 800,1200 PIXEL 
   
   oCheck1 := TCheckBox():New(01,01,'Left',{||lCheck1},oDlg,100,210,,,,,,,,.T.,,,) 
   oCheck1:bLClicked := {||lCheck1 := !lCheck1, If(!lCheck1,lChkTds := .F.,),GeraTela(oScr)}   
    
   oCheck2 := TCheckBox():New(11,01,'Right',{||lCheck2},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck2:bLClicked := {||lCheck2 := !lCheck2, If(!lCheck2,lChkTds := .F.,),GeraTela(oScr)}   
    
   oCheck3 := TCheckBox():New(21,01,'Stuff',{||lCheck3},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck3:bLClicked := {||lCheck3 := !lCheck3, If(!lCheck3,lChkTds := .F.,),GeraTela(oScr)}   
    
   oCheck4 := TCheckBox():New(31,01,'PadC',{||lCheck4},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck4:bLClicked := {||lCheck4 := !lCheck4, If(!lCheck4,lChkTds := .F.,),GeraTela(oScr)}   
    
   oCheck5 := TCheckBox():New(41,01,'At',{||lCheck5},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck5:bLClicked := {||lCheck5 := !lCheck5, If(!lCheck6,lChkTds := .F.,),GeraTela(oScr)}   
      
   oCheck6 := TCheckBox():New(51,01,'RAt',{||lCheck6},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck6:bLClicked := {||lCheck6 := !lCheck6, If(!lCheck6,lChkTds := .F.,),GeraTela(oScr)}   
   
   oCheck7 := TCheckBox():New(61,01,'Capital',{||lCheck7},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck7:bLClicked := {||lCheck7 := !lCheck7, If(!lCheck7,lChkTds := .F.,),GeraTela(oScr)}   
   
   oCheck8 := TCheckBox():New(71,01,'FormatIn',{||lCheck8},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck8:bLClicked := {||lCheck8 := !lCheck8, If(!lCheck8,lChkTds := .F.,),GeraTela(oScr)}   

   oCheck9 := TCheckBox():New(81,01,'QbTexto',{||lCheck9},oDlg,100,210,,,,,,,,.T.,,,)
   oCheck9:bLClicked := {||lCheck9 := !lCheck9, If(!lCheck9,lChkTds := .F.,),GeraTela(oScr)}   

   oChkTds := TCheckBox():New(101,01,'Todos',{||lChkTds},oDlg,100,210,,,,,,,,.T.,,,)
   oChkTds:bLClicked := {||lChkTds := lCheck1 := lCheck2 := lCheck3 := lCheck4 := lCheck5 := lCheck6 := lCheck7 := lCheck8 := lCheck9 := !lChkTds, GeraTela(oScr)}   
   
   oTButton1 := TButton():New( 381, 5, "Sair",oDlg,,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
   oTButton1:bAction  := {||oDlg:End()}
   oTButton1:cToolTip := "Observe que não tem o botão Sair (x) no dialog" + cEOL + "e a tecla 'ESC' não funciona." +;
   						 cEOL + "Bom quando precisa validar alguma coisa na saída."
   
   oScr   := TScrollBox():New(oDlg,00,50,400,550,.T.,.T.,.T.) 
   
ACTIVATE DIALOG oDlg CENTERED ON INIT GeraTela(oScr)

Return               

/*************************************************************************************************************************************************/

Static Function GeraTela(oScr)
      
Local cTexto      := ""
Local nVermelho   := 595191   //vermelho mais vivo que o CLR_RED 
Local nAzul       := 14196776
Local nLin        := 0
Local nAltLin     := 9
Local nEnt        := 4                                                                
   
   oScr:FreeChildren() //Elimina, libera todos os objetos da classe onde este método é chamado. Método da classe TSrvObject.
   
   If lCheck1 
	   cTexto := "Left(cString, nCaracteres): " 
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)   
	   cTexto := 'retorna N caracteres da esquerda." 
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	   
	   cTexto := "Ex: Left('Abcdef', 3) -> " 
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := Left('Abcdef', 3) 
   	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt
   EndIf
   
   If lCheck2 
	   cTexto := "Right(cString, nCaracteres): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'retorna N caracteres da direita.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := "Ex: Right('Abcdef', 2) -> "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := Right('Abcdef', 2)
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt
   EndIf
   
   If lCheck3 
	   cTexto := "Stuff(cString, nPosicao, nSubstituir, cTexto): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'substitui e incrementa caracteres para dentro de uma string.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: Stuff("ABCDE", 3, 2, "123") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := Stuff("ABCDE", 3, 2, "123")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt
   EndIf
   
   If lCheck4 
	   cTexto := "PadC(cString, nTamanho, cCaracter): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'Inclui o caracter na direita e na esquerda da string, até o tamanho especificado.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: PadC("ABC", 10, "*") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := PadC("ABC", 10, "*")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt  
   EndIf
   
   If lCheck5 
	   cTexto := "At(cProcura, cString, nApos): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'retorna a posição da primeira ocorrencia de cProcura em cString, após a posicao nApos.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	   cTexto := 'Se nApos for omitido, procura desde o inicio.'
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: At("L", "PORTELLA") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := At("L", "PORTELLA")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt
   EndIf
   
   If lCheck6 
	   cTexto := "RAt(cProcura, cString): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'retorna a posição da última ocorrencia de cProcura em cString.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: RAt("L", "PORTELLA") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := RAt("L", "PORTELLA")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt  
   EndIf
   
   If lCheck7
	   cTexto := "Capital(cString): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'Coloca a primeira letra de cada palavra em maiúsculo.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: Capital("leonardo cordeiro portella") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := Capital("leonardo cordeiro portella")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt  
   EndIf
   
   If lCheck8
	   cTexto := "FormatIn(cTexto,cSeparador,nDelimitador): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'Prepara a string para ser usada com a claúsula IN do SQL, conforme o caracter ou número delimitador.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: FormatIn("Leonardo Cordeiro Portella","o") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := FormatIn("Leonardo Cordeiro Portella","o")
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	   
	   cTexto := '    FormatIn("Leonardo Cordeiro Portella",,9) -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := FormatIn("Leonardo Cordeiro Portella",,9)
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt  
   EndIf

   If lCheck9
	   cTexto := "QbTexto(cTexto,nDelimitador,cSeparador): "
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   	   oSay:SetText(cTexto)   
       nProxCol := len(cTexto)*(3.5)
	   cTexto := 'Separa a string conforme o caracter ou número delimitador.'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	   cTexto := 'Retorna um array com cada linha conforme delimitador. Retorno já com AllTrim(aTexto[i])'
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin
	     
	   cTexto := 'Ex: aTexto := qbTexto("Leonardo Cordeiro Portella",9,"") -> '
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,,,400,900)
   	   oSay:SetText(cTexto)   
	   nProxCol := len(cTexto)*(3.5)
	   cTexto := "aTexto[1]->'Leonardo'; aTexto[2]->'Cordeiro'; aTexto[3]->'Portella'"
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
   	   oSay:SetText(cTexto)   
	   nLin += nAltLin + nEnt  
   EndIf
		
Return   

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Painel()  

Local cTit      := "Painéis - Obs: não tem o botão Sair (x) no dialog e a tecla 'ESC' não funciona."

//Pixel Style DS_MODALFRAME - remover o botão sair/cancelar do dialog
DEFINE DIALOG oDlg TITLE cTit FROM 0,0 TO 200,400 PIXEL Style DS_MODALFRAME 
  
   oDlg:lEscClose  := .F. //cancela o sair pela tecla 'ESC'
   
   oPanel1   := TPanel():New(0,0," Painel 01 ",oDlg,,,,,CLR_YELLOW,100,80)
   oPanel2   := TPanel():New(0,0," Painel 02 ",oDlg,,,,,CLR_HRED,100,80)
   oTButton1 := TButton():New( 0, 0, "Sair",oDlg ,{||oDlg:End()      },40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
   oTButton1:cToolTip := "Observe que não tem o botão Sair (x) no dialog" + cEOL + "e a tecla 'ESC' não funciona." +;
   						 cEOL + "Bom quando precisa validar alguma coisa na saída."
                                              
   //Agrupa objetos de tipos diferentes
   oTbx   := tToolBox():New(01,01,oDlg,40,100)
   
   oTbx:AddGroup( oPanel1  , 'TPanel 1', )
   oTbx:AddGroup( oPanel2  , 'TPanel 2', )  
   oTbx:AddGroup( oTButton1, 'Sair'    , ) 
   
   oTbx:SetCurrentGroup( oPanel1 )
	                   
ACTIVATE DIALOG oDlg CENTERED

Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Timer()

Local nSegundos  := 1 // Disparo será de 1 em 1 segundo  
Local cTexto     := "TESTE"   
Local lHide      := .T.
Local nInc       := 0
Local nMaxInc    := 45
Local cCaractInc := "*"

DEFINE DIALOG oDlg TITLE "TTimer" FROM 0,0 TO 100,200 PIXEL
   
   oSay1   := TSay():New(05,05,,oDlg,,,,,,.T.,CLR_HRED,,40,90)
   oSay1:SetText(cTexto)  
   
   oSay2   := TSay():New(15,05,,oDlg,,,,,,.T.,CLR_HGREEN,,40,90)
   oSay2:SetText(time()) 
   
   oSay3   := TSay():New(25,05,,oDlg,,,,,,.T.,CLR_HBLUE,,200,90)
   oSay3:SetText(Replicate(cCaractInc,nInc))   
	   
   oTimer := TTimer():New(nSegundos,, oDlg )
   oTimer:bAction := {|| If(lHide, oSay1:Hide(), oSay1:Show()),;
   						 lHide := !lHide,;
   						 oSay2:SetText(time()),;
   						 If(++nInc > nMaxInc, nInc := 0,),;
   						 oSay3:SetText(Replicate(cCaractInc,nInc))}
   						 
   oTimer:lActive := .t.
   oTimer:Activate()
	
ACTIVATE DIALOG oDlg CENTERED 

Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function SemBorda()


//STYLE nOR(WS_VISIBLE,WS_POPUP) - remove as bordas do Dialog
DEFINE DIALOG oDlg TITLE "" FROM 0,0 TO 150,400 PIXEL STYLE nOR(WS_VISIBLE,WS_POPUP)
   
   oDlg:SetColor(CLR_HBLUE, CLR_BLACK)
     
   oSay   := TSay():New(05,05,,oDlg,,,,,,.T.,,,200,90)
   oSay:SetText("STYLE nOR(WS_VISIBLE,WS_POPUP) - remove as bordas do Dialog" + cEOL + cEOL + ;
   				"CONTROL_ALIGN_ALLCLIENT  - Alinha preenchendo todo o conteúdo da Janela ou Painel onde estiver" + cEOL + ;
   				"CONTROL_ALIGN_TOP - Alinha ao Topo" + cEOL + ; 
   				"CONTROL_ALIGN_BOTTOM - Alinha ao Rodapé" + cEOL + ; 
   				"CONTROL_ALIGN_LEFT - Alinha à Esquerda" + cEOL + ; 
   				"CONTROL_ALIGN_RIGHT - Alinha à Direita")
   				   
   oSay:align := CONTROL_ALIGN_TOP    
 
   oTButton1 := TButton():New( 20, 05, "Sair",oDlg ,{||oDlg:End() },40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
   oTButton1:cToolTip := "Sair"  
   oTButton1:align := CONTROL_ALIGN_BOTTOM
   
ACTIVATE DIALOG oDlg CENTERED 

Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function ProcX()

Local aSays :={}
Local aButtons:={}
Local nOpca := 0

// Botões que serão monitorados
ProcLogIni( aButtons )

AADD(aSays, 'O FormBatch pode ser usado como uma tela de aviso/mensagem, ou')
AADD(aSays, 'pode funcionar como uma tela de logs/monitoramento em conjunto')
AADD(aSays, 'com as funções ProcLogIni() e ProcLogAtu()')
AADD(aSays, '')
AADD(aSays, 'Obs: O log só é atualizado quando fecha a tela (execute novamente')
AADD(aSays, 'para visualizar o log)')

AADD(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
AADD(aButtons, { 2,.T.,{|| FechaBatch() }} )
 
FormBatch( 'FormBatch', aSays, aButtons,, 230, 400 )

If nOpca == 1                   

	 ProcLogAtu('INICIO')
	 ProcLogAtu('ERRO','Erro no processamento','Texto do erro')
	 ProcLogAtu('CANCEL','Cancelado pelo usuario')
	 ProcLogAtu('FIM')
	
EndIf

Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

Static Function Expande(oDlg,lExpande)

oDlg:CoorsUpdate()

If lExpande == .T.
	//se a opcao for .T. aumenta a janela
	oDlg:Move(oDlg:nTop+8,oDlg:nLeft,650,407)
Else
	//se a opcao for diferente de .T., volta ao normal
	oDlg:Move(oDlg:nTop+8,oDlg:nLeft,500,407)
Endif

Return 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Relat()

Local cGrpPerg      := "TESTEREL"
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := ""
Local imprime       := .T.
Local aOrd          := {}
Private nLin        := 80
Private Cabec1      := ""
Private Cabec2      := ""
Private Titulo      := ""
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "P"
Private nomeprog    := "NOME" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "TESTEREL" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cEOL        := chr(13)+chr(10)
Private aExcel      := {} 
Private oProcess    := Nil  

If !u_lProtheus()
     return
EndIf

Pergs(cGrpPerg)  
Pergunte(cGrpPerg, .F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint("",NomeProg,cGrpPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho)

If nLastKey == 27    
	Return
Endif

SetDefault(aReturn,"")

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

oProcess := MsNewProcess():New({|lFim|GeraRelat(@lFim, oProcess) },"TOTVS","",.T.)
oProcess:Activate()
   
Return

/*************************************************************************************************************************************************/

Static Function GeraRelat(lFim, oObj)

Local c_Alias := GetNextAlias()

cQry := "SELECT A1_COD, A1_NOME" + cEOL
cQry += "FROM " + RetSqlName("SA1") + cEOL
cQry += "WHERE A1_COD BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'" + cEOL 
cQry += "	   AND D_E_L_E_T_ = ''" + cEOL
cQry += "ORDER BY A1_COD" 

If Select(c_Alias) > 0
	dbSelectArea(c_Alias)
	dbCloseArea()
EndIf  

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), c_Alias , .F., .T.)  
 
(c_Alias)->(dbGoTop())

nCount := 0
While !(c_Alias)->(EOF()) 
	nCount ++
	(c_Alias)->(dbSkip())
EndDo	 

oObj:SetRegua1(nCount)
oObj:SetRegua2(nCount)

(c_Alias)->(dbGoTop())

aAdd(aExcel , {"SA1"})

While !(c_Alias)->(EOF()) 
	
	If lFim	
		If Select(c_Alias) > 0
			dbSelectArea(c_Alias)
			dbCloseArea()
		EndIf
		
		return  
	EndIf 
	
    If lAbortPrint
       @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
       Exit
    Endif

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Impressao do cabecalho do relatorio. . .                            ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
       Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
       nLin := 6
    Endif
    
    @nLin,00 PSAY substr((c_Alias)->(A1_NOME),1,60)
    @nLin,65 PSAY (c_Alias)->(A1_COD) 
    
    aAdd(aExcel , {(c_Alias)->(A1_NOME), (c_Alias)->(A1_COD)})

    nLin++ // Avanca a linha de impressao

	oObj:IncRegua1("Coletando informações - "+ (c_Alias)->(A1_COD))
	oObj:IncRegua2("Processando")
	
	(c_Alias)->(dbSkip())

EndDo                                

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

nOpca := Aviso("TOTVS", "Deseja exportar este relatório" + cEOL + "para Excel?",{"Sim","Não"})
     
If nOpca == 1
     If !ApOleClient("MSExcel")
	    MsgAlert("Microsoft Excel não instalado!")
	    Return
     EndIf 
     
     DlgToExcel({{"ARRAY","",{"Título"},aExcel}})
     
EndIf

Return 

/*************************************************************************************************************************************************/

Static Function Pergs(cGrpPerg)
Local aHelp     := {}
Local aGetArea  := GetArea()

aAdd( aHelp, 'Informe o código inicial' )
PutSx1( cGrpPerg,"01","Código inicial","","","mv_ch1","C",;
	TamSX3("A1_COD")[1],0,0,"G","","","","","mv_par01","",;
	"","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp     := {}
aAdd( aHelp, 'Informe o código final' )
PutSx1( cGrpPerg,"02","Código final","","","mv_ch2","C",;
	TamSX3("A1_COD")[1],0,0,"G","!empty(mv_par02)","","","","mv_par02","",;
	"","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
	
RestArea( aGetArea )

Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Arvore() 

     Local cBmp1 := 'PMSEDT3'
     Local cBmp2 := 'PMSDOC'
     Private cCadastro := 'Pc do Leo'
     Private oDlg2
     Private oDbTree 
     
     If !u_lProtheus()
          return
     EndIf
     
     Define MsDialog oDlg2 Title cCadastro From 0,0 to 240,500 Pixel
     oDbTree := dbTree():New(10,10,95,240,oDlg2,{|| MsgAlert("Botão esquerdo","Click")},{||MsgInfo("Botão direito","click")},.T.,.F.)
             oDbTree:AddTree('Pentium D'+Space(24),.T.,cBmp1,cBmp1,,,"1.0")
                    oDbTree:AddTreeItem("Gabinete",cBmp2,,"1.1")
                    oDbTree:AddTreeItem("Monitor",cBmp2,,"1.2")
             oDbTree:AddTree("Placa Mãe",.T.,cBmp1,cBmp1,,,"2.0")
                    oDbTree:AddTreeItem("Processador",cBmp2,,"2.1")
                    oDbTree:AddTreeItem("Memória",cBmp2,,"2.2")
             
             oDbTree:EndTree()
     ODbTree:EndTree()                        
     
     Define SButton from 100,200 type 1 action oDlg2:End() enable of oDlg2
     
     Activate MsDialog oDlg2 Center

Return 
  
*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Funcoes()         

Local cTit       := "Funções: Padrões e RPO"
Local aFuncCust
Local aFuncOrd   := {}  
Local nList      := 1 
Private aFuncPad := __FunArr() 
Private lUser    := .F.  
Private aType // Para retornar a origem da função: FULL, USER, PARTNER, PATCH, TEMPLATE ou NONE
Private aFile // Para retornar o nome do arquivo onde foi declarada a função
Private aLine // Para retornar o número da linha no arquivo onde foi declarada a função
Private aDate // Para retornar a data do código fonte compilado
Private cNomeFont := "Arial"        
Private nTamFont  := 15
Private oFont     := TFont():New(cNomeFont,,nTamFont,,.T.)//Courier New é fonte monoespaçada  
Private cPesquisa := "PESQUISAR..."
Private cTGet     := PadR(cPesquisa,50," ")
                                   
aFuncCust := getFuncArray("U_*", aType, aFile, aLine, aDate) //sem filtro são + ou - 60.000 funções               

aSort(aFuncPad,,,{|x,y| Upper(x[1]) < Upper(y[1])}) 

aFuncOrd := FilLBox()
  
//Pixel Style DS_MODALFRAME - remover o botão sair/cancelar do dialog
DEFINE DIALOG oDlg TITLE cTit FROM 0,0 TO 400,600 PIXEL Style DS_MODALFRAME 
   
   oDlg:lEscClose  := .F. //cancela o sair pela tecla 'ESC'
   
   oTButton1 := TButton():New( 181, 5, "Sair",oDlg,,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
   oTButton1:bAction  := {||oDlg:End()}
   oTButton1:cToolTip := "Observe que não tem o botão Sair (x) no dialog" + chr(13) + chr(10) + "e a tecla 'ESC' não funciona." +;
   						 chr(13) + chr(10) + "Bom quando precisa validar alguma coisa na saída."
   
   oScr   := TScrollBox():New(oDlg,00,90,202,210,.T.,.T.,.T.)  
   
   @ 20,05 MSGET oTGet VAR cTGet PICTURE "@!" SIZE 80,08 PIXEL OF oDlg 
   oTGet:bLostFocus := {||aFuncOrd := FilLBox(cTGet),oList1:SetArray(aFuncOrd)}//bloco executado quando perde o foco
   
   aItens  := {"Padrão", "RPO"}
   cCombo1 := aItens[1]
   oCombo1 := TComboBox():New(05,05,{|u|if(PCount()>0,(cCombo1:=u,If(cCombo1==aItens[1]				,;
    																(									;
	    																CursorWait()					,;
	    																lUser 		:= .F.				,;
	    																aFuncOrd 	:= FilLBox(cTGet)	,;
	    																oList1:SetArray(aFuncOrd)		,;
	    																/*oTGet:Enable(),*/				;
	    																CursorArrow()					;
    																)									,;
    																(									;
	    																CursorWait()					,;
	    																oScr:FreeChildren()				,;
	    																lUser 	:= .T.					,;
	    																nList	:=1						,;
	    																If(!empty(cTGet) .and. cTGet != cPesquisa,;
	    																	aFuncCust := getFuncArray("*" + allTrim(cTGet) + "*", aType, aFile, aLine, aDate),;
	    																	(cTGet := "U_",aFuncCust := getFuncArray("*" + cTGet + "*", aType, aFile, aLine, aDate))),;
	    																oList1:SetArray(aFuncCust)		,;
	    																/*oTGet:Disable(),*/			;
	    																CursorArrow()))					;
    																)									,;
    																cCombo1)},aItens,80,20,oDlg,,{|| },,,,.T.,,,,,,,,,'cCombo1')
    
   oList1 := TListBox():New(35,05,{|u|if(Pcount()>0,(nList:=u,GeraFunc(oScr,If(cCombo1==aItens[1],aFuncOrd,aFuncCust),nList)),nList)},If(cCombo1==aItens[1],aFuncOrd,aFuncCust),80,130,,oDlg,,,,.T.) 
   
ACTIVATE DIALOG oDlg CENTERED ON INIT GeraFunc(oScr, aFuncOrd, 1)

Return          

/*************************************************************************************************************************************************/

Static Function FilLBox(cFilPadrao)

Local i := 0

Local lFilPadrao   := .F.
Local aFuncOrd     := {}

Default cFilPadrao := "" 

cFilPadrao := allTrim(cFilPadrao)

If !empty(cFilPadrao) .and. cFilPadrao != cPesquisa
     lFilPadrao := .T.                     
Else 
	cTGet := PadR(cPesquisa,50," ")
EndIf

For i := 1 to len(aFuncPad)
	If lFilPadrao
		If at(upper(cFilPadrao), upper(aFuncPad[i][1])) > 0
			aAdd(aFuncOrd, aFuncPad[i][1])
		EndIf
	Else
		aAdd(aFuncOrd, aFuncPad[i][1])
	EndIf	
Next  

If empty(aFuncOrd)
    aAdd(aFuncOrd," ")
EndIf

Return aFuncOrd                                    

/*************************************************************************************************************************************************/

Static Function GeraFunc(oScr, aFuncoes, nList)
      
Local i := 0
Local j := 0
      
Local cTexto      := ""
Local nVermelho   := 595191   //vermelho mais vivo que o CLR_RED 
Local nAzul       := 14196776
Local nLin        := 0
Local nAltLin     := 9
Local nEnt        := 4  

If len(aFuncoes) > 0

   If nList == 0
       nList := 1
   EndIf
  
   oScr:FreeChildren() //Elimina, libera todos os objetos da classe onde este método é chamado. Método da classe TSrvObject.
   
   cTexto := aFuncoes[nList]
   
   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nAzul,,400,900)
   oSay:SetText(cTexto)    
   nLin += nAltLin + nEnt 
   
   If FindFunction(aFuncoes[nList])
	        
	   If ( nI := aScan(aFuncPad,{|x|x[1] == aFuncoes[nList]}) ) > 0 
	        
       	   cTexto 	:= 'Parâmetros: ' 
		   oSay   	:= TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
			
		   cTexto 	:= allTrim(aFuncPad[nI][2])
		   cBuffer	:= '('
		   
		   For i := 1 to len(cTexto) Step 2
		   		
		   		cTipoPar 	:= Upper(Substr(cTexto,i	,1))
		   		cObrigPar	:= Upper(Substr(cTexto,i+1	,1))
		   		
		   		cCondObrig := "If(cObrigPar == 'R','Obrig.','Opcional')"  
		   		
		   		Do Case
		   		
		   			Case cTipoPar == 'C'
		   				cBuffer += cValToChar((i+1)/2) + '-Caracter[' + &cCondObrig + '], ' 
		   			
		   			Case cTipoPar == 'N'
		   				cBuffer += cValToChar((i+1)/2) + '-Numérico[' + &cCondObrig + '], ' 
		   			
		   			Case cTipoPar == 'A'
		   				cBuffer += cValToChar((i+1)/2) + '-Array[' + &cCondObrig + '], ' 
		   			
		   			Case cTipoPar == 'L'
		   				cBuffer += cValToChar((i+1)/2) + '-Lógico[' + &cCondObrig + '], '  
		   			
		   			Case cTipoPar == 'B'
		   				cBuffer += cValToChar((i+1)/2) + '-Bloco de código[' + &cCondObrig + '], ' 
		   			
		   			Case cTipoPar == 'O'
		   				cBuffer += cValToChar((i+1)/2) + '-Objeto[' + &cCondObrig + '], ' 
		   				
					Case cTipoPar == 'F'
		   				cBuffer += cValToChar((i+1)/2) + '-Função[' + &cCondObrig + '], ' 
		   			
		   			Case cTipoPar == 'D'
		   				cBuffer += cValToChar((i+1)/2) + '-Data[' + &cCondObrig + '], ' 
		   				lVarMem := .T.
		   			
		   			Case cTipoPar == '*'
		   				cBuffer += cValToChar((i+1)/2) + '-Qualquer tipo[' + &cCondObrig + '], ' 
		   			
		   		EndCase
		   		
		   Next                  
		   
		   If len(cBuffer) > 1
			   	cTexto := left(cBuffer,len(cBuffer)-2) + ')'
		   Else
		   		cTexto += 'Não há parâmetros.'
		   EndIf			   		
		   
		   oSay   	:= TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin            
		  
	   EndIf
   
   EndIf	
   
   If lUser 
	   If !empty(aType) .and. !empty(aType[nList])
	   	   cTexto := 'Tipo: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
		   cTexto := aType[nList]
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin 
	   EndIf  
	   
	   If !empty(aFile) .and. !empty(aFile[nList])
	   	   cTexto := 'Arquivo: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
		   cTexto := aFile[nList]
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin 
	   EndIf 
	   
	   If !empty(aLine) .and. !empty(aLine[nList])
	   	   cTexto := 'Linha: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
		   cTexto := aLine[nList]
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin 
	   EndIf 
	   
	   If !empty(aDate) .and. !empty(aDate[nList])  
	   
	       Set Date to British
	       
	   	   cTexto := 'Data da última compilação: ' 
		   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
		   oSay:SetText(cTexto)    
		   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
		   cTexto := aDate[nList]
		   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
		   oSay:SetText(cTexto)   
		   nLin += nAltLin + nEnt 
	   EndIf 
   EndIf
   
   aParam := GetFuncPrm(aFuncoes[nList]) 
   
   For j:=1 to len(aParam)
   	   cTexto := 'Parâmetro: ' 
	   oSay   := TSay():New(nLin,01,,oScr,,oFont,,,,.T.,nVermelho,,400,900)
	   oSay:SetText(cTexto)    
	   nProxCol := ProxColLinPix(cTexto, cNomeFont)[2]
	   cTexto := aParam[j]
	   oSay   := TSay():New(nLin,nProxCol,,oScr,,oFont,,,,.T.,,,400,900)
	   oSay:SetText(cTexto)   
	   nLin += nAltLin  
   Next

EndIf
    
Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Grafico()

    
Local cNomeArq := "Exemplo.bmp"
Local cDestino := "\web\"
Local nCont := 0

DEFINE MSDIALOG oDlg2 TITLE "Pizza" FROM 0,0 TO 250,330 PIXEL

	@ 001,001 MSGRAPHIC oGraphic SIZE 120,120 OF oDlg2

    oGraphic:SetTitle("Gráfico do Leo",DtoC(Date()),CLR_BLACK, A_LEFTJUST, GRP_TITLE)
    oGraphic:SetMargins(2,6,6,6)
    oGraphic:SetGradient(GDBOTTOMTOP, CLR_HGRAY, CLR_WHITE)
    oGraphic:SetLegenProp(GRP_SCRRIGHT, CLR_HGRAY, GRP_AUTO, .T.)
    
    nSerie := oGraphic:CreateSerie( 10 )
    oGraphic:lAxisVisib := .T.  //mostra os eixos
    
    //Itens do gráfico
    oGraphic:Add(nSerie, 200, "Item 1", Cor(nCont++))
    oGraphic:Add(nSerie, 180, "Item 2", Cor(nCont++))
    oGraphic:Add(nSerie, 210, "Item 3", Cor(nCont++))
    oGraphic:Add(nSerie, 110, "Item 4", Cor(nCont++))
    oGraphic:Add(nSerie, 100, "Item 5", Cor(nCont++))
    
    @001, 124 BUTTON "Salva gráfico" SIZE 40, 14 OF oDlg2 PIXEL ACTION;
    {||oGraphic:SaveToBMP(cNomeArq,"\web\"),MsgInfo("Arquivo salvo com o nome " + cNomeArq +;
    					 " na pasta " + getClientDir() + substr(cDestino,2,len(cDestino)))}
    					 
    @020, 124 BUTTON "+ Zoom"       SIZE 40, 14 OF oDlg2 PIXEL ACTION;
    oGraphic:ZoomIn()
    @040, 124 BUTTON "- Zoom"      SIZE 40, 14 OF oDlg2 PIXEL ACTION;
    oGraphic:ZoomOut()
    @060, 124 BUTTON "Deleta série"  SIZE 40, 14 OF oDlg2 PIXEL ACTION;
    oGraphic:DelSerie(nSerie)
       
ACTIVATE MSDIALOG oDlg2 CENTERED
    
Return

/*************************************************************************************************************************************************/

Static Function Cor(nI)
	ni := ((255*255*255)/5)*nI
Return (nI)     

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function TriColor(lCenter)
    
Local oDlg2, oColorT, oButton, nCor := 0
Default lCenter := .T.

	 Define MsDialog oDlg2 From 70,500 to 320,815 Pixel Title 'Leo - Cores'
     
     oColorT := tColorTriangle():Create(oDlg2)
     oColorT:SetColorIni(0)  
     oColorT:SetSizeTriangle(130,130)
                                 
     If lCenter
        oButton := tButton():New(90,50,'Ok',oDlg2,{||nCor := oColorT:RetColor(),oDlg2:End()},50,15,,,,.T.)
     	Activate MsDialog oDlg2 Centered
     Else                      
     	oButton := tButton():New(90,50,'Ok',oDlg2,{||nCor := oColorT:RetColor(),oDlg2:End(),Alert(nCor)},50,15,,,,.T.)
        Activate MsDialog oDlg2
     EndIf
   
Return nCor

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function CalenGrid() //calendário com grid/régua 

Local oDlg2    
     
     Define Msdialog oDlg2 from 0,0 To 200,800 Pixel Title 'Grid Leo'
     
     nResolution:= 10
     oMsCalendGrid := MsCalendGrid():New( oDlg2, 01, 01, 500,300, date(), nResolution,;
      ,{|| MsgAlert("Clique com botão esquerdo") }, RGB(255,255,196),{|| MsgInfo("Clique com botão direito")}, .T.) 
      
     //oMsCalendGrid:SetTimeUnit(1)//Dias 
     
      //|x,y|MsgAlert(x) retorna o x clicado
            
     oMsCalendGrid:Add('Item 1', 1, 10, 20, RGB(255,0,0)    , '1 - help')
     oMsCalendGrid:Add('Item 2', 2, 20, 30, RGB(255,255,0)  , '2 - help')
     oMsCalendGrid:Add('Item 3', 3, 01, 05, RGB(255,0,255)  , '3 - help') 
     oMsCalendGrid:Add('Item 4', 4, 25, 40, RGB(255,255,255), '4 - help')  
     oMsCalendGrid:Add('Item 5', 5, 15, 30, RGB(0,0,0)      , '5 - help')
     
     Activate MsDialog oDlg2 Centered 
     
Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
  
User Function Calendario() 

Private dPrim, dSeg, cTexto, lControle := .F.

Define MsDialog oDlg From 0,0 To 160,280 Pixel Title "Calendario do Leo"
    
    Set Date Brit
	
	oCalend := MsCalend():New(01,01,oDlg,.T.)
	//Mudança do dia
	
	oCalend:bChange := {||PassaData()} 
	
	//mudança de mês                           
	oCalend:bChangeMes := {||MsgAlert("Mes alterado! ")}
	
Activate MsDialog oDlg Centered

Return

/*************************************************************************************************************************************************/

Static Function PassaData() 
	If lControle == .F.
    	dPrim := oCalend:dDiaAtu
    	lControle := .T. 
    ElseIf lControle == .T.
    	dSeg := oCalend:dDiaAtu
    	MsgAlert("Diferença das datas = " + cValtoChar(abs(dSeg-dPrim)) + " dia(s)")          
    EndIf 	
Return	

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
 
User Function FuncsWin()

Local msg1 := "WinExec - executa um programa do Windows. Pode executar quantas vezes quiser."
Local msg2 := "WaitRun - executa um programa do Windows." + cEOL + "Não pode executar quantas vezes quiser." + cEOL 

msg2 += "É necessário esperar até que o programa chamado termine sua execução." + cEOL 
msg2 += "Experimente tentar abrir este dialog enquanto o programa chamado está em execução.

Define MsDialog oDlg2 Title "Funções de execução do Windows" From 0,0 to 35,315 Pixel
                          
    @ 05,010 BUTTON "WinExec" SIZE 40,10 PIXEL ACTION {||MsgInfo(msg1),WinExec(getenv("programfiles")+"\Microsoft Office\Office12\Excel.exe")} OF oDlg2
    @ 05,060 BUTTON "WaitRun" SIZE 40,10 PIXEL ACTION {||MsgInfo(msg2),WaitRun(getenv("programfiles")+"\Microsoft Office\Office12\Excel.exe")} OF oDlg2
    @ 05,110 BUTTON "Sair"    SIZE 40,10 PIXEL ACTION  oDlg2:End() OF oDlg2
     
Activate MsDialog oDlg2 Center

Return     

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
 
User Function PontMouse()

Local msg1 := "Ponteiro do mouse como espera"
Local msg2 := "Ponteiro do mouse como seta"

Define MsDialog oDlg2 Title "Ponteiro do mouse - Windows" From 0,0 to 35,315 Pixel
                          
    @ 05,010 BUTTON "Espera" SIZE 40,10 PIXEL ACTION {||MsgInfo(msg1),CursorWait()}  OF oDlg2
    @ 05,060 BUTTON "Seta"   SIZE 40,10 PIXEL ACTION {||MsgInfo(msg2),CursorArrow()} OF oDlg2
    @ 05,110 BUTTON "Sair"    SIZE 40,10 PIXEL ACTION  oDlg2:End() OF oDlg2
     
Activate MsDialog oDlg2 Center

Return       

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function ExibeArray(aArray, cTitulo)

Define MsDialog oDlg2 Title cTitulo From 0,0 to 280,235 Pixel
    
    nList := 1
                     
    oList1 := TListBox():New(010,010,{|u|if(Pcount()>0,nList:=u,nList)},;
                             aArray,100,100,,oDlg2,,,,.T.)    
                             
                                 
    @ 115,40 BUTTON "Exibe texto"   SIZE 40,10 PIXEL ACTION MsgInfo(oList1:GetSelText()) OF oDlg2
    @ 130,40 BUTTON "Sair"          SIZE 40,10 PIXEL ACTION oDlg2:End() OF oDlg2  
     
Activate MsDialog oDlg2 Center

Return       

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
                           
User Function XMenu()

  DEFINE DIALOG oDlg TITLE "Menus" FROM 180,180 TO 215,515 PIXEL
	  
  	@ 05,005 BUTTON "TMenuBar"    	SIZE 40,10 PIXEL ACTION u_TMenuBar()  OF oDlg
	@ 05,065 BUTTON "TMenu"       	SIZE 40,10 PIXEL ACTION u_TMenu()     OF oDlg
	@ 05,125 BUTTON "DuploMark"		SIZE 40,10 PIXEL ACTION u_DuploMark() OF oDlg		
	
  ACTIVATE DIALOG oDlg CENTERED 

Return

/*************************************************************************************************************************************************/

User Function TMenuBar()

  DEFINE DIALOG oDlg TITLE "TMenuBar" FROM 180,180 TO 550,700 PIXEL
	
    // Monta um Menu Suspenso
    oTMenuBar := TMenuBar():New(oDlg)
    oTMenu1 := TMenu():New(0,0,0,0,.T.,,oDlg)
    oTMenu2 := TMenu():New(0,0,0,0,.T.,,oDlg)
    oTMenuBar:AddItem('Arquivo'  , oTMenu1, .T.)
    oTMenuBar:AddItem('Relatorio', oTMenu2, .T.)

    // Cria Itens do Menu
    oTMenuItem := TMenuItem():New(oDlg,'TMenuItem 01',,,,;
                     {||Alert('TMenuItem 01')},,'AVGLBPAR1',,,,,,,.T.)  //AVGLBPAR1 => medalha no nome do arquivo
    oTMenu1:Add(oTMenuItem)
    oTMenu2:Add(oTMenuItem)
    oTMenuItem := TMenuItem():New(oDlg,'TMenuItem 02',,,,;
                        {||Alert('TMenuItem 02')},,,,,,,,,.T.)
    oTMenu1:Add(oTMenuItem)
    oTMenu2:Add(oTMenuItem)         

  ACTIVATE DIALOG oDlg CENTERED 

Return

/*************************************************************************************************************************************************/

User Function TMenu()  

  DEFINE DIALOG oDlg TITLE "TMenu" FROM 180,180 TO 550,700 PIXEL

    oMenuMain := TMenu():New( 0,0,0,0,.F.,'',oDlg,CLR_WHITE,CLR_BLACK)
    // Adiciona item ao menu principal
    oMenuDiv := TMenuItem():New2( oMenuMain:Owner(),'Item 001','',,,)
    oMenuMain:Add( oMenuDiv )                          

    // Adiciona sub-Itens             
    oMenuItem1 := TMenuItem():New2( oMenuMain:Owner(),'Sub-Item 001';
                  ,,,{||Alert('TMenuItem 1')})
    oMenuDiv:Add( oMenuItem1 )                          
    oMenuItem2 := TMenuItem():New2( oMenuMain:Owner(),'Sub-Item 002';
                  ,,,{||Alert('TMenuItem 2')})
    oMenuDiv:Add( oMenuItem2 )   

  ACTIVATE DIALOG oDlg CENTERED 
  
Return 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function TCBrowse()                     

Local oOK   := LoadBitmap(GetResources(),'br_verde')
Local oNO   := LoadBitmap(GetResources(),'br_vermelho')
Local aList := {}    

  DEFINE DIALOG oDlg TITLE "TCBrowse" FROM 180,180 TO 550,570 PIXEL
	                 
    // Vetor com elementos do Browse
    aBrowse   := {{.T.,'CLIENTE 001','RUA CLIENTE 001',111.11},;
                    {.F.,'CLIENTE 002','RUA CLIENTE 002',222.22},;
                    {.T.,'CLIENTE 003','RUA CLIENTE 003',333.33} }
    // Cria Browse
    oBrowse := TCBrowse():New( 01 , 01, 260, 156,,;
                              {'','Codigo','Nome','Valor'},{20,50,50,50},;
                              oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
    // Seta vetor para a browse                            
    oBrowse:SetArray(aBrowse) 
    
    // Monta a linha a ser exibina no Browse
    oBrowse:bLine := {||{ If(aBrowse[oBrowse:nAt,01],oOK,oNO),;
                          aBrowse[oBrowse:nAt,02],;
                          aBrowse[oBrowse:nAt,03],;
                          Transform(aBrowse[oBrowse:nAT,04],'@E 99,999,999,999.99') } }

    oBrowse:bHeaderClick := {|| alert('Clique cabec') } 
    oBrowse:bLDblClick   := {|| alert('2 cliques') }
    
    // Cria Botoes com metodos básicos
    TButton():New( 160, 002, "Sobe"	, oDlg,{|| oBrowse:GoUp(),;
     oBrowse:setFocus() },40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton ():New(160, 052, "Desce"	, oDlg,{|| oBrowse:GoDown(),;
      oBrowse:setFocus()	},40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 160, 102, "Primeiro"	, oDlg,{|| oBrowse:GoTop(),;
     oBrowse:setFocus() 	},40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 160, 152, "Último", oDlg,{|| oBrowse:GoBottom(),;
     oBrowse:setFocus() },40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 172, 002, "Linha atual", oDlg,{|| alert(oBrowse:nAt) },;
     40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 172, 052, "Nr Linhas", oDlg,{|| alert(oBrowse:nLen)	},;
     40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 172, 102, "Linhas visiveis", oDlg,{|| alert(oBrowse:nRowCount()) },;
     40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    TButton():New( 172, 152, "Alias", oDlg,{|| alert(oBrowse:cAlias) },;
     40,010,,,.F.,.T.,.F.,,.F.,,,.F. )
    
  ACTIVATE DIALOG oDlg CENTERED 

Return 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
                    
User Function DuploMark

Local i := 0

Local lConfirm	:= .F.
Local cLog 		:= ""
Local nOpca		:= 0     
Local nTam		:= 10
Local cBusca	:= Space(nTam)
Local aCab		:= {" "," ","Dobr.","Codigo","Nome","Login"}
Local aTam		:= {20,20,50,100,50,50}
Local lPalChave	:= .F.  
Local lBuffer	:= .F.

Private aVetBx	:= {}         
Private oDlg 	:= nil
Private oBrowse	:= nil
Private oBrowse2:= nil
Private aVetBx2	:= {}
Private nPos 	:= 0
Private oOk    	:= LoadBitMap(GetResources(),"LBOK")
Private oNo    	:= LoadBitMap(GetResources(),"LBNO")
Private oPaga	:= LoadBitMap(GetResources(),"BR_VERDE")
Private oNaoPag	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private oPagDbr	:= LoadBitMap(GetResources(),"BR_LARANJA")

SetPrvt("oDlg1","oCBox1")

Processa({||aVetBx := RetTST()})

oDlg := MSDialog():New(0,0,510,850,"Seleção de usuários Protheus",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      	:= TGroup():New( 005,010,025,420,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oTBitmap1 	:= TBitmap():New(010,015,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap1:Load("BR_VERDE") 
	
	oSay1      	:= TSay():New( 010,030,{||'Pagamento normal'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	
	oTBitmap2 	:= TBitmap():New(010,100,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap2:Load("BR_VERMELHO") 
	
	oSay2      	:= TSay():New( 010,115,{||'Sem pagamento'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	
	oTBitmap3 	:= TBitmap():New(010,200,260,184,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.) 
	oTBitmap3:Load("BR_LARANJA") 
	
	oSay3      	:= TSay():New( 010,215,{||'Pagamento dobrado'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	    
	oBrowse := TCBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,{|| },,,,,,,.F.,,.T.,,.F.,,, )
    oBrowse:SetArray(aVetBx) 
    
    oBrowse:bLDblClick := {||AjustCels()}//lEditCell(aVetBx,oBrowse,,oBrowse:nColPos)
    
    oBrowse:bLine := {||{If(aVetBx[oBrowse:nAt,2] .and. aVetBx[oBrowse:nAt,3],oPagDbr,If(aVetBx[oBrowse:nAt,2],oPaga,oNaoPag)),;
    					If(aVetBx[oBrowse:nAt,2],oOk,oNo)	,;
						If(aVetBx[oBrowse:nAt,3],oOk,oNo)	,;
						aVetBx[oBrowse:nAt,4]  				,;
						aVetBx[oBrowse:nAt,5] 			   	,;
						aVetBx[oBrowse:nAt,6]				,;
						}} 

  	oSBtn1     := SButton():New(230,365,1,{||lConfirm := .T.,oDlg:End()}	,oDlg,,"", )
	oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}					,oDlg,,"", )

oDlg:Activate(,,,.T.)	  

If lConfirm 
	
	For i := 1 to len(aVetBx)
		If aVetBx[i][1]
		     cLog += aVetBx[i][2] + ';'
		EndIf                  
	Next                               
	
	cLog := left(cLog,len(cLog)-1)

EndIf

Return cLog                              

*********************************************************************************************************

Static Function RetTST

Local i := 0
      
Local aRet 		:= {}
Local aUsers	:= {}
Local nQtd 		:= 0
Local nCont		:= 0
Local cTot 		:= ""

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros...')
Next

nQtd 	:= 20

cTot 	:= cValToChar(nQtd)

ProcRegua(nQtd)

For i := 1 to nQtd 

    IncProc('Usuário ' + cValToChar(++nCont) + ' de ' + cTot)

    aAdd(aRet,{'',.T.,.F.,'0001','200620445611','123456'})

Next

Return aRet

*********************************************************************************************************

Static Function AjustCels
      
If oBrowse:nColPos == 2 

	aVetBx[oBrowse:nAt,2] := !aVetBx[oBrowse:nAt,2] 
	
	If !aVetBx[oBrowse:nAt,2]
		aVetBx[oBrowse:nAt,3] := .F.
	EndIf  
	
ElseIf oBrowse:nColPos == 3 .and. aVetBx[oBrowse:nAt,2] 

	aVetBx[oBrowse:nAt,3] := !aVetBx[oBrowse:nAt,3]
	
EndIf

Return

********************************************************************************************************

User Function testeMsgRun()  

Local aFont := u_EditFont()  

DEFINE DIALOG oDlg TITLE "MsgRun" FROM 300,400 TO 400,650 PIXEL
            
   oScr  := TScrollBox():New(oDlg,01,01,50,125,.T.,.T.,.T.)
     
   oFont := TFont():New(aFont[2],,aFont[1],.T.)
   
   oSay  := TSay():New(01,01,{||'Não interrompe o processamento'},oScr,,oFont,,,,.T.,aFont[3],CLR_WHITE,200,20)

ACTIVATE DIALOG oDlg  

Return  

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Dialogo()

Local oDlg 
Local cNome 
Local aFontes := GetFontList()
Local cFonte  := 'Courier new' 
Local nFonte  := -18 
Local oFont   := TFont():New(cFonte,,nFonte,.T.)
Local nCor    := CLR_RED 
Local oSay    := Nil
Local oDlg    := Nil
Local oButton := Nil 
Local aFont	  := {nFonte,cFonte,nCor}	

bFont := {|| If(!empty(aFont), 	(cLog := 'Nome da fonte: ' + allTrim(aFont[2]) 			+ CRLF +;
									'Tamanho da fonte: ' + cValToChar(abs(aFont[1])) 			+ CRLF +;
									'Cor da fonte: ' + cValToChar(aFont[3])	+ CRLF, LogErros(cLog,'EditFont',.F.)),) }

Define MsDialog oDlg Title "Leonardo" from 0,0 to 230,300 of oDlg Pixel 

	@ 05,05  to 60, 145 LABEL "Edição de Texto" of oDlg Pixel
      
	oSay    := TSay():New(15,10,{||'Exemplo!!!'},oDlg,,oFont,,,,.T.,nCor,CLR_WHITE,200,200)    
	oButton := tButton():New(70,50,'EditFont',oDlg,{||aFont := u_EditFont(),;
	           oFont := TFont():New(aFont[2],,aFont[1],.T.),;
			   oSay:SetFont(oFont),;
			   oSay:SetColor(aFont[3]),;
			   oDlg:Refresh()},;
			   50,15,,,,.T.)
			   
	oButton2 := tButton():New(90,50,'Pega fonte',oDlg,bFont,50,15,,,,.T.)			   
     
Activate MsDialog oDlg Centered

Return  

/*************************************************************************************************************************************************/

*'-----------------------------'*
*'EditFont --------------------'*
*'-----------------------------'*
*'Retorno:                     '*
*'- aEdit                      '*
*'aEdit[1] == tamanho da fonte '*
*'aEdit[2] == nome da fonte    '*
*'aEdit[3] == cor da fonte     '*
*'-----------------------------'*

User Function EditFont()
                                                  
Local nSpinBox := 15
Local aFonte   := GetFontList()
Local oFont    := TFont():New(aFonte[1],,-nSpinBox,.T.)
Local oFont2   := TFont():New("New Courier",,-15,.T.)
Local nCor     := 0
Local aEdit    := {-15, 'Courier new', 1}
Local oDlg     := Nil
Local cFonte   := 'Courier new'

Define MsDialog oDlg2 Title "Fontes" From 0,0 to 280,450 Pixel
    
    nList  := 1
                     
	@ 10,115  to 60, 220 LABEL "Visualização" of oDlg2 Pixel

    oSay   := TSay():New(20,130,{||AllTrim(aFonte[1])},oDlg2,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,90,35)
    
    oList1 := TListBox():New(010,010,{|u|if(Pcount()>0,;
    		  (nList:=u,;
			  oFont := TFont():New(oList1:GetSelText(),,-nSpinBox,.T.),;
    		  oSay:SetFont(oFont),;
			  oSay:SetColor(nCor),;
			  oSay:SetText(AllTrim(oList1:GetSelText())),;
			  oDlg2:Refresh(),;
			  cFonte := oList1:GetSelText()),; 	
			  nList)},; 
			  aFonte,100,100,,oDlg2,,,,.T.)  
	oList1:SetFocus()		  
			  
    oSay2     := TSay():New(65,120,{||'Tamanho'},oDlg2,,oFont2,,,,.T.,0,CLR_WHITE,200,20)
    oSpinBox  := tSpinBox():new(65, 155, oDlg2, {|x| nSpinBox := x}, 30, 13)
    oSpinBox:setRange(-100, 100)
    oSpinBox:setStep(1)//pulo
    oSpinBox:setValue(nSpinBox)  
    
    oSay3     := TSay():New(80,120,{||'Cor'}    ,oDlg2,,oFont2,,,,.T.,0,CLR_WHITE,200,20)
	cTGet3    := cValtoChar(nCor)
    oTGet3    := TGet():New( 80,155,{||cTGet3},oDlg2,030,008,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,cTGet3,,,, )    
    oTButton3 := TButton():New( 80, 185, "?",oDlg2,{||nCor := u_TriColor(),;
    		       cTget3 := cValtoChar(nCor),;
    		       oFont := TFont():New(oList1:GetSelText(),,-nSpinBox,.T.),;
	    		   oSay:SetFont(oFont),;
				   oSay:SetColor(nCor),;
				   oSay:SetText(AllTrim(oList1:GetSelText())),;
				   oDlg2:Refresh()},;
                   10,10,,,.F.,.T.,.F.,,.F.,,,.F. ) 
    
    
    SButton():New( 120,45,01,{||aEdit := {}, aAdd(aEdit,-nSpinBox),aAdd(aEdit,cFonte),aAdd(aEdit,nCor),oDlg2:End()},oDlg,.T.,,)
                                          
Activate MsDialog oDlg2 Center
         
Return aEdit     

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

*'-------------------------------------'*
*'DBF() - Retorna o número da área de  '*
*'trabalho ou "" se não existir        '*
*'-------------------------------------'*

User Function DBF()   
      
If dbf() == ""  
	Alert("Não está no Protheus")
Else 
	MsgInfo("Protheus")
EndIf

Return 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function lProtheus()   

Local lProtheus := .T.
Local cEOL      := chr(13)+chr(10)
                      
If dbf() == ""  

	lOpca := MsgYesNo("Esta função funciona somente quando executada dentro do Protheus!"+cEOL+;
		  			"Deseja continuar?","TOTVS")
	If lOpca == .T.
		lProtheus := .T.
	Else	
		lProtheus := .F.
	EndIf

EndIf

Return lProtheus 

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function TelaAutoAjust() 

cTexto   := "Procure alterar a resolução da tela"
aObjects := {}
aSizeAut := MsAdvSize() 

If !u_lProtheus()
     return
EndIf
/*                      
-------------------------------------
MsAdvSize()                         |
-------------------------------------
1 -> Linha inicial área trabalho.   |
2 -> Coluna inicial área trabalho.  |
3 -> Linha final área trabalho.     |
4 -> Coluna final área trabalho.    |
5 -> Coluna final dialog (janela).  |
6 -> Linha final dialog (janela).   |
7 -> Linha inicial dialog (janela). |
-------------------------------------
*/

AAdd( aObjects, { 100,  100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects, .T. )

oDlg  := MSDialog():New( aSizeAut[7],00,aSizeAut[6],aSizeAut[5],"Tela auto ajustável",,,.F.,,,,,,.T.,,,.T. ) 

oMemo := tMultiGet():New(aPosObj[1][1],aPosObj[1][2],{|u|if(Pcount()>0,cTexto:=u,cTexto)},oDlg,aPosObj[1][4],aPosObj[1][3]-30,,,,,,.T.)

oMemo:EnableVScroll(.T.) 
oMemo:EnableHScroll(.T.)

oSBtn1 := SButton():New( aPosObj[1][3]-12,((aPosObj[1][2]+aPosObj[1][4])/2)-5,1,{||oDlg:End()},oDlg,,"", )

oDlg:Activate(,,,.T.)

Return  

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

Static Function ProxColLinPix(cTexto, cNomeFonte, nTamFonte, lNegrito, lItalico, lSublinhado)  
    
Local i := 0

Local nLargura    := 0 
Local nAltura     := 0
Local aParFont 
Local numMagico   := 3.5

default lNegrito  := lItalico := lSublinhado := .F.         
default nTamFonte := 15

	aParFont := GetFontPixWidths (cTexto, nTamFonte, lNegrito, lItalico, lSublinhado)

	For i := 0 to len(cTexto)  
		 If substr(cTexto,i,1) == " " 
		    nLargura += aParFont[asc("a")]
	     Else
	     	nLargura += aParFont[asc(substr(cTexto,i,1))]
	     EndIf
	Next
	
	nAltura := GetHeightFont (cNomeFonte, nTamFonte, lNegrito, lItalico, lSublinhado) 
	
	aRet := {nAltura, nLargura / numMagico}

Return aRet    

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function Bitmaps()

Local i := 0

Local cBitmap := ''
Local oDlg
Local oBmp 
Local aBmpsNum := {}
Private aBmps  := {"AFASTAME","BPMSDOCI","COLTOT","AFASTAMENTO","BPMSEDT1","CONTAINR","ALT_CAD","BPMSEDT2",;
				   "DBG05","AMARELO","BPMSEDT3","DBG06","ANALITICO","BPMSEDT4","DBG09","ANALITIC","BPMSRELA",;
				   "DBG3","AGENDA","BPMSTASK1","DESTINOS","ALTERA","BPMSTASK2","DESTINOS2","AREA","BPMSTASK3",;
				   "DISABLE","ASIENTOS","BPMSTASK4","DISCAGEM","AUTOM","BR_AMARELO","DOWN","BAIXATIT","BR_AZUL",;
				   "E5","BAR","BR_AZUL_OCEAN","EDITABLE","BMPCALEN","BR_CINZA","EXCLUIR","BMPEMERG","BR_LARANJA",;
				   "FILTRO","BMPGROUP","BR_MARROM","FINAL","BMPINCLUIR","BR_PRETO","FOLDER10","BMPPERG","BR_VERDE",;
				   "FOLDER11","BMPPOST","BR_VERDE_OCEAN","FOLDER12","BMPTABLE","BR_VERMELHO","FOLDER14","BMPTRG",;
				   "BR_VERMELHO_OCEAN","FOLDER5","BMPUSER","BUDGET","FOLDER6","BMPVISUAL","BUDGETY","FOLDER7",;
				   "BONUS","CADEADO","GEOROTA","BOTTOM","CALCULADORA","GRAF2D","BPMSDOC","CANCEL","GRAF3D","BPMSDOCA",;
				   "CHAVE2","HISTORIC","BPMSDOCE","CHECKED","INSTRUME","IMPRESSAO","PCO_ITALT","PMSSETATOP","LBNO",;
				   "PCO_ITEXC","PMSSETAUP","LBOK","PCOCO","PMSTASK1","LBTIK","PCOCUBE","PMSTASK2","LEFT","PCOFXCANCEL",;
				   "PMSTASK3","LINE","PCOFXOK","PMSTASK4","LIQCHECK","PENDENTE","PMSUSER","LJPRECO","PESQUISA","PMSZOOMIN",;
				   "LOCALIZA","PGNEXT","PMSZOOMOUT","LUPA","PGPREV","POSCLI","MAQFOTO","PMSCOLOR","PRECO","MATERIAL",;
				   "PMSEDT3","PREV","METAS_BAIXO_16","PMSEDT4","PRINT03","METAS_BAIXO_LEG","PMSEXCEL","PRODUTO","METAS_CIMA_16",;
				   "PMSEXPALL","RECALC","METAS_CIMA_LEG","PMSEXPCMP","RECORTAR","MSGHIGH","PMSMAIS","RIGHT","MSVISIO","PMSMATE",;
				   "RPMNEW","NEXT","PMSMENOS","RPMSAVE","NOTE","PMSPESQ","S4SB014N","NOVACELULA","PMSPRINT","S4WB001N",;
				   "OBJETIVO","PMSRELA","S4WB005N","OK","PMSRRFSH","S4WB006N","ORDEM","PMSSETABOT","S4WB007N","PARAMETROS",;
				   "PMSSETADIR","S4WB008N","PCO_COINC","PMSSETADOWN","S4WB009N","PCO_CONOR","PMSSETAESQ","S4WB010N",;
				   "S4WB011N","WEB","CARAGANEW","S4WB014B","WFCHK","CARGASEQ","S4WB016N","WFUNCHK","CCTCALC","SALVAR",;
				   "ADDCONTAINER","CHAT","SDUIMPORT","ADICIONAR_001","CHAT1","SDUPACK","ARMAZEM","CHAT2","SDUPROPR","ATALHO",;
				   "CHAT3","SDUSETDEL","AVGARMAZEM","CHECK","SDUSOFTSEEK","AVGBOX1","CHECKOK","SHORTCUTDEL","AVGLBPAR1",;
				   "CLOCK01","SHORTCUTEDIT","AVGOIC1","CLOCK02","SHORTCUTMINUS","AVIAO","CLOCK03","SHORTCUTNEW","AZUL","CLOCK04",;
				   "SHORTCUTPLUS","BALANCA","DEVOLNF","SIMULACA","BGCOLOR","COBROWSR","SIMULACAO","BMPPARAM","COLFORM","SUGESTAO",;
				   "BMPCONS","COMPTITL","SUMARIO","BMPCPO","COMSOM","SVM","BMPDEL","CRITICA","TK_VERTIT","BR_BRANCO","COPYUSER",;
				   "UNCHECKED","BRANCO","CTBLANC","UP","BR_CANCEL","CTBREPLA","USER","BR_MARROM","DBG07","VCDOWN","BR_PINK","DELWEB",;
				   "VCUP","BTCALC","COLOR","VENDEDOR","BTPESQ","DBG12","VERNOTA","CARGA","DBG10","DEPENDENTES","F7_VERM","F14_PINK",;
				   "GEO","F8_NULL","F14_PRET","EDITWEB","F10_AMAR","F14_VERD","EMPILHADEIRA","F10_AZUL","F14_VERM","ENABLE","F10_CINZ",;
				   "FÉRIAS","ESCALA","F10_LARA","FILTRO1","ESTOMOVI","F10_MARR","FOLDER8","F5_AZUL","F10_NULL","FOLDER13","F5_NULL",;
				   "F10_PINK","FOLDER15","F5_VERD","F10_PRET","FORM","F5_VERM","F10_VERD","FRCOLOR","F6_NULL","F10_VERM","FRTOFFLINE",;
				   "F5_AMAR","F11_NULL","FRTONLINE","F5_CINZ","F12_AMAR","GEO","F5_LARA","F12_AZUL","GEOEMAIL","F5_MARR","F12_CINZ","GEOTRECHO",;
				   "F5_PINK","F12_LARA","GERPROJ","F5_PRET","F12_MARR","GLOBO","F7_AMAR","F12_PINK","IC_17","F7_AZUL","F12_PRET","INSTRUME",;
				   "F7_CINZ","F12_VERD","LANDSCAPE","F7_LARA","F12_VERM","LIGHTBLU","F7_MARR","F14_AMAR","MDIHELP","F7_NULL","F14_AZUL",;
				   "MDILOGOFF","F7_PINK","F14_CINZ","MDIRUN","F7_PRET","F14_LARA","MDISPOOL","F7_VERD","F14_MARR","MEDEXT",;
				   "MENURUN","RPMCABEC","SDUFIELDS","MPWIZARD","RPMCPO","SDUFIND","NCO","RPMDES","SDUGOTO","NEWWEB","RPMFORM",;
				   "SDUNEW","NOCONNECT","RPMFUNC","SDUOPEN","NOCHECKED","RPMGROUP","SDUOPENIDX","NOMEDICA","RPMIMP","SDUORDER","NORMAS",;
				   "RPMIMPORT","SDURECALL","OPEN","RPMNEW2","SDUREPL","OPERACAO","RPMOPEN","SDUSEEK","OUTLOOK","RPMPERG","SDUSTRUCT","PAPEL_ESCRITO",;
				   "RPMTABLE","SDUSUM","PEDIDO","S4WB004N","SDUZAP","PIN","S4WB013N","SEMSOM","PMSINFO","S4WB014A","SOLICITA","PREDIO","SALARIOS",;
				   "SSFONTES","PRINT02","SAVECLOCK","TAB1","PROCESSA","SDUADDTBL","TABPRICE","PRODUT2","SDUAPPEND","TEXTBOLD","PROJETPMS","SDUCLOSE",;
				   "TEXTCENTER","PRTETQ","SDUCLOSEIDX","XCLOSE","QMT_COND","SDUCOPYTO","TEXTITALIC","QMT_NO","SDUCOUNT","TEXTJUSTIFY","QMT_OK","SDUCREATEIDX",;
				   "TEXTLEFT","RESPADEX","SDUDELETE","TEXTRIGHT","RESPONSA","SDUDRPTBL","TEXTUNDERLINE","ROSA","SDUERASE","TK_ALTFIN","TK_CLIFIN",;
				   "BPMSEDT3A","GCT_NEW","TK_FIND","BPMSEDT3E","INVOICE1","TK_FONE","BPMSEDT3I","MSGGROUP","TK_HISTORY","BPMSEDT4A","MSGHIGH",;
				   "TK_NOVO","BPMSEDT4E","PCO_COALT","TK_REFRESH","BPMSEDT4I","PCO_COEXC","TPOPAGTO1","BPMSREC","PCO_ITINC","UPDWARNING","BPMSRECA",;
				   "PCOCOLA","UPDERROR","BPMSRECE","PCOCOPY","UPDINFORMATION","BPMSRECI","PCOEDIT","VERDE","BPMSRELAA","PCOFX","VERMELHO","BPMSRELAE",;
				   "PCOLOCK","VERMESCURO","BPMSRELAI","PEDIDO2","WATCH","BPMSTSK1A","PEDIDO2_MDI","CLIENTE","BPMSTSK1E","PGRSAVE","ACAO","BPMSTSK1I",;
				   "PMSAPONT","BOXBOM1","BPMSTSK2A","PMSCANC","BOXBOM2","BPMSTSK2E","PMSCOLUM","BOXBOM3","BPMSTSK2I","PMSCONS","BOXBOM4","BPMSTSK3A",;
				   "PMSCUSTO","BOXBOM5","BPMSTSK3E","PMSDATE","BPMSEDT1A","BPMSTSK3I","PMSESTRU","BPMSEDT1E","BPMSTSK4A","BPMSEDT1I","BPMSTSK4E","PMSEXEC",;
				   "BPMSEDT2A","BPMSTSK4I","PMSEXPEXC","BPMSEDT2E","ENGRENAGEM2","PMSFILTER","BPMSEDT2I","GCT_EDIT","PMSGRAPH","PMSNEXT","MSGFORWD","UNSELECTALL",;
				   "PMSOPCAO","MSGREPLY","BSTART","PMSPESQ","OMSDIVIDE","BTURNSHARPLEFT","PMSPREV","PMSUPDOWN","BTURNSHARPRIGHT","PMSPREVIO","SHAPE01",;
				   "ENGRENAGEM","PMSPRINT","SHAPE02","PAGEDOWN","PMSPROG","SHAPE03","PAGEUP","PMSSUPALOC","SHAPE04","SELECT","PMSTOOLS","SHAPE05","SELECTALL",;
				   "PMSUSERP","TRIDOWN","BBEARRIGHT","REFRESH","WORD","BEND","SHAPE06","ROTEIRO","BKEEPLEFT","TRILEFT","CLIPS_PQ","BKEEPRIGHT",;
				   "TRIRIGHT","NEXT_PQ","BLEFT","VINCULA1","RELACIONAMENTO_DIREIRA_PQ","BRIGHT","BAHEAD","PREV_PQ","CANCEL","BBEARLEFT","UP.GIF",;
				   "CONFIRM","DOWN","GOTOP","INVERTSELECTION","GOBOTTOM"}
                   
DEFINE MSDIALOG oDlg TITLE "Bitmaps" FROM 0,0 TO 400,300 PIXEL Style DS_MODALFRAME 
        
oDlg:lEscClose  := .F. //cancela o sair pela tecla 'ESC'

oTButton1 := TButton():New( 180, 55, "Sair",oDlg,,40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oTButton1:bAction  := {||oDlg:End()}
oTButton1:cToolTip := "Observe que não tem o botão Sair (x) no dialog" + chr(13) + chr(10) + "e a tecla 'ESC' não funciona." +;
  						 chr(13) + chr(10) + "Bom quando precisa validar alguma coisa na saída."
   
@10,70 BITMAP oBmp RESOURCE aBmps[1] SIZE 200,200 OF oDlg PIXEL
oBmp:lAutoSize := .T.
oSay     := TSay():New(10,85,{||aBmps[1]}    ,oDlg,,,,,,.T.,CLR_HRED,CLR_WHITE,200,20)

//retira duplicados, inexistentes e ordena					
aBuffer := {}

For i := 1 to len(aBmps)
	If aScan(aBuffer, aBmps[i]) <= 0 .and. oBmp:SetBmp(aBmps[i])
		aAdd(aBuffer, aBmps[i])
	EndIf
Next

aBmps := aBuffer

aSort(aBmps,,,{|x,y| x < y}) 

cBitmap := aBmps[1]

For i:=1 to len(aBmps)
	aAdd(aBmpsNum, cValtoChar(i) + " - " + aBmps[i])
Next

nList   := 1
bChange := {|u|if(Pcount()>0,;
			(cBitmap := substr(u,at("-",u)+2,len(u)),;
			nList := aScan(aBmps,cBitmap)),;
			nList),;
			GeraBmp(oBmp, oSay, nList);
           }  
oList1 := TListBox():New(05,05,bChange,aBmpsNum,60,150,,oDlg,,,,.T.)
   
ACTIVATE DIALOG oDlg CENTERED ON INIT GeraBmp(oBmp, oSay, nList)
	
Return cBitmap    

/*************************************************************************************************************************************************/

Static Function GeraBmp(oBmp, oSay, nList)

oBmp:SetBmp(aBmps[nList])
oSay:SetText(aBmps[nList])
	   
Return   

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
                                
User Function TSplitter()
 
DEFINE DIALOG oDlg TITLE "TSplitter" FROM 180,180 TO 550,700 PIXEL
	
  oSplitter := tSplitter():New( 01,01,oDlg,260,184 )
  oPanel1:= tPanel():New(322,02," Painel 01",oSplitter,,,,,CLR_YELLOW,60,60)
  oPanel2:= tPanel():New(322,02," Painel 02",oSplitter,,,,,CLR_HRED,60,80)
  oPanel3:= tPanel():New(322,02," Painel 03",oSplitter,,,,,CLR_HGRAY,60,60)
  
ACTIVATE DIALOG oDlg CENTERED
 
Return          

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*
 
User Function TPaintPanel()

DEFINE DIALOG oDlg TITLE "TPaintPanel - drag and drop de um container para outro" FROM 180,180 TO 550,700 PIXEL
    
// Cria o objeto principal
oPanel := TPaintPanel():new(0,0,300,200,oDlg)
    
//--------------------------------------------------------------------------------------------------
// Adiciona Container do tipo Retângulo - Type=1
//--------------------------------------------------------------------------------------------------
oPanel:addShape("id=0;type=1;left=0;top=0;width=270;height=400;"+;
                "gradient=1,0,0,0,0,0.0,#D0CEBC;pen-width=1;"+;
                "pen-color=#ffffff;can-move=0;can-mark=0;is-container=1;")

oPanel:addShape("id=1;type=1;left=272;top=0;width=270;height=400;"+;
                "gradient=1,0,0,0,0,0.0,#B0B7E0;pen-width=1;"+;
                "pen-color=#ffffff;can-move=0;can-mark=0;is-container=1;")

//--------------------------------------------------------------------------------------------------
// Adiciona grafico Pizza - Type=4
//--------------------------------------------------------------------------------------------------
//polygon = distancia da esquerda (coluna) : distancia do topo (linha)(no sentido anti-horário) - polygon=0:0,0:100,30:100,30:0" = retângulo em pé

oPanel:addShape("id=1;type=5;polygon=0:0,0:100,70:100,70:70,30:70,30:0"+;
				";gradient=1,150,150,70,-1,0.2,#000000,0.4,"+;
                "#00ffff,1.0,#000000"+;
                "pen-width=1;pen-color=#ffffff;can-move=1;can-mark=1;is-container=0;")

oPanel:addShape("id=2;type=5;polygon=100:0,100:100,170:100,170:70,130:70,130:65,150:65,150:35,130:35,130:30,170:30,170:0"+;
                ";gradient=1,150,150,70,-1,0.2,#000000,0.4,"+;
                "#ff0000,1.0,#000000"+;
                "pen-width=1;pen-color=#ffffff;can-move=1;can-mark=1;is-container=0;") 

oPanel:addShape("id=3;type=5;polygon=200:0,200:100,270:100,270:30,240:30,240:70,230:70,230:30,270:30,270:0"+;
                ";gradient=1,150,150,70,-1,0.2,#000000,0.4,"+;
                "#00ff00,1.0,#000000"+;
                "pen-width=1;pen-color=#ffffff;can-move=1;can-mark=1;is-container=0;")
                    
oPanel:addShape("id=4;type=4;start-angle=90;sweep-length=200;left=04;"+;
                "top=180;width=100;height=100;gradient=2,050,050,070,-1,0.2,"+;
                "#ffffff,0.8,#67FF67,1.0,#000000;gradient-hover=2,050,050,"+;
                "070,-1,0.2,#ffffff,0.8,#C6FF9F,1.0,#000000;tooltip=Pizza 01;"+;
                "pen-width=1;pen-color=#000000;can-move=1;can-mark=1;is-container=0;")

oPanel:addShape("id=5;type=4;start-angle=290;sweep-length=120;left=04;top=180;"+;
                "width=100;height=100;gradient=2,050,050,070,-1,0.2,#ffffff,0.8,"+;
                "#67FF67,1.0,#000000;gradient-hover=2,050,050,070,-1,0.2,#ffffff,"+;
                "0.8,#C6FF9F,1.0,#000000;tooltip=Pizza 02;pen-width=1;"+;
                "pen-color=#000000;can-move=1;can-mark=1;is-container=0;is-blinker=1;")

oPanel:addShape("id=6;type=4;start-angle=410;sweep-length=040;left=04;top=180;"+;
                "width=100;height=100;gradient=2,050,050,070,-1,0.2,#ffffff,0.8,"+;
                "#67FF67,1.0,#000000;gradient-hover=2,050,050,070,-1,0.2,#ffffff,"+;
                "0.8,#C6FF9F,1.0,#000000;tooltip=Pizza 03;pen-width=1;"+;
                "pen-color=#000000;can-move=1;can-mark=1;is-container=0;is-blinker=0;")
                    
//--------------------------------------------------------------------------------------------------
// Adiciona Linha - Type=6
//--------------------------------------------------------------------------------------------------
oPanel:addShape("id=8;type=6;gradient=1,0,0,0,0,0.0,#134E8D;tooltip=Linha 01;pen-width=1;"+;
                "pen-color=#000000;can-move=1;can-mark=1;large=1;from-left=280;from-top=90;"+;
                "to-left=400;to-top=90;")
oPanel:addShape("id=9;type=6;gradient=1,0,0,0,0,0.0,#E88C23;tooltip=Linha 02;pen-width=1;"+;
                "pen-color=#FF0000;can-move=1;can-mark=1;large=10;from-left=280;from-top=96;"+;
                "to-left=400;to-top=96;")
//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
// Adiciona Texto - Type=7
//--------------------------------------------------------------------------------------------------
oPanel:addShape("id=10;type=7;pen-width=1;font=arial,14,0,0,1;left=280;top=130;width=580;"+;
                "height=420;text=Teste de Texto...;gradient=0,0,0,0,0,0,#000000;can-move=1;can-mark=1;")
//--------------------------------------------------------------------------------------------------

ACTIVATE DIALOG oDlg CENTERED  

Return    

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ EX_TREP  ³ Autor ³ Leonardo Portella     ³ Data ³22/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Exemplo de TReport                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static cEOL := chr(13) + chr(10)

User Function EX_TREP()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oCtaPagar
Private cPerg	  := "EX_TREP"  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

oReport:= TReport():New(cPerg,"Contas a pagar X fornecedores","EX_TREP", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Contas a pagar X fornecedores")

*'-----------------------------------------------------------------------------------'*
*'Solução para impressão em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espaçamento entre colunas. 
//oReport:SetLandscape() //Impressão em paisagem.  

*'-----------------------------------------------------------------------------------'*

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1 - Contas a pagar X fornecedores                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCtaPagar := TRSection():New(oReport,"Contas a pagar X fornecedores")
oCtaPagar:SetTotalInLine(.F.)  

TRCell():New(oCtaPagar ,'A2_NOME'   ,'SA2',"Fornecedor"  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT" )
TRCell():New(oCtaPagar ,'A2_EST'    ,'SA2',"UF"          ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT" )
TRCell():New(oCtaPagar ,'A2_MUN'    ,'SA2',"Mun."        ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT" )
TRCell():New(oCtaPagar ,'E2_NUM'    ,'SE2',"Tit."        ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT")
TRCell():New(oCtaPagar ,'E2_TIPO'   ,'SE2',"Tipo"        ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT")
TRCell():New(oCtaPagar ,'E2_PARCELA','SE2',"Parcela"     ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT" )
TRCell():New(oCtaPagar ,'E2_VALOR'  ,'SE2',"Valor"       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER")
TRCell():New(oCtaPagar ,'E2_VENCREA','SE2',"Vencto"      ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT")
TRCell():New(oCtaPagar ,'E2_BAIXA'  ,'SE2',"Baixa"       ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT" )

oCtaPagar:SetTotalText("Total Geral")   

TRFunction():New(oCtaPagar:Cell("E2_VALOR")	,NIL,"SUM",/*oBreak1*/,,,/*uFormula*/,.T.,.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oCtaPagar  := oReport:Section(1)
Local cAliasRel  := GetNextAlias()
Local cNumPed    := ''
Local cNumDoc    := ''
Local cSerie     := ''
Local oBreak01                             
Local oBreak02    

// Quebra por fornecedor
// Sub-Totais por fornecedor
oBreak01 := TRBreak():New(oCtaPagar,oCtaPagar:Cell("A2_NOME"),"Sub-Total por Fornecedor",.F.) 
TRFunction():New(oCtaPagar:Cell("E2_VALOR"),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,{||(cAliasRel)->E2_VALOR},.F.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery := "SELECT E2_NUM, E2_TIPO, E2_PARCELA, E2_VALOR, E2_VENCREA, E2_BAIXA, A2_NOME, A2_EST, A2_MUN" + cEOL
cQuery += "FROM " + RetSqlName("SA2") + " SA2, " + RetSqlName("SE2") + " SE2"                           + cEOL
cQuery += "WHERE SA2.D_E_L_E_T_ = '' AND "                                                              + cEOL
cQuery += "      SE2.D_E_L_E_T_ = '' AND "                                                              + cEOL
cQuery += "      A2_FILIAL = '" + xFilial("SA2") + "' AND"                                              + cEOL
cQuery += "      E2_FILIAL = '" + xFilial("SE2") + "' AND"                                              + cEOL
cQuery += "      E2_FORNECE = A2_COD AND "                                                              + cEOL 
cQuery += "      A2_COD BETWEEN '" + mv_par01 + "' AND '"+ mv_par02 + "' AND "                          + cEOL
cQuery += "      E2_NUM BETWEEN '" + mv_par03 + "' AND '"+ mv_par04 + "' AND "                          + cEOL
cQuery += "      E2_VENCREA BETWEEN '" + DtoS(mv_par05) + "' AND '"+ DtoS(mv_par06) + "'"               + cEOL
cQuery += "ORDER BY E2_FORNECE, E2_NUM, E2_VENCREA, E2_BAIXA"                                           + cEOL
  
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasRel, .T., .T.)

dbSelectArea(cAliasRel)
dbGoTop()  
     
nTotal := 0
Do While !(cAliasRel)->(Eof())
	nTotal++
	dbSkip()
EndDo

dbGoTop()  

//Se não tiver esta linha, não imprime os dados
oCtaPagar:init()

oReport:SetMeter(nTotal)

cFornAnt := ""

Do While !(cAliasRel)->(Eof())

	oReport:IncMeter() 
	     
	If oReport:Cancel() 
        exit
	EndIf   

	If cFornAnt == (cAliasRel)->A2_NOME
		oCtaPagar:Cell('A2_NOME'):Hide()
	Else
   		oCtaPagar:Cell('A2_NOME'):Show()
   		cFornAnt := (cAliasRel)->A2_NOME
	EndIf   

    If empty((cAliasRel)->E2_BAIXA)
    	oCtaPagar:Cell('E2_BAIXA' ):Hide()
    Else
    	oCtaPagar:Cell('E2_BAIXA' ):Show()
    EndIf                                                     
    
    oCtaPagar:Cell('A2_NOME'   ):SetValue((cAliasRel)->A2_NOME)	
	oCtaPagar:Cell('A2_EST'    ):SetValue((cAliasRel)->A2_EST)
	oCtaPagar:Cell('A2_MUN'    ):SetValue((cAliasRel)->A2_MUN)
	oCtaPagar:Cell('E2_NUM'    ):SetValue((cAliasRel)->E2_NUM)
	oCtaPagar:Cell('E2_TIPO'   ):SetValue((cAliasRel)->E2_TIPO)
    oCtaPagar:Cell('E2_PARCELA'):SetValue((cAliasRel)->E2_PARCELA)
	oCtaPagar:Cell('E2_VALOR'  ):SetValue((cAliasRel)->E2_VALOR)
	oCtaPagar:Cell('E2_VENCREA'):SetValue(StoD((cAliasRel)->E2_VENCREA))
	oCtaPagar:Cell('E2_BAIXA'  ):SetValue(StoD((cAliasRel)->E2_BAIXA))
	    
 	oCtaPagar:PrintLine()
 	
    (cAliasRel)->(dbSkip())

EndDo

oCtaPagar:Finish()

dbCloseArea()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aAreaAnt := GetArea()
Local aHelpPor := {} 

//---------------------------------------MV_PAR01--------------------------------------------------
aHelpPor := {"Código inicial do Fornecedor"}

PutSX1(cPerg,"01","Do Fornecedor","","","mv_ch1","C",TamSX3("A2_COD")[1],0,0,"G","","SA2","","S","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)

//---------------------------------------MV_PAR02--------------------------------------------------
aHelpPor := {"Código final do Fornecedor"}

PutSX1(cPerg,"02","Até o Fornecedor","","","mv_ch2","C",TamSX3("A2_COD")[1],0,0,"G","","SA2","","S","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)

//---------------------------------------MV_PAR03--------------------------------------------------
aHelpPor := {"Numero inicial do Título"}

PutSX1(cPerg,"03","Título de","","","mv_ch3","C",TamSX3("E2_NUM")[1],0,0,"G","","","","S","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)

//---------------------------------------MV_PAR04--------------------------------------------------
aHelpPor := {"Numero final do Título"}

PutSX1(cPerg,"04","Título até","","","mv_ch4","C",TamSX3("E2_NUM")[1],0,0,"G","","","","S","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)

//---------------------------------------MV_PAR05--------------------------------------------------
aHelpPor := {"Data vencimento inicial"}

PutSX1(cPerg,"05","Vencimento de","","","mv_ch5","D",6,0,0,"G","","","","S","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)


//---------------------------------------MV_PAR06--------------------------------------------------
aHelpPor := {"Data vencimento final"}

PutSX1(cPerg,"06","Vencimento até","","","mv_ch6","D",6,0,0,"G","","","","S","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,aHelpPor,aHelpPor)

RestArea(aAreaAnt)                    

Return
     
*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function JoinSQL() 

Define MsDialog oDlg Title "SQL - Exemplos interessantes" From 0,0 to 550,550 Pixel

cMemo := "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---INNER JOIN: retorna resultados que estão nas duas (ou mais) tabelas unidas " 							+ cEOL
cMemo += "---com o INNER JOIN.                                                          " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT TOP 10 *																" 							+ cEOL		
cMemo += "FROM SD1AG0																	" 							+ cEOL
cMemo += "INNER JOIN SA1AG0 ON D1_CODFORN = A1_COD										" 							+ cEOL
cMemo += "WHERE D1_EMISSAO >= '20110101'												" 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--- OUTER JOINS - Outer pode ser suprimido sem problemas                     " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--LEFT JOIN: considera todas as linhas da tabela a esquerda, mesmo que não   " 							+ cEOL
cMemo += "--existam dados a direita.                                                   " 							+ cEOL
cMemo += "--Equivale ao (*=), mas o (*=) não é mais compatível com o padrão 2008. Para " 							+ cEOL
cMemo += "--rodar deve alterar a compatibilidade do BD para 80 (SQL 2000), embora seja " 							+ cEOL
cMemo += "--aconselhável alterar a sintaxe. ESQUERDA É MÃE(SEMPRE APARECE)!!!          " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---Ex: Select para retornar todas os pedidos de venda e o nome do cliente    " 							+ cEOL
cMemo += "---mesmo que não exista o cliente cadastrado.                                " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT C5_NUM, A1_NOME" 																					+ cEOL
cMemo += "FROM SC5990 SC5 LEFT JOIN SA1990 SA1 ON" 																	+ cEOL
cMemo += "	   C5_CLIENTE = A1_COD AND  " 																			+ cEOL
cMemo += "	   C5_LOJACLI = A1_LOJA AND" 																			+ cEOL
cMemo += "	   C5_FILIAL  = '01' AND  " 																			+ cEOL
cMemo += "	   A1_FILIAL = '   ' AND  " 																			+ cEOL
cMemo += "	   SC5.D_E_L_E_T_ = '' AND  " 																			+ cEOL
cMemo += "	   SA1.D_E_L_E_T_ = ''" 																				+ cEOL
cMemo += "ORDER BY A1_NOME, C5_NUM" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--RIGHT JOIN: considera todas as linhas da tabela a direita, mesmo que não   " 							+ cEOL
cMemo += "--existam dados a esquerda.                                                  " 							+ cEOL
cMemo += "--Equivale ao (=*), mas o (=*) não é mais compatível com o padrão 2008. Para " 							+ cEOL
cMemo += "--rodar deve alterar a compatibilidade do BD para 80 (SQL 2000), embora seja " 							+ cEOL
cMemo += "--aconselhável alterar a sintaxe. DIREITA É MÃE(SEMPRE APARECE)!!!           " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---Ex: Select para retornar todas os pedidos de venda e o nome do cliente    " 							+ cEOL
cMemo += "---mesmo que não exista o pedido.                                            " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT A1_NOME, C5_NUM" 																					+ cEOL
cMemo += "FROM SC5990 SC5 RIGHT JOIN SA1990 SA1 ON" 																+ cEOL
cMemo += "	  A1_COD = C5_CLIENTE AND" 																				+ cEOL
cMemo += "	  C5_FILIAL  = '01' AND  " 																				+ cEOL
cMemo += "	  A1_FILIAL  = '   ' AND  " 																			+ cEOL
cMemo += "	  SC5.D_E_L_E_T_ = '' AND  " 																			+ cEOL
cMemo += "	  SA1.D_E_L_E_T_ = ''" 																					+ cEOL
cMemo += "ORDER BY A1_NOME, C5_NUM" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---FULL JOIN: todas as linhas da primeira tabela mais o resultado com todas  " 							+ cEOL
cMemo += "---as linhas da segunda tabela e apresentará em mesma linha os itens que     " 							+ cEOL
cMemo += "---forem possíveis de relacionamento. AS 2 APARECEM!!!                       " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---Ex: Select para retornar todas os pedidos de venda e o nome do cliente    " 							+ cEOL
cMemo += "---mesmo que não exista o cliente ou o pedido                                " 							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT A1_NOME, C5_NUM" 																					+ cEOL
cMemo += "FROM SC5990 SC5 FULL JOIN SA1990 SA1 ON " 																+ cEOL
cMemo += "	  C5_CLIENTE = A1_COD AND  " 																			+ cEOL
cMemo += "	  C5_LOJACLI = A1_LOJA AND" 																			+ cEOL
cMemo += "	  C5_FILIAL  = '01' AND  " 																				+ cEOL
cMemo += "	  A1_FILIAL  = '  ' AND  " 																				+ cEOL
cMemo += "	  SC5.D_E_L_E_T_ = '' AND  " 																			+ cEOL
cMemo += "	  SA1.D_E_L_E_T_ = ''" 																					+ cEOL
cMemo += "ORDER BY A1_NOME, C5_NUM" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---BEGIN TRANSACTION; COMMIT; ROLLBACK; UPDATE" 															+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "BEGIN TRANSACTION -- inicia a transação" 																	+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "UPDATE SE2990" 																							+ cEOL
cMemo += "SET E2_PREFIXO = 'TST'" 																					+ cEOL
cMemo += "WHERE E2_NUM = '67496 '" 																					+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "ROLLBACK -- cancela o update" 																			+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "COMMIT -- confirma o update" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "---OVER: TOTALIZADOR (T-SQL)"																				+ cEOL
cMemo += "---Na query abaixo, TOTAL representa o total geral e TOT_CLIENTE representa o        "  					+ cEOL
cMemo += "---total do cliente. Elimina a necessidade de ter que criar uma variavel que "							+ cEOL
cMemo += "---armazene o total e NAO usa a clausula GROUP BY. Se quiser totalizar na "								+ cEOL
cMemo += "---linguagem a cada loop do laco. Observe colocar o GROUP BY, obrigatoriamente "							+ cEOL
cMemo += "---tera que agrupar pelo totalizador contido no SUM, no caso, D2_TOTAL."									+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT D2_CLIENTE,D2_COD," 																				+ cEOL
cMemo += "     SUM(D2_TOTAL) OVER() AS TOTAL, " 																	+ cEOL
cMemo += "     SUM(D2_TOTAL) OVER(PARTITION BY D2_CLIENTE) AS TOT_CLIENTE" 											+ cEOL
cMemo += "FROM SD2AG0" 																								+ cEOL
cMemo += "WHERE D_E_L_E_T_ = ''" 																					+ cEOL
cMemo += "	AND D2_EMISSAO >= '20110312'" 																			+ cEOL
cMemo += "ORDER BY D2_CLIENTE" 																						+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--DATA ATUAL" 																							+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT CONVERT(CHAR(8),CURRENT_TIMESTAMP,112) AS [DATA ATUAL]" 											+ cEOL 
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--FUNCOES DE TEXTO:" 																						+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "DECLARE @DATA_ATUAL VARCHAR(8)" 																			+ cEOL
cMemo += "SET @DATA_ATUAL = CONVERT(CHAR(8),CURRENT_TIMESTAMP,112)" 												+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "SELECT TOP 5 C5_NREDUZ, " 																				+ cEOL
cMemo += "	DATEPART(WEEKDAY,@DATA_ATUAL) [DIA DA SEMANA]," 														+ cEOL
cMemo += "	DATENAME(MONTH,@DATA_ATUAL) [NOME MES]," 																+ cEOL
cMemo += "	YEAR(C5_EMISSAO) 'ANO'," 																				+ cEOL
cMemo += "	MONTH(C5_EMISSAO) 'MES'," 																				+ cEOL
cMemo += "	DAY(C5_EMISSAO) 'DIA'," 																				+ cEOL
cMemo += "	REPLACE(C5_NREDUZ,'-','*') 'REPLACE'," 																	+ cEOL
cMemo += "	REPLICATE('XYZ',5) 'REPLICATE'," 																		+ cEOL
cMemo += "	STUFF(REPLICATE('XYZ',5),2,4,'-') 'STUFF'," 															+ cEOL
cMemo += "	'-' + RTRIM('   TESTE   ') + '-' AS 'RTRIM'," 															+ cEOL
cMemo += "	'-' + LTRIM('   TESTE   ') + '-' AS 'LTRIM'," 															+ cEOL
cMemo += "	CHARINDEX('A',C5_NREDUZ) [POSICAO 'A' EM C5_NREDUZ]," 													+ cEOL
cMemo += "	PATINDEX('%A%U%',C5_NREDUZ) [POS. PADRAO '%A%U%' EM C5_NREDUZ]" 										+ cEOL
cMemo += "FROM SC5AG0" 																								+ cEOL
cMemo += "WHERE C5_EMISSAO >= @DATA_ATUAL - 2" 																		+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--WITH TIES: CASO SEJA USADA A OPCAO TOP COM O ORDER BY, PODEM "				 							+ cEOL
cMemo += "--OCORRER EMPATES, OU SEJA, MAIS LINHAS QUE TENHAM A MESMA CONDI-"		 								+ cEOL
cMemo += "--CAO DE CORTE DO ORDER BY. A OPCAO WITH TIES RETORNA TODAS AS "			 								+ cEOL
cMemo += "--LINHAS COM O MESMO CRITERIO DE CORTE." 																	+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT TOP 1 PERCENT WITH TIES C5_EMISSAO EMISSAO,*" 														+ cEOL
cMemo += "FROM SC5AG0" 																								+ cEOL
cMemo += "WHERE C5_EMISSAO >= CONVERT(CHAR(8),CURRENT_TIMESTAMP,112) - 2" 											+ cEOL
cMemo += "ORDER BY C5_EMISSAO DESC" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--ETC: EXPRESSAO DE TABELA COMUM (PODE SUBSTITUIR A SUBCONSULTA "				 							+ cEOL
cMemo += "--POR UMA ETC, COM AS VANTAGENS DE PODER UTILIZAR MAIS DE UMA" 											+ cEOL 
cMemo += "--VEZ E GERAR CODIGO MAIS LIMPO)" 																		+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "WITH A AS" 																								+ cEOL
cMemo += "(" 																										+ cEOL
cMemo += "SELECT A1_COD,A1_NREDUZ " 																				+ cEOL
cMemo += "FROM SA1AG0" 																								+ cEOL
cMemo += "WHERE D_E_L_E_T_ = ''" 																					+ cEOL
cMemo += "	AND A1_NREDUZ LIKE '%A%A%'" 																			+ cEOL
cMemo += ") " 																										+ cEOL
cMemo += "SELECT *" 																								+ cEOL
cMemo += "FROM A" 																									+ cEOL
cMemo += "WHERE A1_NREDUZ LIKE '%X%'" 																				+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--FVT: FUNCOES COM VALOR DE TABELA (FUNCAO QUE RETORNA UMA TABELA)" 										+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "IF OBJECT_ID('dbo.ULTIMOS_PEDIDOS') IS NOT NULL" 															+ cEOL
cMemo += "	DROP FUNCTION dbo.ULTIMOS_PEDIDOS" 																		+ cEOL
cMemo += "GO" 																										+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "CREATE FUNCTION dbo.ULTIMOS_PEDIDOS (@QTD AS INT,@COD AS VARCHAR(6))" 									+ cEOL
cMemo += "RETURNS TABLE" 																							+ cEOL
cMemo += "AS " 																										+ cEOL
cMemo += "RETURN" 																									+ cEOL
cMemo += "(" 																										+ cEOL
cMemo += "	SELECT TOP (@QTD) C5_NUM, C5_EMISSAO" 																	+ cEOL
cMemo += "	FROM SC5AG0" 																							+ cEOL
cMemo += "	WHERE D_E_L_E_T_ = '' " 																				+ cEOL
cMemo += "		AND C5_CLIENTE = @COD" 																				+ cEOL
cMemo += "	ORDER BY C5_EMISSAO DESC" 																				+ cEOL
cMemo += ")" 																										+ cEOL
cMemo += "GO" 																										+ cEOL
cMemo += "" 																										+ cEOL
cMemo += "SELECT *" 																								+ cEOL
cMemo += "FROM dbo.ULTIMOS_PEDIDOS(3,'0002')" 																		+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--CROSS APPLY (APLICA O RESULTADO DE UMA QUERY A CADA LINHA DE " 											+ cEOL
cMemo += "--UMA TABELA. SE A CONSULTA A SER APLICADA NAO RETORNAR RESULTADO, " 					   					+ cEOL
cMemo += "--NAO RETORNA A LINHA DA TABELA ESQUERDA)" 																+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT A1_FILIAL,A1_COD,A1_NREDUZ,C5_NUM,C5_EMISSAO" 														+ cEOL
cMemo += "FROM SA1AG0" 																								+ cEOL
cMemo += "CROSS APPLY dbo.ULTIMOS_PEDIDOS(3,A1_COD) " 																+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--OUTER APPLY (APLICA O RESULTADO DE UMA QUERY A CADA LINHA DE " 											+ cEOL
cMemo += "--UMA TABELA. SE A CONSULTA A SER APLICADA NAO RETORNAR RESULTADO, " 										+ cEOL
cMemo += "--RETORNA A LINHA DA TABELA ESQUERDA)" 																	+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT A1_FILIAL,A1_COD,A1_NREDUZ,C5_NUM,C5_EMISSAO" 														+ cEOL
cMemo += "FROM SA1AG0" 																								+ cEOL
cMemo += "OUTER APPLY dbo.ULTIMOS_PEDIDOS(3,A1_COD)" 																+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "--PIVOT (DINAMIZACAO): MUDA A TABELA DE LINHAS PARA COLUNAS. NAO " 					  					+ cEOL
cMemo += "--EH SOMENTE GIRAR, POIS PODE AGREGAR VALORES, COMO POR EXEMPLO " 										+ cEOL
cMemo += "--INCLUIR COLUNAS. NA QUERY ABAIXO, OS NUMEROS CORRESPONDEM AO MES. " 					  				+ cEOL
cMemo += "--OS COLCHETES SAO USADOS POIS O RETORNO DA FUNCAO MONTH EH UM " 											+ cEOL
cMemo += "--NUMERO." 																								+ cEOL 
cMemo += "----------------------------------------------------------------------------------------------------" 	+ cEOL
cMemo += "SELECT C5_NREDUZ CLIENTE, C6_DESCRI PRODUTO, " 															+ cEOL
cMemo += "	[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]" 													+ cEOL
cMemo += "FROM" 																									+ cEOL
cMemo += "(" 																										+ cEOL
cMemo += "	SELECT TOP 20 C5_NREDUZ, C6_DESCRI, " 																	+ cEOL
cMemo += "		SUM(C6_QTDVEN) QTD_MES, MONTH(C5_EMISSAO) MES" 														+ cEOL
cMemo += "	FROM SC6AG0" 																							+ cEOL
cMemo += "	INNER JOIN SC5AG0 ON C5_NUM = C6_NUM AND C5_FILIAL = C6_FILIAL" 										+ cEOL
cMemo += "	GROUP BY MONTH(C5_EMISSAO), C5_CLIENTE, C5_NREDUZ, C6_PRODUTO, C6_DESCRI" 								+ cEOL
cMemo += ") AS A" 																									+ cEOL
cMemo += "PIVOT( SUM(QTD_MES) FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) ) AS P" 				+ cEOL
cMemo += cEOL
cMemo += "=>ORACLE<======================================================================================================"	+ cEOL
cMemo += cEOL
cMemo += "=>COMPARAÇÃO DE STRINGS APROXIMADA!!!" 																			+ cEOL
cMemo += "* EDIT_DISTANCE" 																									+ cEOL
cMemo += "Returns the number of changes required to turn the source string into the destination string using the " 			+ cEOL
cMemo += "Levenshtein Distance algorithm." 			  																		+ cEOL
cMemo += "SELECT utl_match.edit_distance('expresso', 'espresso') DIST FROM dual;" 											+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 			+ cEOL
cMemo += "* EDIT_DISTANCE_SIMILARITY" 																						+ cEOL
cMemo += "Returns an integer between 0 and 100, where 0 indicates no similarity at all and 100 indicates a perfect match." 	+ cEOL
cMemo += "SELECT utl_match.edit_distance_similarity('expresso', 'espresso') SIM FROM dual;" 								+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 			+ cEOL
cMemo += "* JARO_WINKLER" 																									+ cEOL
cMemo += "Instead of simply calculating the number of steps required to change the source string to the destination " 		+ cEOL
cMemo += "string,determines how closely the two strings agree with each other and tries to take into account the " 			+ cEOL
cMemo += "possibility of a data entry error." 																				+ cEOL
cMemo += "SELECT utl_match.jaro_winkler('expresso', 'espresso') DIST FROM dual;" 			   								+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 			+ cEOL
cMemo += "* JARO_WINKLER_SIMILARITY" 																						+ cEOL
cMemo += "Returns an integer between 0 and 100, where 0 indicates no similarity at all and 100 indicates a perfect match " 	+ cEOL
cMemo += "but tries to take into account possible data entry errors." 														+ cEOL
cMemo += "SELECT utl_match.jaro_winkler_similarity('expresso', 'expresso') SIM FROM dual;" 									+ cEOL
cMemo += "----------------------------------------------------------------------------------------------------" 			+ cEOL

oMemo := tMultiGet():New(0,0,{|u|if(Pcount()>0,cMemo:=u,cMemo)},oDlg,277,278,,,,,,.T.)
                                          
Activate MsDialog oDlg Center
	  
Return

*'-----------------------------------------------------------------------------------------------------------------------------------------------'*

User Function ReguaProc     

DEFINE DIALOG oDlg TITLE "Regua" FROM 180,180 TO 550,700 PIXEL 
	                 
    nMeter1 := 0 
    oSay1  	:= TSay():New(05,10,,oDlg,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter1 := TMeter():New(16,10,,100,oDlg,140,10,,.T.)

    nMeter2 := 0
    oSay2  	:= TSay():New(35,10,,oDlg,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter2 := TMeter():New(46,10,,100,oDlg,190,10,,.T.)
            
	nMeter3 := 0
    oSay3  	:= TSay():New(65,10,,oDlg,,,,,,.T.,CLR_BLACK,CLR_WHITE,400,900)
   	oMeter3 := TMeter():New(76,10,,100,oDlg,240,10,,.T.)                           
        
    oMeter1:Set(0)            
	oMeter2:Set(0)            
	oMeter3:Set(0)            
	
	oMeter1:SetTotal(100)
	oMeter2:SetTotal(100)
	
	oMeter3:nClrPane := CLR_GREEN
	oMeter3:SetTotal(100)
      	                
ACTIVATE DIALOG oDlg CENTERED ON INIT IncMeter()

Return

Static Function IncMeter

Local i := 0
      
For i := 1 to 100

	oMeter1:Set(i)	
	oMeter2:Set(i)	
	oMeter3:Set(i)
	              
	cMsg := 'Processando a linha ' + strZero(i,4)
	
	oSay1:SetText(cMsg + ' (Padrão)')
	oSay2:SetText(cMsg)
	oSay3:SetText(cMsg)
	
	oMeter1:Refresh()
	oMeter2:Refresh()
	oMeter3:Refresh()
	
Next

Return                        

********************************************************************************************************************************

User Function TDrawer

Private isText := .F.
Private colors := {CLR_HRED, -1} // Linha Vermelha / Fundo Transparente

DEFINE DIALOG oDlg TITLE "Exemplo TDrawer" FROM 180,180 TO 550,700 PIXEL

// Menu de Opções
oMenu := TMenu():New()   

oMenu:Add(TMenuItem():New(oMenu:Owner(),'Abre'		,,,,{||isText:=.F.,openFile()})) 
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Salva'	,,,,{||isText:=.F.,saveFile()})) 
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Texto'	,,,,{||isText:=.T.})) 
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Selecao'	,,,,{||isText:=.F.,oDrawer:SetType(0)}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Traço'	,,,,{||isText:=.F.,oDrawer:SetType(1)}))            
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Livre'	,,,,{||isText:=.F.,oDrawer:SetType(2)}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Circulo'	,,,,{||isText:=.F.,oDrawer:SetType(3)}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Retang.'	,,,,{||isText:=.F.,oDrawer:SetType(4)}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Oval'		,,,,{||isText:=.F.,oDrawer:SetType(5)}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Fonte'	,,,,{||oDrawer:SetFontText(TFont():New('Verdana',0,-30)),alert('Fonte alterada')}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Cores'	,,,,{||defineColor()}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Desfaz'	,,,,{||oDrawer:Undo()}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Recorta'	,,,,{||oDrawer:Crop()}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Cola'		,,,,{||oDrawer:Paste()}))
oMenu:Add(TMenuItem():New(oMenu:Owner(),'Limpa'	,,,,{||oDrawer:ClearImage()}))

// Cria Scroll e TDrawer para a imagem
oTScrollBox := TScrollBox():New(oDlg,02,80,184,180,.T.,.T.,.T.)

oDrawer := tDrawer():New(0,0,oTScrollBox,900,550)

// Define cores iniciais
oDrawer:SetColors(colors[1], colors[2])

// Blocos de codigo do mouse
oDrawer:blClicked := {|o,x,y| click(x,y)}
oDrawer:brClicked := {|o,x,y| Alert('Click direito do mouse')}

ACTIVATE MSDIALOG oDlg CENTERED 

Return

Static Function click(x,y)

If (isText)
	text := 'Digite o texto'
	inputQuery('Adiciona texto','Digite texto - "|" para pulo de linha',@text)
	oDrawer:AddText(x,y,text)
EndIf

Return 

Static Function saveFile()

Local cFile := 'C:\Dir\imagem.JPG'

inputQuery('Salva imagem','Arquivo (JPG, PNG ou BMP)',@cFile)
oDrawer:SaveImage( cFile, 'JPG' )

Return

Static Function openFile()

cFile := AllTrim( cGetFile( 'Arquivo JPG|*.Jpg|Arquivo PNG|*.Png|Arquivo BMP|*.Bmp','Selecione arquivo', 0, 'C:\Dir\', .T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE ) )

If ( file(cFile) )
	oDrawer:OpenImage(cFile)
EndIf

Return

Static Function inputQuery(cTitulo,cDescr,cResult)

Local cGet1 := PadR(cResult,200)
Local oGet1 
Local oDlgInput

DEFINE MSDIALOG oDlgInput TITLE cTitulo FROM 178,181 TO 270,443 PIXEL

@ 002,002 Say cDescr Size 131,008 of oDlgInput Pixel
@ 014,002 Get oTGet VAR cGet1 SIZE 130,009 PIXEL OF oDlgInput

oBtn1 := TButton():New( 30,002, 'Ok' 		, oDlgInput,{|| cResult:=AllTrim(cGet1),oDlgInput:End() }	,25,15,,,.F.,.T.,.F.,,.F.,,,.F. )
oBtn2 := TButton():New( 30,034, 'Cancela'	, oDlgInput,{|| cResult:='',oDlgInput:End() }			,25,15,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE MSDIALOG oDlgInput CENTERED 

Return

Static Function defineColor()

Local oDlgColor

DEFINE MSDIALOG oDlgColor TITLE 'Escolhe as Cores Linha/Fundo' FROM 01,01 TO 450,450 PIXEL

oColorPen 	:= tColorTriangle():New(001,02,oDlgColor,200,100)
oColorBrush := tColorTriangle():New(102,02,oDlgColor,200,100)

oBtn1 := TButton():New( 202,006, 'Ok', oDlgColor,{|| colors[1]:=oColorPen:retColor(),colors[2]:=oColorBrush:retColor(),oDlgColor:End() },; 
																											25,15,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE MSDIALOG oDlgColor CENTERED 

// Define cores para a pintura
oDrawer:SetColors(colors[1], colors[2])

Return

********************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PopUpMenu ºAutor  ³Leonardo Portella   º Data ³  10/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Menu acionado com o click do botao direito do mouse.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³nOpca: layout do popup [1-cinza,2-branco(estilo menu        º±±
±±º          ³       protheus)]                                        	  º±±
±±º          ³aMenu: array                                           	  º±±
±±º          ³	aMenu[i][1]:Nome da opcao do popup                        º±±
±±º          ³	aMenu[i][2]:array contendo os itens do popup(1 ou + aItem)º±±
±±º          ³	   aItem[j][1]: Nome da subopcao do popup				  º±±
±±º          ³	   aItem[j][2]: Logico (habilita/desabilita a opcao)      º±±
±±º          ³	   aItem[j][3]: Nome da funcao (acao a executar no click).º±±
±±º          ³	   				Eh possivel executar mais de uma passando º±±
±±º          ³	                por ','.                                  º±±
±±º          ³	   aItem[j][4]: Nome do bitmap a ser exibido na subopcao  º±±
±±º          ³	aMenu[i][3]:Numero de ajuste (opcional)                   º±±
±±º          ³nX   : numero da coordenada do eixo X em que devera ser exi-º±±
±±º          ³		 bido o popup.										  º±±
±±º          ³nY   : numero da coordenada do eixo Y em que devera ser exi-º±±
±±º          ³		 bido o popup.										  º±±
±±º          ³cNomProg: Nome do programa(retorno da funcao FunName())	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FBD                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PopUpMenu(nOpca,aMenu,nX,nY,cNomProg)   

Local i := 0
Local j := 0

Local nCor 			:= If(nOpca==1,14991161/*Cinza*/,CLR_WHITE)
Local bAction		:= {|| }
Local aMenuPop		:= aClone(aMenu) 

aItem := {{'Sobre',.T.,"u_Sobre(cNomProg)",'MDIHELP'}}

aAdd(aMenuPop,{'Ajuda',aItem, 45})

Private oDlgPopup 	:= Nil  
     
nY += 290
nX += 45

aScreenRes 	:= GetScreenRes()
nHorRes 	:= aScreenRes[1]//Resolucao Horizontal
nVertRes 	:= aScreenRes[2]//Resolucao Vertical

Do Case
       
	Case nHorRes == 1280 .and. nVertRes == 1024
		nAjResVert 	:= If(nOpca == 1,13+(len(aMenu)*15),140)
		nAjResHor 	:= If(nOpca == 1,150,205)  
		
	Case nHorRes == 1280 .and. nVertRes == 800
		nAjResVert 	:= If(nOpca == 1,13+(len(aMenu)*15),85)
		nAjResHor 	:= If(nOpca == 1,150,205)	
	
	Otherwise
		nAjResVert 	:= 100
		nAjResHor 	:= 150
	
EndCase                               

nPosY := nY+nAjResVert
nPosX := nX+nAjResHor 
   
//Ajuste do popup nas bordas
If nPosX > nHorRes
	 nDif 	:= nPosX - nX
     nPosX 	:= nX
     nX 	-= nDif
EndIf

If nPosY > (nVertRes - 100)
	 nDif 	:= nPosY - nY
     nPosY 	:= nY
     nY 	-= nDif
EndIf

oDlgPopup := MsDialog():New(nY,nX,nPosY,nPosX,'LUFT',,,.F.,,,,,,.T.,,,.T. )
   
    oDlgPopup:SetColor(CLR_BLACK,nCor) 
    
    If nOpca == 1

	    //Cria menu
	   	For i := 1 to len(aMenuPop)
	
		    oPanel	:= tPanel():New((i-1)*8,0,,oDlgPopup,,,,,,100,8)
		    
		    If len(aMenuPop) > 2 .and. !empty(aMenuPop[i][3]) .and. valType(aMenuPop[i][3]) == 'N' .and. aMenuPop[i][3] >= 0
				nAjuste := aMenuPop[i][3]
			Else 
				nAjuste	:= 45				
			EndIf
				
		    oTMenuBar	:= TMenuBar():New(oPanel)
		    oTMenu	 	:= TMenu():New(0,0,0,0,.T.,,oPanel)
		    oTMenuBar:AddItem(PadR(Left(allTrim(aMenuPop[i][1]),nAjuste),nAjuste), oTMenu, .T.)
		
		    // Cria Itens do Menu
		    For j := 1 to len(aMenuPop[i][2])                                                    
		        
		    	bAction 	:= '{|| oDlgPopup:End(),' + aMenuPop[i][2][j][3] + '}'
		    	
			    oTMenuItem 	:= TMenuItem():New(oPanel,aMenuPop[i][2][j][1],,,aMenuPop[i][2][j][2],&bAction,,aMenuPop[i][2][j][4],,,,,,,.T.)
			    oTMenu:Add(oTMenuItem)
			
			Next
				
		Next                  
	
	Else
	        
	    //Cria menu
	   	For i := 1 to len(aMenuPop)
	
		    If len(aMenuPop) > 2 .and. !empty(aMenuPop[i][3]) .and. valType(aMenuPop[i][3]) == 'N' .and. aMenuPop[i][3] >= 0
				nAjuste := aMenuPop[i][3]
			Else 
				nAjuste	:= 45				
			EndIf
			
			If i == 1	
			    oMenuMain 	:= TMenu():New(0,0,0,0,.F.,,oDlgPopup,CLR_WHITE,CLR_BLACK)
		    EndIf
		    
		    oMenuDiv 	:= TMenuItem():New2( oMenuMain:Owner(),PadR(Left(allTrim(aMenuPop[i][1]),nAjuste),nAjuste),'',,,)
		    oMenuMain:Add(oMenuDiv)
		    
		    // Cria Itens do Menu
		    For j := 1 to len(aMenuPop[i][2])                                                    
		        
		    	bAction 	:= '{|| oDlgPopup:End(),' + aMenuPop[i][2][j][3] + '}'
		    	
		    	oMenuItem := TMenuItem():New2( oMenuMain:Owner(),aMenuPop[i][2][j][1],,,&bAction)
		    	oMenuDiv:Add( oMenuItem )  
			    
			Next
				
		Next           

	EndIf
 
oDlgPopup:Activate(,,,.F.,,,)

Return   

**********************************************************************************************************************************

User Function Sobre(cNomProg)

Local aArea := GetArea()

Private aType // Para retornar a origem da função: FULL, USER, PARTNER, PATCH, TEMPLATE ou NONE
Private aFile // Para retornar o nome do arquivo onde foi declarada a função
Private aLine // Para retornar o número da linha no arquivo onde foi declarada a função
Private aDate // Para retornar a data do código fonte compilado
      
nI := 2

If empty(cNomProg)
	cNomFun 	:= ' '
Else
	While .T.                     
	
		cNomFun := procName(nI)
	
		If (upper(left(procName(nI),2)) == 'U_' .and. cNomFun != 'U_POPUPMENU' .and. cNomFun != 'U_SOBRE') .or. nI > 100
		    exit
		EndIf   
		
		++nI
		
	EndDo
	
	aFuncCust 	:= getFuncArray("U_"+allTrim(upper(cNomProg)), aType, aFile, aLine, aDate) 
EndIf

SetPrvt("oDlgSbr","oGrp1","oSay1","oSay2","oBmp1","oSay3","oSay4","oSBtn1")

oDlgSbr    := MsDialog():New(091,232,390,741,"Sobre...",,,.F.,,CLR_BLACK,-1,,,.T.,,,.T. )
      
oGrp1      := TGroup():New( 008,008,120,248,"",oDlgSbr,CLR_BLACK,CLR_WHITE,.T.,.F. )

oSay1      := TSay():New( 016,016,{||"Luft Food Service Ltda."},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,064,008)

oSay2      := TSay():New( 080,016,								,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
cTexto 	   := If(!empty(aFile),allTrim(aFile[1]),'')
oSay2:SetText("Programa: " + cTexto)

oSay3      := TSay():New( 092,016,							  	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
oSay3:SetText("Função: "+ cNomFun)
                        
Set Date British

oSay4      := TSay():New( 104,016,								,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
cTexto 	   := If(!empty(aDate),DtoC(aDate[1]),'')
oSay4:SetText("Compilação: " + cTexto)

oBmp1      := TBitmap():New( 028,016,132,044,,"\Logos\Luft.bmp",.F.,oGrp1,,,.F.,.T.,,"",.T.,,.T.,,.F. )

oSBtn1     := SButton():New( 128,222,1,{||oDlgSbr:End()},oDlgSbr,,"", )

oDlgSbr:Activate(,,,.T.) 

RestArea(aArea)

Return 

**********************************************************************************************************************************

User Function TstClass

oTst 		:= Teste():New()
oTst:cPriv 	:= 'teste'//A porcaria do encapsulamento nao funciona
oTst:Msg()  

Return

******************************
           
Class Teste

Data cPriv AS LOGICAL HIDDEN

Method New() Constructor

Method Msg()

EndClass

******************************

Method New() Class Teste

::cPriv := 'private'

Return Self

******************************

Method Msg() Class Teste

alert(::cPriv)

Return

**********************************************************************************************************************************

User Function TryCatch
 
Local oException

TRY

	cTst := 1 + 'A' //Erro de type mismatch
 
CATCH USING oException
  
	If ( ValType( oException ) == "O" )
	    
	    uRet := 'LEONARDO' + CRLF
	    uRet += replicate('_',20) + CRLF + CRLF
	    uRet += If( !Empty( oException:Description ) 	, oException:Description , "" )
	    uRet += If( !Empty( oException:ErrorStack ) 	, oException:ErrorStack  , "" )
	    
	    MsgInfo(uRet)
	    
	EndIf
	                                        
ENDCATCH
  
Return

************************************************************************************************************************

User Function CadUsr

Local i := 0

Local oOk      	:= LoadBitMap(GetResources(),"LBOK")
Local oNo      	:= LoadBitMap(GetResources(),"LBNO")
Local aVetBx	:= {}         
Local oDlg 		:= nil
Local oLbx		:= nil
Local lConfirm	:= .F.

If u_lProtheus()
	  		                                
	Processa({||aVetBx := ArrUser()})
	
	DEFINE MSDIALOG oDlg TITLE "Seleção de usuário Protheus" FROM 000,000 TO 510,850  OF oDlg PIXEL
	
	@ 010,010 LISTBOX oLbx FIELDS HEADER " ","Codigo", "Login","Nome","Departamento","Data validade" ;
		SIZE 410,220 OF oDlg PIXEL ON DBLCLICK( aVetBx[oLbx:nAt,1] := !aVetBx[oLbx:nAt,1], oLbx:Refresh() )
		
			oLbx:SetArray( aVetBx )
			oLbx:bLine := {||{If(aVetBx[oLbx:nAt,1]	,oOk,oNo)	,;
								aVetBx[oLbx:nAt,2]  				,;
								aVetBx[oLbx:nAt,3] 				 	,;
								aVetBx[oLbx:nAt,4]  				,;
								aVetBx[oLbx:nAt,5]					,;
								aVetBx[oLbx:nAt,6]  				}}
				
	  @ 235,0355 BUTTON "&Confirma " SIZE 30,12 PIXEL ACTION {||lConfirm := .T.,oDlg:End()}
	  @ 235,0390 BUTTON "&Sair     " SIZE 30,12 PIXEL ACTION oDlg:End()
	  
	ACTIVATE MSDIALOG oDlg CENTERED 
	
	If lConfirm 
		
		cLog := ""
		
		For i := 1 to len(aVetBx)
			If aVetBx[i][1]
			     cLog += aVetBx[i][2] + ';'
			EndIf                  
		Next                               
		
		cLog := left(cLog,len(cLog)-1)
		
		LogErros(cLog,'Código dos usuários selecionados')
	
	EndIf

EndIf

Return                               

*********************************************************************************************************

Static Function ArrUser

Local n := 0
Local i := 0
      
Local aRet 		:= {}
Local aUsers	:= {}
Local nQtd 		:= 0
Local nCont		:= 0
Local cTot 		:= ""

ProcRegua(0)

For i := 1 to 5
	IncProc('Processando...')
Next

aUsers	:= AllUsers()

nQtd 	:= len(aUsers) 

cTot 	:= cValToChar(nQtd)

ProcRegua(nQtd)

For n := 1 to nQtd
    IncProc('Usuário ' + cValToChar(++nCont) + ' de ' + cTot)
    aAdd(aRet,{.F.,aUsers[n][1][1],PadR(Capital(lower(aUsers[n][1][2])),30,' '),PadR(Capital(lower(aUsers[n][1][4])),40,' '),aUsers[n][1][12],DtoC(aUsers[n][1][6])})
Next

//Ordena por nome completo
aSort(aRet,,,{|x,y| x[4] < y[4]}) 

Return aRet

***********************************************************************

User Function FunToUser 

Local lConfirm 	:= .F.
Local cPath		:= "" 
Local cPathIni 	:= "C:\"

Private nHandle		:= 0
Private aFuncSubs	:= {}
Private oObj		:= Nil
Private lMudaStr	:= .F.
      
oDlgFun      := MSDialog():New( 095,232,450,803,"Function To User",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"Descrição",oDlgFun,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||"Transforma 'Function' em 'User Function', inclusive as chamadas dentro do fonte"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)

	oSay1      := TSay():New( 078,008,{||"Caminho Programa:"},oDlgFun,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlgFun,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)

	oBtn1      := TButton():New( 078,272,"...",oDlgFun,{||cPath:=cGetFile( 'Todos|*.*','Selecione arquivo', 0, cPathIni, .T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)},008,010,,,,.T.,,"",,,,.F. )

	oCheck1 := TCheckBox():New(090,008,'Comenta variaveis STR',{||lMudaStr},oDlgFun,100,210,,,,,,,,.T.,,,) 
    oCheck1:bLClicked := {||lMudaStr := !lMudaStr,}   

	oSBtn1     := SButton():New( 160,224,1,{||oDlgFun:End(),lConfirm := .T.},oDlgFun,,"", )
	oSBtn2     := SButton():New( 160,254,2,{||oDlgFun:End(),lConfirm := .F.},oDlgFun,,"", )

oDlgFun:Activate(,,,.T.)

If lConfirm 
	If empty(cPath)
		Alert('Informe um arquivo!')
	Else
		oObj := MsNewProcess():New({||ProcFunc(cPath)},'Processando...',"",.F.)
		oObj:Activate()
	EndIf
EndIf

Return

*******************************************************

Static Function ProcFunc(cArq)

Local j := 0  
    
Local cLine 	:= ""           
Local cNewLine	:= ""
Local cNewFile	:= ""
Local aTmp		:= {} 

nHandle := FT_FUse(cArq)
FT_FGoTop()

nQtd := FT_FLastRec()
cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))

oObj:SetRegua1(nQtd)

nQtd := 0
FT_FGoTop()

While !FT_FEOF()

	If ( ++nQtd % 2 == 0 )
		oObj:IncRegua1('Linha: ' + AllTrim(Transform(nQtd/2, "@E 999,999,999")) + ' de ' + cTot)
	EndIf

  	cLine := FT_FReadLn() // Retorna a linha corrente
  	
  	cNewLine := ProcArq(cLine,.F.)
  	          
  	cNewFile += cNewLine + CRLF
  	
  	aAdd(aTmp,cNewLine)
  	
	FT_FSKIP()
  	
EndDo 

// Fecha o Arquivo
FCLOSE(nHandle)
FT_FUSE() 

cNewLine := "" 
cNewFile := ""

For j := 1 to len(aTmp)

	If ( ++nQtd % 2 != 0 )
		oObj:IncRegua1('Linha: ' + AllTrim(Transform((nQtd+1)/2, "@E 999,999,999")) + ' de ' + cTot)
	EndIf

  	cLine := aTmp[j]
  	
  	cNewLine := ProcArq(cLine,.T.)
  	
  	cNewFile += cNewLine + CRLF
  	
Next

LogErros(cNewFile,'Nova Func',.F.)

Return

***********************************************************************

Static Function ProcArq(cLine,lAjuste)

Local i := 0
        
Local nPosFunc 	:= At('FUNCTION',Upper(cLine))
Local nPos		:= 0
Local cAspas	:= ("'" + '"' + ' ' + "(")

If !lAjuste .and. lMudaStr

	//Transforma as chamadas de variaveis STR normalmente declaradas em INCLUDES em caracteres. Algumas variaveis STR podem dar 
	//erro pois nao existem no include da base em que esta sendo rodado.
	//Faco so quando lAjuste eh FALSE para nao rodar 2 vezes.

    nPos := 0

    oObj:SetRegua2(len(cLine))

    //Busco todos os STR da linha
    While ( nPos := At("STR",Upper(cLine),If(nPos > 0,nPos,1)) ) > 0

		oObj:IncRegua2('Buscando variáveis STR...')

		//Se achou na primeira coluna ou a coluna anterior eh espaco ou parenteses
		If nPos == 1 .or. (nPos > 1 .and. Substr(cLine,nPos - 1,1) $ (' ' + "(" + "," + "{" + '+') ) 
			nPosFim := nPos + 8 
			cNomVar := Substr(cLine, nPos, nPosFim - nPos - 1)

			lEhStr := .T.

			If len(cNomVar) == 7

				For i := 7 to 4 Step -1
					If !IsDigit(Substr(cNomVar,i,1)) 
						lEhStr := .F. 
						Exit
					EndIf
				Next

			Else
				lEhStr := .F.
			EndIf

			If lEhStr

				nPosCom := At('//',cLine)
				
				If nPosCom > 0 
					//Quando tem comentario em variaveis STR, geralmente eh o conteudo da variavel STR				
					cTestStr	:= "'" + AllTrim(StrTran(StrTran(Substr(cLine,nPosCom + 2,len(cLine) - nPosCom),'"',''),"'",'')) + "'/*" + cNomVar + "*/"
				Else
					cTestStr	:= "'" + cNomVar + "'"
				EndIf
								
				//Coloco desta forma para nao dar erro na compilacao.
				cLine 		:= Stuff(cLine,nPos,nPosFim - nPos - 1,cTestStr)

				//Se alterei a linha, no While mais acima preciso buscar no fim da ultima alteracao
				nPos 		+= len(cTestStr)

			Else  
				//Incremento nPos caso nao seja uma STR para ele buscar na proxima coluna e nao ficar em loop
				++nPos 
			EndIf 

		Else
		 	//Incremento nPos caso nao seja uma STR para ele buscar na proxima coluna e nao ficar em loop
			++nPos	
		EndIf

	EndDo

EndIf

If lAjuste .and. nPosFunc <= 0

	oObj:SetRegua2(len(aFuncSubs))

    //Ajusta as chamadas das User Function dentro do fonte

	For i := 1 to len(aFuncSubs)
	
		oObj:IncRegua2('Buscando chamadas... ' + aFuncSubs[i])
		
		nPos := At(aFuncSubs[i],Upper(cLine)) 
		If nPos > 0 .and. ( Substr(cLine,nPos+len(AllTrim(aFuncSubs[i])),1) $ cAspas ) //Achou e o caracter + 1 eh vazio ou aspas
			cLine := Stuff(cLine,nPos,len(AllTrim(aFuncSubs[i])),'U_' + AllTrim(aFuncSubs[i]))					
		EndIf
	Next
	
Else

	//Transforma Function em User Function
    
	If nPosFunc > 0 .and. 	At('STATIC',Upper(cLine)) <= 0 .and. 					;
							At('USER',Upper(cLine)) <= 0 .and. 					;
							At('FINDFUNCTION',Upper(cLine)) <= 0 .and. 			;
							( At('\\',cLine) > nPosFunc .or. At('\\',cLine) <= 0 )
							
		cLine := Stuff(cLine,nPosFunc,len('Function'),'User Function') 
		aBuffer := StrTokArr(cLine,' ')

		nPosChave := At('(',aBuffer[3])

		If nPosChave > 0 
			aAdd(aFuncSubs,AllTrim(Upper(Left(aBuffer[3],nPosChave-1))))	
		Else
			aAdd(aFuncSubs,AllTrim(Upper(aBuffer[3])))
		EndIf
	EndIf  

EndIf

Return cLine    

*********************************************************************************

User Function ExTstVar

Local aVars := {}
Local cCod	:= '000555'
Local cName	:= 'Leonardo'
Local aTst	:= {'teste',{'teste'},{{123456789},{.T.},Nil}}

MsgInfo('Por algum motivo o BreakPoint não está funcionando. Use esta função para "debugar" inclusive vetores.')

aAdd(aVars,{'cCod'	,cCod	})
aAdd(aVars,{'cName'	,cName	})
aAdd(aVars,{'aTst'	,aTst	})

U_TstVar(aVars)

Return

**************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³aVars[nI][1] => Nome da variavel³
//³aVars[nI][2] => Variavel        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function TstVar(aVars)

Local cVar 		:= ""
Local cNomVar	:= ""
Local cRet		:= ""
Local nI   		:= 0
Local nJ		:= 0
Local nK		:= 0
Local cBmp1 	:= 'PMSEDT3'
Local cBmp2 	:= 'PMSEDT4'
Local lInicio	:= .T.
Local nPosVar	:= 0 
Local nPosDep	:= 0
Local o_Dlg     := Nil
Local o_DbTree	:= Nil 
Local aVarRet	:= {}
Local cNomFun	:= alltrim(funname())
Local cTitle	:= If(!empty(cNomFun)," Função: " + cNomFun + " - linha: " + alltrim(str(procline(1)))," ")
Local aFunc		:= {}

Private aType := {} // Para retornar a origem da função: FULL, USER, PARTNER, PATCH, TEMPLATE ou NONE
Private aFile := {} // Para retornar o nome do arquivo onde foi declarada a função
Private aLine := {} // Para retornar o número da linha no arquivo onde foi declarada a função
Private aDate := {} // Para retornar a data do código fonte compilado
                                   
If !u_lProtheus()
     return
EndIf

aFunc := getFuncArray(Upper(cNomFun), aType, aFile, aLine, aDate)               

cTitle += ' - Fonte: ' + aFile[1] + ' - Data Compilação: ' +  DtoC(aDate[1]) + ' - Declarada na linha: ' + aLine[1]

Define MsDialog o_Dlg Title cTitle From 0,0 to 240,500 Pixel

o_DbTree := DbTree():New(10,10,095,240,o_Dlg,{|| /*Botão esquerdo*/},{||/*Botão direito*/},.T.,.F.)

o_DbTree:SetScroll(1,.T.)//Habilita barra de rolagem horizontal. So aparece quando ultrapassa o tamanho do DbTree
o_DbTree:SetScroll(2,.T.)//Habilita barra de rolagem vertical. So aparece quando ultrapassa o tamanho do DbTree

For nI := 1 to len(aVars)
	
	cNomVar := aVars[nI][1]
	
	cVar 	:= Varinfo(cNomVar, aVars[nI][2])

	cVar := StrTran(cVar,'<br><br></pre><br>',CRLF)
	cVar := StrTran(cVar,'<br><br>',CRLF)
	cVar := StrTran(cVar,'<br>',CRLF)
	cVar := StrTran(cVar,'<pre>','')
	cVar := StrTran(cVar,'</pre>','')

	aVarRet := StrTokArr(cVar,chr(13)+chr(10))
    
	nPosVar	:= 0
    
	For nJ := 1 to len(aVarRet)

		If !empty(aVarRet[nJ])
		
			nPosVar := At(aVars[nI][1],aVarRet[nJ]) - 1
			
			If At('ARRAY',aVarRet[nJ]) > 0  
				o_DbTree:AddTree(AllTrim(aVarRet[nJ]) + Space(60),.T.,cBmp1,cBmp1,,,"1.0")
			ElseIf (len(aVarRet) >= nJ + 1) .and. (nPosDep := (At(aVars[nI][1],aVarRet[nJ + 1]) - 1)) < nPosVar
				o_DbTree:AddTreeItem(AllTrim(aVarRet[nJ]) + Space(60),cBmp2,,"1.1")
				For nK := nPosDep to (nPosVar - 5) Step 5
				 	o_DbTree:EndTree()	
				Next
			Else
				o_DbTree:AddTreeItem(AllTrim(aVarRet[nJ]) + Space(60),cBmp2,,"1.1")
			EndIf 
			
		EndIf                 

	Next

	o_DbTree:EndTree()

	cRet += 'Variavel: ' + cVar + CRLF

Next  

o_DbTree:EndTree()

Define SButton from 100,200 type 1 action o_Dlg:End() enable of o_Dlg

Activate MsDialog o_Dlg Center

Return 

**************************************************************

Static Function LogToNome

Local i := 0

Local aLog 		:= {}
Local cRet 		:= ""
Local cProcessa	:= ""

cProcessa := LogErros('','Decodifica USERGA e USERGI (Conteudo do campo: digite um em cada linha)',.F.)

If !empty(cProcessa) 

	aLog := Separa(cProcessa,CRLF,.F.)
	
	For i := 1 to len(aLog)
		cRet += aLog[i] + ' - ' + GavLeLog(aLog[i]) + CRLF	
	Next
	
	LogErros(cRet,'USERGA e USERGI decodificados')
	
Else 
	MsgStop('Informe os logs para serem decodificados!',SM0->M0_NOMECOM)
EndIf
	
Return 

************************************************************************************************
            
User Function MD5

Local cArq 			:= AllTrim( cGetFile( 'Arquivo TXT|*.txt','Selecione arquivo', 0, '\', .T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE ) )
Local cHash   		:= "" 
Local cBuffer  		:= "" 
Local cHashBuffer 	:= "" 
Local nBytesRead 	:= 0
Local nFileSize 	:= 0   
Local nInfile  		:= 0 
 
LOCAL F_BLOCK 		:= 512

aFile := Directory(cArq,"F")

If Len(aFile) > 0 
	nFileSize := aFile[1,2]/1048576
  
		If nFileSize > 0.9
			cHash := MD5File(cArq)
		Else
	        cBuffer  := Space(F_BLOCK)
	        nInfile  := FOpen(cArq, FO_READ)
		    nFileSize := aFile[1,2]//Tamnho em bytes

        	Do While nFileSize > 0
				nBytesRead := FRead(nInfile, @cBuffer, F_BLOCK)
				nFileSize -= nBytesRead
				cHashBuffer += cBuffer
	        EndDo
    
		    FClose(nInfile)
	   		//FErase(cArq)          
	   		//memoWrite("c:\hashB.txt",cHashBuffer)
	   		cHash := MD5(cHashBuffer,2)          
  		EndIf
Else
	MsgInfo("Não foi possivel fazer o calculo da hash. O arquivo "+cArq+ " não foi encontrado.")  
EndIf

LogErros(cHash,'MD5')
  
Return cHash

**********************************************************************************************************
             
User Function SIBHash

Private oProcess    := Nil 

oProcess := MsNewProcess():New({||PSIBHash()},'Hash SIB',"",.F.)
oProcess:Activate()

Return 

**********************************************************************************************************

Static Function PSIBHash

Local cHash 		:= ''
Local cDadosHash	:= ''
Local lConsidera	:= .F.
Local cArq 			:= AllTrim( cGetFile( 'Arquivo SBX|*.sbx','Selecione arquivo', 0, '\', .T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE ) )
Local cArqBackup	:= cArq
Local nPosIni		:= RAt('\',cArq)
Local nPosFim		:= RAt('.',cArq)
Local cNomeOri		:= Substr(cArq,nPosIni + 1,nPosFim - nPosIni - 1)
Local cNomeBackup	:= cNomeOri + '_bkp_' + DtoS(date())+ '_' + StrTran(Time(),':','')
Local nTamBuffer	:= 0 
Local lLimpaNImpr 	:= .F. 

cArqBackup := Stuff(cArqBackup,nPosIni + 1,len(cNomeOri),cNomeBackup)

If !empty(cArq)

	If !MoveFile(cArq,cArqBackup,.T.)
		Alert('Não foi possível fazer o backup do arquivo!') 
		Return
	Else
		nHdEscrita := FCreate(cArq)//Cria em branco 
		
		If ( nHdEscrita == -1 )
			Alert("Erro ao criar arquivo [ " + cArq + " ] - ferror " + Str(Ferror()))
			Return
		EndIf
	EndIf
	
	lLimpaNImpr := MsgYesNo('Deseja remover caracteres nao imprimiveis? Isto fará o programa demorar mais...')
	   
	// Abre o arquivo
	nHdLeitura := FT_FUse(cArqBackup)
	
	// Posiciona na primeira linha
	FT_FGoTop()  
	
	nCont 	:= FT_FLastRec()
	nI		:= 0
	
	// Posiciona na primeira linha
	FT_FGoTop() 
	
	oProcess:SetRegua1(nCont)
	
	While !FT_FEOF()
	
		oProcess:IncRegua1('Processando ' + StrZero(++nI,9) + ' de ' + StrZero(nCont,9) + ' linhas')
	
	  	cLine 		:= AllTrim(FT_FReadLn()) // Retorna a linha corrente
	    nTamBuffer 	:= len(cLine)
	    cLine 		:= If(lLimpaNImpr,AllTrim(cImprimiveis(cLine)),AllTrim(cLine))
	    
	    //hash vai ser escrito mais abaixo
	    If At('<hash>',lower(cLine)) <= 0
	    	FWrite(nHdEscrita,cLine,nTamBuffer) 
	    EndIf
	  	
	    If ( At('<epilogo>',lower(cLine)) > 0 ) .or. ( At('</epilogo>',lower(cLine)) > 0 )
			FT_FSKIP()
			loop  		
		EndIf
		
		nPosIni 	:= At('>',cLine)
	    nPosFim		:= At('</',cLine) 
	    nPosSchema	:= At('schemaLocation="',cLine)
	    
	    If At('<hash>',lower(cLine)) > 0
	    	lConsidera := .F.
	    ElseIf nPosSchema > 0
			cCandidato := Substr(cLine,nPosSchema + 16,At('">',cLine) - nPosSchema - 16)
	        lConsidera := .T.	
	    ElseIf At('>',cLine) < At('</',cLine)         
	    	cCandidato := Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
	        lConsidera := .T.          
	    Else
	    	lConsidera := .F.
	  	EndIf 
	  	
	  	If lConsidera
    		cDadosHash += cCandidato
		EndIf
		
		If At('<hash>',lower(cLine)) > 0
	    	//c_DadosHash := cImprimiveis(cDadosHash)
			cHash 	:= MD5(cDadosHash,2/*Hash em Hexa*/)
			nPosIni := At('>',cLine)
			nPosFim	:= At('</',cLine)
			cLine 	:= Stuff(cLine,nPosIni + 1,nPosFim - nPosIni - 1,cHash)

			FWrite(nHdEscrita,cLine,nTamBuffer) 
	    	//<hash>8ADF49BC99D6F95642EC093B2E958D5B</hash>
	    EndIf
	  	
		FT_FSKIP()
	  	
	EndDo
	
	// Fecha o Arquivo
	FCLOSE(nHdLeitura)
	FT_FUSE()
	
	FCLOSE(nHdEscrita)
	
	cMsg := ''
	cMsg += 'Arquivo backup [ ' + cArqBackup + ' ]'			 		+ CRLF
	cMsg += 'Arquivo alterado [ ' + cArq + ' ]' 		  			+ CRLF 
	cMsg += 'Arquivo alterado gerado com o hash [ ' + cHash + ' ]' 	+ CRLF 

	LogErros(cMsg,'MD5')
	
	LogErros(cDadosHash,'Dados utilizados na MD5')
Else
	Alert('Informe um arquivo!')
EndIf

Return	

*********************************************************************************************************88

User Function TSTMD5

//Local cArq	:= '\_SIB\SIB.txt'//AllTrim( cGetFile( 'Arquivo SBX|*.sbx','Selecione arquivo', 0, '\', .T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE ) )
Local cArq	:= '\_SIB\hash33.sbx'
Local cTxt 	:= LogErros(,'MD5',.F.)

If !File(cArq)
	Alert('Arquivo ' + cArq + ' nao encontrado')
	Return
EndIf

LogErros(MD5(cTxt,2),'MD5')

LogErros(MD5File(cArq,2),'MD5File')

Return   

*********************************************************************************************************

//Retorna string com os caracteres imprimiveis somente
Static Function cImprimiveis(cCodigo)

Local nJ := 0

Local aImprimiveis 	:= {}
Local cImprimiveis 	:= 'abcdefghijklmnopqrstuvwxyzáéíóúâêîôû' //Alfabeto e vogais com acento agudo e circunflexo

cImprimiveis += Upper(cImprimiveis) + ' 0123456789/\|*-+.,"!@#$%&():;<>!?=' + "'"

oProcess:SetRegua2(len(cImprimiveis) + 256)

For nJ := 0 to len(cImprimiveis)
	oProcess:IncRegua2("Retirando caracteres nao imprimiveis")
	aAdd(aImprimiveis,ASC(Substr(cImprimiveis,nJ,1)))
Next

For nJ := 0 to 255
    oProcess:IncRegua2("Retirando caracteres nao imprimiveis")
	//Se tiver um que nao e imprimivel mas esta no texto, dou replace para vazio
	If ( aScan(aImprimiveis,nJ) <= 0 ) .and. ( At(chr(nI),cCodigo) > 0 )
		cCodigo := StrTran(cCodigo,chr(nJ),'')
		//cRet += 'ASCII [ ' + cValToChar(nI) + ' ] - Caracter [ ' + chr(nI) + ' ] - Primeira ocorrencia [ ' + cValToChar(At(chr(nI),cCodigo)) + ' ]' + CRLF
	EndIf 
	
Next

Return cCodigo