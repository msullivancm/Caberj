#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCDCPTCTB  บ Autor ณ Jean Schulz        บ Data ณ  09/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Tela para cadastro de fechamento contabil.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CDCPTCTB()        

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cVldAlt := "u_infCusto('I')" // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
  
//Leonardo Portella - 21/05/11 - Gravacao do log de alteracao e inclusao
Local bNoTTS  := {||If(INCLUI,GrvLogBl('I'),If(ALTERA,GrvLogBl('A'),))}	

//Leonardo Portella - 20/05/11 - Nao sera permitido excluir. Ao inves disso podera abrir o fechamento.
//Local cVldExc := "u_infCusto('E')" // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Local cVldExc := "u_infCusto('X')"

Private cString 	:= "SZ9"  

//Leonardo Portella - 21/05/11	 
//bPre -> bloco de codigo executado antes de abrir a tela de inclusao/alteracao/exclusao. Usado para pegar o status antes da altercao
Private cStatusAnt	:= SZ9->Z9_STATUS
Private bPre 		:= {||cStatusAnt := SZ9->Z9_STATUS}

dbSelectArea("SZ9")                                          

dbSetOrder(1)
                            
//Leonardo Portella - 21/05/11 - Alteracao do AxCadastro para executar o bloco de codigo da gravacao do 
//log de alteracao e inclusao apos ter confirmado e ja gravado as alteracoes na SZ9.
AxCadastro(cString,"Cadastro de fechamento contabil",cVldExc,cVldAlt,,bPre,,,bNoTTS)
//AxCadastro(cString,"Cadastro de fechamento contabil",cVldExc,cVldAlt)

Return              

*****************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCDCPTCTB  บ Autor ณ Marcela Coimbra    บ Data ณ  09/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo responsแvel por enviar e-mail informando a          บฑฑ
ฑฑบ          ณ Inclusใo/Altera็ใo e gerar os dados no Log.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function infCusto( n_Tipo )

Local a_Vet 	:= {}  
Local a_Msg 	:= {}  
Local a_Htm 	:= "\HTML\LOGCUS.HTML"   
Local c_To 		:= GetMv("MV_XMLCUST") 
Local c_CC 	    := " "
Local c_TpMov 	:= " "
Local c_Acao 	:= " "
Local c_Comp	:= M->Z9_MESCTB + "/" + M->Z9_ANOCTB
Local c_Assunto := " "

//Leonardo Portella - 20/05/11 - Inicio
//Nao sera permitido excluir. Ao inves disso podera abrir o fechamento.

Local lOk := .T.
                        
If n_Tipo == "X"

	Aviso('ATENวยO','Nใo ้ permitida a exclusใo do bloqueio. Ao inv้s disso utilize a op็ใo abrir/fechar (alterando o bloqueio).',{'Ok'})
	lOk := .F.

ElseIf M->Z9_STATUS <> SZ9->Z9_STATUS

//Leonardo Portella - 20/05/11 - Fim

	c_TpMov 	:= IIF( M->Z9_STATUS <> "A", " fechamento", "abertura")              
	c_Acao 		:= IIF( M->Z9_STATUS <> "A", " fechou", "abriu")              
	c_Assunto 	:= "Aviso de " + c_TpMov + " de custo da competencia " + c_Comp + ". "

	**'-- Grava็ใo de Log ------------------'**
	
	dbSelectArea("SZ9")
	
	aadd(a_Vet, "SZ9")                               	
	aadd(a_Vet, strzero( SZ9->( Recno() ), 10 ) )
	aadd(a_Vet, n_Tipo )
	aadd(a_Vet, " " )   
	
	// Fun็ใo gen้rica encontrada no arquico FUNCSGENERICAS.prw
	u_gGravaLog( a_Vet )                         
	
	**'-- Envio de e-mail ------------------'**
	
	aadd( a_Msg, { "c_Emp"		, SM0->M0_NOME+"/"+SM0->M0_FILIAL})//Marcela Coimbra - 27/04/10
	
	aadd( a_Msg, { "c_IncExc"	, c_TpMov 					})
	aadd( a_Msg, { "c_MesCus"	, c_Comp 					})
	aadd( a_Msg, { "c_NomeUsu"	, USRFULLNAME( __cUserId ) 	})
	aadd( a_Msg, { "c_Acao"		, c_Acao 					})
	aadd( a_Msg, { "c_DataMov"	, dtoc( Date() )			})
	
	// Fun็ใo gen้rica encontrada no arquico FUNCSGENERICAS.prw
	u_GEnvMail(a_Htm, c_To, c_CC, c_Assunto, a_Msg )

EndIf //Leonardo Portella - 20/05/11
	
Return lOk //.T.               

*****************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvLogBl  บAutor  ณLeonardo Portella   บ Data ณ  21/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para gravar o log de alteracao e inclusao do bloqueioบฑฑ
ฑฑบ          ณcontabil off-line.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GrvLogBl(cOpcao)

dbSelectArea('PAN')
dbSetOrder(1)

RecLock('PAN',.T.) 

PAN->PAN_FILIAL := xFilial('PAN')
PAN->PAN_RECSZ9 := SZ9->(Recno())
PAN->PAN_DTALTE	:= dDataBase
PAN->PAN_HRALTE	:= time()
PAN->PAN_USRALT	:= RetCodUsr()
PAN->PAN_STAALT	:= SZ9->Z9_STATUS
PAN->PAN_CORTAL	:= SZ9->Z9_CORTE
PAN->PAN_TIPO	:= cOpcao                            

MsUnlock() 

If SZ9->Z9_STATUS == 'F'

	dbSelectArea('SZ9')
	
	RecLock('SZ9',.F.)
	
	SZ9->Z9_FECHOU := 'S'
	
	MsUnlock()

EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSe estiver alterando o bloqueio e o status atual for  ณ
//ณ'Aberto' e o status anterior for 'Fechado', executa a ณ
//ณantiga rotina que era executada na hora da exclusao   ณ
//ณe que envia e-mail para os interessados na reabertura ณ
//ณdo bloqueio.                                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If cOpcao != 'A' .and. SZ9->Z9_STATUS == 'A' .and. cStatusAnt == 'F'

	u_infCusto('E')
      
EndIf

Return 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLeonardo Portella - Raquel Casemiro - 02/04/13 - Validacao dosณ
//ณusuarios autorizados a alterar o fechamento contabil.         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

User Function lValFech

Local lOk := ( RetCodUsr() $ ( GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN') + '|' + GetNewPar('MV_XFECON',' ') ) )

Return lOk

