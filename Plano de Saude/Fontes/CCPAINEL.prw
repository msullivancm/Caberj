#include "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCCPAINEL  บMotta  ณCaberj              บ Data ณ  06/13/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Chama a pแgina ASP do Painel de Interna็๕es da Sa๚de      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObs       ณPara utilizar esta classe, no TOTVS Smart Client,           บฑฑ
ฑฑบ          ณ้ necessแrio incluir,no arquivo de configura็ใo do TOTVS    บฑฑ
ฑฑบ          ณSmart Client (*.INI), a chave BrowserEnabled=1.             บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CCPAINEL()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort

	DEFINE DIALOG oDlg TITLE "Painel" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL
	
	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, 0,0,aSize[3],aSize[5]/3.0,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/InternacoesLib.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return

User Function CCPABENAV()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
	
	DEFINE DIALOG oDlg TITLE "Painel ABENAV" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, 0,0,aSize[3],aSize[5]/3.0,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/InternacoesLib_Est.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
Return

//OPME
User Function CCPAIOPM()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
		
	DEFINE DIALOG oDlg TITLE "Painel OPME" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, 0,0,aSize[3],aSize[5]/3.0,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/Internacoesopme.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
Return

//REEMBOLSO
User Function CCPAIREE()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
	
	DEFINE DIALOG oDlg TITLE "Painel Reembolso" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, 0,0,aSize[3],aSize[5]/3.0,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/Reembolso.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return

//BO
User Function CCPAIBO()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort

	DEFINE DIALOG oDlg TITLE "Painel BO" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL
	
	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/BO.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return

//UNAT
User Function CPAIUNAT(pMatricula)
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
		
	DEFINE DIALOG oDlg TITLE "Folha de Rosto" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/FolhaRosto.asp?vMatric="+pMatricula)
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
Return

//INADIMP
User Function CPAIINAD()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
	
	DEFINE DIALOG oDlg TITLE "Posi็ใo de Inadimpl๊ncia" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/Inadimplencia.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return  

//PAINEL DE PAGAMENTO FORNECEDORES      
// SERGIO CUNHA - 02/02/2016 - CHAMADO 24076
User Function CPAIPGRDA()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort
	
	DEFINE DIALOG oDlg TITLE "Posi็ใo Pagamento Fornecedores" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/PAGAMENTOSFORNECEDORES.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return     
//PAINEL DE PAGAMENTO DE COMISSOES
// SERGIO CUNHA - 06/06/2016 
User Function CPAIPGCOM()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort	
	
	DEFINE DIALOG oDlg TITLE "Posi็ใo Pagamento Comissใo" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/PAGAMENTOSCOMISSAO.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return            
//PAINEL DE PROTOCOLO DE ATENDIMENTO
// SERGIO CUNHA - 16/06/2016 
User Function CPAIPA()
	//Angelo Henrique - Data:05/10/2015
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort	
	
	DEFINE DIALOG oDlg TITLE "Painel Protocolo de Atendimento" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/ProtocoloAtend.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return

//PAINEL DE OPME NOVO
User Function CPOPME()
	// Angelo Henrique - Data:04/07/2017 
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort	
		
	DEFINE DIALOG oDlg TITLE "Painel Interna็ใo OPME" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/internacoesopmew.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return  

//PAINEL DE OPME NOVO
// Roberto Meirelles - Data:14/08/2017 
User Function CPCALEND()
	// Angelo Henrique - Data:04/07/2017 
	Local aSize		:= MsAdvSize()
	
    PRIVATE oWebChannel 
    PRIVATE oWebEngine 
	PRIVATE nPort	
		
	DEFINE DIALOG oDlg TITLE "Painel Interna็๕es Calendarizadas" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL

	// Prepara o conector WebSocket
    PRIVATE oWebChannel := TWebChannel():New()
    nPort := oWebChannel::connect()
    
    // Cria componente
    PRIVATE oWebEngine := TWebEngine():New(oDlg, aSize[7]/2,0, aSize[6],aSize[5]/4.5,, nPort)
    oWebEngine:bLoadFinished := {|self,url| conout("Termino da carga do pagina: " + url) }
    oWebEngine:navigate("http://relatorios.caberj.com.br/Cac/InternacoesAgendadasw.asp")
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT

	TButton():New( aSize[7],0, "Imprimir", oDlg,;
		{|| oWebEngine:PrintPDF() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )

	ACTIVATE DIALOG oDlg CENTERED
Return

