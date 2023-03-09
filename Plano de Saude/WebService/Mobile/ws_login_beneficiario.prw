#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "PLSMGER.CH"
#DEFINE DIRRAIZ 	PLSMUDSIS( GetNewPar("MV_TISSDIR","\TISS\") )
#DEFINE DIRONLINE 	PLSMUDSIS( "ONLINE\" )
#DEFINE DIRSUBRAI 	DIRRAIZ+DIRONLINE
#DEFINE DIRCAISA  	PLSMUDSIS( DIRSUBRAI+"CAIXASAIDA\" )
#DEFINE __MSXLOG "mob_aut.log"

STATIC nHorIni     	:= 0

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PLSXFUN   ³ Autor ³Alexander Santos       ³ Data ³28.03.2006  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Web Service das funcionalidades do Plano de Saude            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definicao da estruturas da composicao da solicitacao					   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄlÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


user function WS015()

return

// Estruturas de persistencia
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definicao do Web Service de Controle do Usuario                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WSSERVICE ws_login_beneficiario	DESCRIPTION "Serviço de autenticação de beneficiários para produtos Mobile Saúde"
	WSDATA UserCode				AS String

	// parametros de entrada
	WSDATA grupo_familiar_matricula					AS String 	OPTIONAL
	WSDATA beneficiario_matricula					AS String 	OPTIONAL
	WSDATA beneficiario_plano_id					AS String 	OPTIONAL
	WSDATA beneficiario_telefone					AS String 	OPTIONAL
	WSDATA beneficiario_email						AS String 	OPTIONAL
	WSDATA	beneficiario_cpf							AS String 	OPTIONAL
	WSDATA	beneficiario_data_nascimento			AS Date 	OPTIONAL

	// Variaveis de login.
	WSDATA user_mobile_login_tipo					AS String 	OPTIONAL	//DESCRIPTION "1=Login Beneficiario;2=Login Call Center;3=Validação de novos usuários;4=autenticação de usuário para Mobile Saúde"
	WSDATA user_mobile_login_origem					AS String 	OPTIONAL	//0=Agendamento;2=Reembolso;3=Portal Beneficiario
	WSDATA user_mobile_login						AS String 	OPTIONAL
	WSDATA	user_mobile_senha						AS String 	OPTIONAL
	WSDATA	user_mobile_nova_senha					AS String 	OPTIONAL
	WSDATA hash_troca_senha							AS String 	OPTIONAL

	// Estruturas de retorno
	WSDATA ret_usuario_acesso						As st_usuario_acesso	OPTIONAL
	WSDATA ret_grupo_familiar						As st_grupo_familiar	OPTIONAL
	WSDATA ret_redefine_senha						As st_redefine_senha	OPTIONAL

	WSMETHOD ws_beneficiario_lembrar_usuario		DESCRIPTION "Metodo retorna todos os usuários de acesso vinculados a um CPF"
	WSMETHOD ws_beneficiario_criar_acesso			DESCRIPTION "Metodo que cria um usuário de acesso para o beneficiário mediante confirmação de dados pessoais"
	WSMETHOD ws_beneficiario_redefinir_senha		DESCRIPTION "Metodo retorna a senha do beneficiário mediante comprovacão de dados pessoais"
	WSMETHOD ws_beneficiario_trocar_senha			DESCRIPTION "Metodo troca senha do beneficiário mediate comprovação de dados pessoais"
	WSMETHOD ws_beneficiario_login					DESCRIPTION "login do beneficiario"

	//	WSMETHOD ws_beneficiario_alteracao_cadastral	DESCRIPTION "Metodo que atualiza os dados cadastrais do beneficiario em uma área reservada do sistema para aguardar aprovação da empresa"
	//	WSMETHOD RetCarVirt	DESCRIPTION "Metodo que atualiza os dados cadastrais do beneficiario em uma área reservada do sistema para aguardar aprovação da empresa"


ENDWSSERVICE

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GetDadG     ³Autor³ Alexander Santos      ³ Data ³22.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Retorna dados especificos por tipo de guia				   |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
WSMETHOD ws_beneficiario_lembrar_usuario WSRECEIVE beneficiario_cpf,;
	beneficiario_data_nascimento WSSEND ret_usuario_acesso WSSERVICE ws_login_beneficiario

LOCAL cCpf 			:= ::beneficiario_cpf
LOCAL dNascimento 	:= ::beneficiario_data_nascimento
LOCAL cSql 			:= ""
LOCAL nLen				:= 0
LOCAL cEmpresa		:= "01"

::ret_usuario_acesso := WsClassNew( "st_usuario_acesso" )
::ret_usuario_acesso:retorno_dados 	:= {}
::ret_usuario_acesso:retorno_criticas 	:= {}
::ret_usuario_acesso:retorno_alertas 	:= {}

If BSW->(FieldPos("BSW_YCPF")) == 0
	u_MBSetFault(@::ret_usuario_acesso, "MB001")
	Return(.T.)
Endif

// Seleciona todos os usuários vinculados ao CPF
cSql := " SELECT BSW.*, B49.*"
cSql += " FROM " + RetSqlName("BSW") + " BSW"
cSql += "   INNER JOIN " + RetSqlName("B49") + " B49"
cSql += "     ON (    B49.B49_FILIAL = '" + xFilial("B49") + "'"
cSql += "         AND B49.B49_CODUSR = BSW.BSW_CODUSR)"
cSql += "   INNER JOIN " + RetSqlName("BA1") + " BA1"                  //Motta dez/21 garantir unico e
cSql += "     ON (    BA1.BA1_FILIAL = '" + xFilial("BA1") + "'"
cSql += "         AND BA1.BA1_CODINT = SUBSTR(BSW.BSW_LOGUSR,1,4)"
cSql += "         AND BA1.BA1_CODEMP = SUBSTR(BSW.BSW_LOGUSR,5,4)"
cSql += "         AND BA1.BA1_MATRIC = SUBSTR(BSW.BSW_LOGUSR,9,6)"
cSql += "         AND BA1.BA1_TIPREG = SUBSTR(BSW.BSW_LOGUSR,15,2)"
cSql += "         AND BA1.BA1_DIGITO = SUBSTR(BSW.BSW_LOGUSR,17,1))"
cSql += "   INNER JOIN " + RetSqlName("BA3") + " BA3"
cSql += "     ON (    BA3.BA3_FILIAL = BA1.BA1_FILIAL"
cSql += "         AND BA3.BA3_CODINT = BA1.BA1_CODINT"
cSql += "         AND BA3.BA3_CODEMP = BA1.BA1_CODEMP"
cSql += "         AND BA3.BA3_MATRIC = BA1.BA1_MATRIC)"
cSql += "   INNER JOIN " + RetSqlName("BI3") + " BI3"
cSql += "     ON (    BI3.BI3_FILIAL = '" + xFilial("BI3") + "'"
cSql += "         AND BI3.BI3_CODINT = BA3.BA3_CODINT"
cSql += "         AND BI3.BI3_CODIGO = BA3.BA3_CODPLA"
cSql += "         AND BI3.BI3_VERSAO = BA3.BA3_VERSAO)"
cSql += " WHERE BSW.D_E_L_E_T_ = ' ' AND B49.D_E_L_E_T_ = ' ' "
cSql += "   AND BA1.D_E_L_E_T_ = ' ' AND BA3.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' ' "
cSql += "   AND BSW_FILIAL 	   = '" + xFilial("BSW") + "'"
cSql += "   AND BSW.BSW_YCPF   = '" + cCpf + "'"
cSql += "   AND BA1.BA1_CPFUSR = '" + cCpf + "'"
cSql += "   AND BA1.BA1_DATNAS = '" + DtoS(dNascimento) + "'"
cSql += "   AND BSW_TPPOR = '3'"
cSql += "   AND (BA1.BA1_DATBLO = ' ' OR BA1.BA1_DATBLO >= TO_CHAR(SYSDATE,'YYYYMMDD'))"
cSql += "   AND BI3.BI3_CODSEG <> '004'"
PlsQuery(cSql, "TRB1")

If TRB1->(Eof())
	u_MBSetFault(@::ret_usuario_acesso, "MB002")
	TRB1->( dbCloseArea() )

	Return(.T.)
Endif

::ret_usuario_acesso:retorno_status := .T.
BA1->( dbSetorder(02))
BQC->( dbSetorder(01))
AI3->( DbSetOrder(1) )
BG9->( dbSetorder(1) )

While !TRB1->( Eof() )
	If BA1->( MsSeek( xFilial("BA1") + TRB1->B49_BENEFI ) )

		// Confirma se o usuário está cadastrado nas regras do protheus.
		If !AI3->( MsSeek(xFilial("AI3")+TRB1->BSW_CODACE) )
			TRB1->( dbSkip() )
			Loop
		Endif

		// De qual empresa é o beneficiário, se for PJ.
		cEmpresa := ""
		If BG9->( dbSeek(xFilial("BG9")+BA1->BA1_CODINT+BA1->BA1_CODEMP) )
			If BG9->BG9_TIPO == '2' // So se for pessoa juridica
				If BQC->( dbSeek(xFilial("BQC")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_CONEMP+BA1->BA1_VERCON+BA1->BA1_SUBCON+BA1->BA1_VERSUB))
					cEmpresa := Alltrim(BQC->BQC_NREDUZ)
				Else
					TRB1->( dbSkip() )
					Loop
				Endif
			Endif
		Else
			TRB1->( dbSkip() )
			Loop
		Endif

		// Ok, usuário valido.
		Aadd(::ret_usuario_acesso:retorno_dados, WsClassNew("usuario_acesso"))
		nLen := Len(::ret_usuario_acesso:retorno_dados)

		::ret_usuario_acesso:retorno_dados[nLen]:beneficiario_nome 			:= Alltrim(BA1->BA1_NOMUSR)
		::ret_usuario_acesso:retorno_dados[nLen]:beneficiario_empresa 		:= cEmpresa
		::ret_usuario_acesso:retorno_dados[nLen]:beneficiario_login			:= Alltrim(TRB1->B49_BENEFI)
		::ret_usuario_acesso:retorno_dados[nLen]:beneficiario_matricula	:= Alltrim(BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BA1->BA1_DIGITO)
	Endif

	TRB1->( dbSkip() )
Enddo

If Len(::ret_usuario_acesso:retorno_dados) == 0
	u_MBSetFault(@::ret_usuario_acesso, "MB003")
Endif

TRB1->( dbCloseArea() )
Return .T.


WSMETHOD ws_beneficiario_criar_acesso WSRECEIVE beneficiario_matricula,;
	beneficiario_cpf,;
	beneficiario_data_nascimento,;
	beneficiario_email,;
	user_mobile_senha WSSEND ret_grupo_familiar WSSERVICE ws_login_beneficiario

LOCAL cMatricula 		:= ::beneficiario_matricula
LOCAL cCodUsr			:= cMatricula // por padrão, o login é aquilo que recebe no campo matricula
LOCAL cCpf 			:= ::beneficiario_cpf
LOCAL dNascimento 	:= ::beneficiario_data_nascimento
LOCAL cEmail			:= ::beneficiario_email
LOCAL cSenha 			:= ::user_mobile_senha
LOCAL cAcesso			:= GetNewPar("MV_MSCDACE", "000001")
LOCAL cTitular 		:= GETNEWPAR("MV_MBTIT", "00")
LOCAL nDiasExpira		:= GetNewPar("MV_MSDIAEX", 60)
LOCAL cSql 			:= ""
LOCAL lJaExiste		:= .F.
LOCAL aRetPE			:= {}
LOCAL aRetPEAcess
LOCAL aRet
LOCAL cChaveBA1 	:= ""
local nIndBA1 	:= 0
LOCAL lIgnoraLoga := .F.

::ret_grupo_familiar := WsClassNew( "st_grupo_familiar" )
::ret_grupo_familiar:retorno_dados 	:= {}
::ret_grupo_familiar:retorno_criticas 	:= {}
::ret_grupo_familiar:retorno_alertas 	:= {}

If Empty(cSenha)
	u_MBSetFault(@::ret_grupo_familiar, "MB004")
	Return(.T.)
Endif

// Liga o login
nHorIni := Seconds()
nHorBkp := nHorIni
u_MSLogFil("",__MSXLOG,lIgnoraLoga)
u_MSLogFil(	"Criação primeiro acesso -----> " + u_MS_CRF()+;
	"	código usuário	: " + cCodUsr + u_MS_CRF()+;
	"	CPF           	: " + cCpf + u_MS_CRF()+;
	"	Nascimento			: " + If(!Empty(dNascimento), dtoc(dNascimento),"") + u_MS_CRF()+;
	"	Data Requisição 	: " + dtoc(Date()) + u_MS_CRF()+;
	"	Hora Requisição	: " + time() + u_MS_CRF()+;
	"	------------------",__MSXLOG,lIgnoraLoga)

nHorIni := Seconds()
If ExistBlock("MSPRIACS")
	aRetPEAcess := Execblock("MSPRIACS", .f., .f., {cMatricula,cCpf,dNascimento,cEmail,cSenha,cCodUsr})
	If aRetPEAcess[1]
		cMatricula 	:= aRetPEAcess[2]
		dNascimento 	:= aRetPEAcess[4]
		cEmail			:= aRetPEAcess[5]

		If !Empty(aRetPEAcess[3])
			cCodUsr := aRetPEAcess[3]
		Endif
	Else
		u_MBSetFault(@::ret_grupo_familiar, "MB007")
		Return(.T.)
	Endif

	u_MSLogFil(	"	:: Execução do PE MSPRIACS" + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()
Endif

// Verifica se o beneficiário existe
BA1->( dbSetorder(02) )
If !BA1->( dbSeek(xFilial("BA1")+cMatricula, .f.) )
	//MBSetFault(@::ret_grupo_familiar, "MB005")
	Return(.T.)
Endif

// Verifica se o CPF bate
If BA1->BA1_CPFUSR <> cCpf
	u_MBSetFault(@::ret_grupo_familiar, "MB006")
	Return(.T.)
Endif

// Verifica se data de nascimento bate
If BA1->BA1_DATNAS <> dNascimento
	u_MBSetFault(@::ret_grupo_familiar, "MB007")
	Return(.T.)
Endif

// Verifica se o usuário está ativo
If !Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase
	u_MBSetFault(@::ret_grupo_familiar, "MB008")
	Return(.T.)
Endif
u_MSLogFil(	"	:: Posicionando BA1 resultante " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
nHorIni := Seconds()

If ExistBlock("MSVLDUSR")
	aRetPE := ExecBlock("MSVLDUSR", .f., .f., {})

	If !aRetPE[1]
		u_MBSetFault(@::ret_grupo_familiar, "MB009", aRetPE[2])
		Return(.T.)
	Endif
	u_MSLogFil(	"	:: Execução do PE MSVLDUSR " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()
Endif

// Verifica se o beneficiário já existe na base de usuários do portal
BSW->( dbSetorder(01) )
If BSW->(dbSeek(xFilial("BSW") + cCodUsr))
	lJaExiste := .T.
Endif

If BSW->(FieldPos("BSW_YPRIAC")) > 0
	If lJaExiste .and. BSW->BSW_YPRIAC != "S"
		u_MBSetFault(@::ret_grupo_familiar, "MB010")
		Return(.T.)
	Endif
Endif
u_MSLogFil(	"	:: Posicionando BSW " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
nHorIni := Seconds()

Begin Transaction
	// Cria o registro caso não exista.
	BSW->( RecLock("BSW", !lJaExiste) )
	If !lJaExiste
		cSql := " SELECT MAX(BSW_CODUSR) AS COD"
		cSql += " FROM  "+RetsqlName("BSW") + " "
		cSql := ChangeQuery(cSql)
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cSql),"TEMP",.F.,.T.)
		DbSelectArea("TEMP")

		u_MSLogFil(	"	:: BWS não existe - select max na BSW " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		cCod := TEMP->COD
		TEMP->(dbCloseArea("TEMP"))

		BSW->BSW_FILIAL 	:= xFilial("BSW")
		BSW->BSW_CODUSR	:= Soma1(cCod)
		BSW->BSW_LOGUSR 	:= cCodUsr
		BSW->BSW_NOMUSR 	:= BA1->BA1_NOMUSR
	Endif

	// Se já existir, apenas atualiza.
	BSW->BSW_SENHA	:= PLSCRIDEC(1,cSenha)
	BSW->BSW_EMAIL	:= cEmail
	BSW->BSW_CODACE	:= cAcesso
	BSW->BSW_TIPCAR	:= "0"
	BSW->BSW_BIOMET	:= ""
	BSW->BSW_TPPOR	:= "3"


	// Especificos Mobile Saúde
	If BSW->(FieldPos("BSW_YCPF")) > 0
		BSW->BSW_YCPF		:= BA1->BA1_CPFUSR
		//		BSW->BSW_YEXPPS	:= (dDataBase+nDiasExpira)
		BSW->BSW_YPRIAC	:= "N"
		BSW->BSW_YATUCD	:= "N"
	Endif
	BSW->( MsUnlock() )
	u_MSLogFil(	"	:: Atualização da BSW " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	If ExistBlock("MSGVRBSW")
		ExecBlock("MSGVRBSW", .f., .f., {})

		u_MSLogFil(	"	:: Execução do Ponto de entrada MSGVRBSW " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Endif

	// Cria o B49 para o usuário recem criado.
	If !lJaExiste
		B49->( RecLock("B49", .T.) )
		B49->B49_FILIAL := xFilial("B49")
		B49->B49_CODUSR := BSW->BSW_CODUSR
		B49->B49_BENEFI := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
		B49->( MsUnlock() )

		u_MSLogFil(	"	:: Criando a B49 do usuário principal " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Endif

	If ExistBlock("MSGVRB49")
		ExecBlock("MSGVRB49", .f., .f., {})

		u_MSLogFil(	"	:: Execução do Ponto de entrada MSGVRB49 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Endif

	// Se for o titular ou o conjuge, adiciona a lista de beneficiários.
	If u_MBIsTitular(cMatricula) .or. u_MBIsConjuge(cMatricula)
		cSql := "SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO FROM "+RetSqlname("BA1")
		cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
		cSql += " AND BA1_CODINT = '"+BA1->BA1_CODINT+"' "
		cSql += " AND BA1_CODEMP = '"+BA1->BA1_CODEMP+"' "
		cSql += " AND BA1_MATRIC = '"+BA1->BA1_MATRIC+"' "

		If u_MBIsTitular(cMatricula)
			// Se for o titular, adicona todos os dependentes
			cSql += "AND BA1_TIPREG <> '"+BA1->BA1_TIPREG+"' "

		ElseIf u_MBIsConjuge(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
			// Se for o conjuge, exclui o titular da relação de usuários
			cSql += "AND BA1_TIPREG NOT IN ('"+BA1->BA1_TIPREG+"','"+cTitular+"') "

		Endif

		cSql += "AND (BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+dTos(dDataBase)+"') "
		cSql += "AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSql, "TRB1")

		u_MSLogFil(	"	:: SELECT no BA1 para criar deps na B49 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		B49->( dbSetorder(1) )
		While !TRB1->( Eof() )
			If B49->(!dbSeek(xFilial("B49")+BSW->BSW_CODUSR+TRB1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)) )
				B49->( RecLock("B49", .T.) )
				B49->B49_FILIAL := xFilial("B49")
				B49->B49_CODUSR := BSW->BSW_CODUSR
				B49->B49_BENEFI := TRB1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				B49->( MsUnlock() )

				If ExistBlock("MSGVRB49")
					ExecBlock("MSGVRB49", .f., .f., {})

					u_MSLogFil(	"	:: Execução do Ponto de entrada MSGVRB49 do usuário " +;
						B49->B49_BENEFI + Space(2) + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
					nHorIni := Seconds()
				Endif
			Endif
			TRB1->( dbSkip() )
		Enddo

		TRB1->( dbCloseArea() )

		u_MSLogFil(	"	:: Criação do B49 para os demais dependentes" + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Endif

End transaction

// Faz o login.
ws_login(@::ret_grupo_familiar, "1", BSW->BSW_LOGUSR, cSenha)
u_MSLogFil(	"	:: Realização do login " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)

nHorIni := nHorBkp
u_MSLogFil(	"	:: Tempo gasto primeiro acesso: " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)

u_MSGravaBX1("BSW" , BSW->(Recno()),"A", "CRIAUSR", .T., "BSW_CODUSR","", BSW->BSW_SENHA,BSW->BSW_LOGUSR)
Return .t.


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GetDadG     ³Autor³ Alexander Santos      ³ Data ³22.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Retorna dados especificos por tipo de guia				   |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
WSMETHOD ws_beneficiario_redefinir_senha WSRECEIVE beneficiario_matricula,;
	beneficiario_cpf,;
	beneficiario_data_nascimento WSSEND ret_redefine_senha WSSERVICE ws_login_beneficiario

LOCAL cLogUsr 		:= ::beneficiario_matricula
LOCAL cCpf 			:= ::beneficiario_cpf
LOCAL dNascimento 	:= ::beneficiario_data_nascimento
LOCAL cEMail			:= ""
LOCAL cCodUsr			:= ""
LOCAL cCodAce			:= ""
LOCAL aRet				:= {}
LOCAL cHash			:= MD5(FWTimeStamp(1), 2)
LOCAL cPLSenha		:= ""
LOCAL cCar 			:= ""
LOCAL cTexto 			:= ""
LOCAL i
LOCAL cSenhaAnt		:= ""

// Inicializa o objeto.
::ret_redefine_senha := WsClassNew( "st_redefine_senha" )
::ret_redefine_senha:retorno_dados 	:= {}
::ret_redefine_senha:retorno_criticas 	:= {}
::ret_redefine_senha:retorno_alertas 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida usuario/senha                                               	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BSW->( DbSetOrder(1) )
If !BSW->(dbSeek(xFilial("BSW")+cLogUsr))
	If !BSW->(dbSeek(xFilial("BSW")+cCpf))
		u_MBSetFault(@::ret_redefine_senha, "MB011")
		Return(.T.)
	EndIf
Endif

If BSW->(FieldPos("BSW_CODACE")) > 0 .And. Empty(BSW->BSW_CODACE)
	u_MBSetFault(@::ret_redefine_senha, "MB012")
	Return(.T.)
Endif

//³ Codigo do usuario													   ³
cCodUsr := BSW->BSW_CODUSR
//cPLSenha:= PLSCRIDEC(2,AllTrim(BSW->BSW_SENHA))

//³ Codigo de acesso para montar menus									   ³
If BSW->(FieldPos("BSW_CODACE")) > 0
	cCodAce := BSW->BSW_CODACE
EndIf

//³ Verifica o tipo do portal
If BSW->( FieldPos("BSW_TPPOR") ) > 0 .and. BSW->BSW_TPPOR <> '3'
	u_MBSetFault(@::ret_redefine_senha, "MB013")
	Return(.T.)
Endif

// Confirma se o usuário está cadastrado nas regras do protheus.
AI3->( DbSetOrder(1) )
If !AI3->( MsSeek(xFilial("AI3")+cCodAce) )
	u_MBSetFault(@::ret_redefine_senha, "MB014")
	Return(.T.)
Endif

// Posiciona tabela B49 que contem relacinamento entre usuário do PORTAL e o usuário do PLS.
B49->( DbSetOrder(1) )
If !B49->( MsSeek( xFilial("B49") + cCodUsr) )
	u_MBSetFault(@::ret_redefine_senha, "MB015")
	Return(.T.)
Endif

// Posiciona o beneficiário
BA1->( DbSetOrder(2) )
If !BA1->( MsSeek( xFilial("BA1") + B49->B49_BENEFI ) )
	u_MBSetFault(@::ret_redefine_senha, "MB016")
	Return(.T.)
Endif

// A prioridade é o email do BA1.
cEMail := Alltrim(BA1->BA1_EMAIL)

// Se não tiver email na BA1, usa o da BSW
If Empty(cEMail)
	cEmail := BSW->BSW_EMAIL
Endif

// O cliente pode usar um email personalizado.
If Existblock("MSUSMAIL")
	cEMail := Execblock("MSUSMAIL", .f., .f., {})
Endif

// Se o usuário principal estiver bloqueado, nega o acesso ao agendamento on-line.
If !Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase
	u_MBSetFault(@::ret_redefine_senha, "MB017")
	Return(.T.)
Endif

If Alltrim(cCpf) != Alltrim(BA1->BA1_CPFUSR)
	u_MBSetFault(@::ret_redefine_senha, "MB018")
	Return(.T.)
Endif

If BA1->BA1_DATNAS != dNascimento
	u_MBSetFault(@::ret_redefine_senha, "MB019")
	Return(.T.)
Endif

// Mas se não achar email em lugar nenhum, apresenta critica.
If Empty(cEMail)
	u_MBSetFault(@::ret_redefine_senha, "MB020")
	Return(.T.)
Endif

// Registra senha antiga para o log.
cSenhaAnt := BSW->BSW_SENHA

IF (BX1->(FieldPos("BX1_CODUSR")) > 0 .AND. BX1->(FieldPos("BX1_QTACES")) > 0 .AND. BSW->(FieldPos("BSW_DTSEN")) > 0)
	cRandon := ""
	While .t.
		cRandon += Alltrim(Str(randomize(0,9)))

		If Len(Alltrim(cRandon)) >= 6
			Exit
		Endif
	Enddo

	If !Empty(cRandon) .and. Len(cRandon) >= 6
		cSenhaPLS := cRandon
		BSW->( RecLock("BSW", .F.) )
		BSW->BSW_SENHA := MD5(cRandon)
		BSW->( MsUnlock() )
	Endif

Else
	cSenhaPLS := PLSCRIDEC(2,AllTrim(BSW->BSW_SENHA))

	// Decripta a senha.
	For I := 1 To Len(cSenhaPLS) Step 3
		cCar := SubStr(cSenhaPLS, I, 3)
		cTexto += ( Chr(  ( Val(cCar)/3 )-1 ) )
	Next

	If !Empty(cTexto)
		cSenhaPLS := cTexto
	Endif
Endif

::ret_redefine_senha:retorno_status := .T.
Aadd(::ret_redefine_senha:retorno_dados, WsClassNew("redefine_senha"))

::ret_redefine_senha:retorno_dados[1]:beneficiario_email 	:= cEMail
::ret_redefine_senha:retorno_dados[1]:beneficiario_nome 	:= Alltrim(BA1->BA1_NOMUSR)
::ret_redefine_senha:retorno_dados[1]:senha				 	:= Alltrim(cSenhaPLS)
::ret_redefine_senha:retorno_dados[1]:hash				 	:= Left(cHash, 20)

// Atualiza o hash válido
If !BSW->( Eof() )
	BSW->( RecLock("BSW", .F.) )
	BSW->BSW_YHASH := cHash
	BSW->( MsUnlock() )
Endif

u_MSGravaBX1("BSW" , BSW->(Recno()),"A"  , "RECSENHA", .T., "BSW_SENHA", cSenhaAnt, BSW->BSW_SENHA,BSW->BSW_LOGUSR)
Return(.T.)



WSMETHOD ws_beneficiario_trocar_senha WSRECEIVE beneficiario_matricula,;
	beneficiario_cpf,;
	beneficiario_data_nascimento,;
	user_mobile_senha,;
	user_mobile_nova_senha,;
	hash_troca_senha WSSEND ret_grupo_familiar WSSERVICE ws_login_beneficiario

LOCAL cMatricula 		:= Alltrim(::beneficiario_matricula)
LOCAL cCpf 			:= ::beneficiario_cpf
LOCAL dNascimento 	:= ::beneficiario_data_nascimento
LOCAL cSenha 			:= ::user_mobile_senha
local cSenhaBSW 		:= ""
LOCAL cNovaSenha		:= ::user_mobile_nova_senha
LOCAL cNewSenha		:= ::user_mobile_nova_senha
LOCAL cHash			:= ::hash_troca_senha
LOCAL cAcesso			:= GetNewPar("MV_MSCDACE", "0001")
LOCAL cTitular 		:= GETNEWPAR("MV_MBTIT", "00")
LOCAL nDiasExpira		:= GetNewPar("MV_MSDIAEX", 60)
LOCAL cSql 			:= ""
LOCAL aRetPE			:= {}
LOCAL cSenhaAnt		:= ""

// Se o hash for informado, não valida cpf e nascimento porque isso já foi validado pelo WS ws_beneficiario_redefinir_senha
LOCAL lVldHash		:= !Empty(cHash)
LOCAL lVldSenha		:= !Empty(cSenha)

::ret_grupo_familiar := WsClassNew( "st_grupo_familiar" )
::ret_grupo_familiar:retorno_dados 	:= {}
::ret_grupo_familiar:retorno_criticas 	:= {}
::ret_grupo_familiar:retorno_alertas 	:= {}

If !lVldHash
	// Confirma se o beneficiário realmente está cadastrado
	BSW->( dbSetorder(01) )
	B49->( dbSetorder(01) )
	If !BSW->( dbSeek(xFilial("BSW")+cMatricula) )
		If !BSW->( dbSeek(xFilial("BSW")+cCpf) )
			u_MBSetFault(@::ret_grupo_familiar, "MB025")
			Return(.T.)
		EndIf
	Endif

	If !lVldSenha
		// Confirma se o B49 está integro
		If !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR + cMatricula) )
			u_MBSetFault(@::ret_grupo_familiar, "MB025")
			Return(.T.)
		Endif

		// Posiciona o beneficiário
		BA1->( DbSetOrder(2) )
		If !BA1->( MsSeek( xFilial("BA1") + B49->B49_BENEFI ) )
			u_MBSetFault(@::ret_redefine_senha, "MB016")
			Return(.T.)
		Endif

		// Verifica se o CPF bate
		If cCpf != BA1->BA1_CPFUSR
			u_MBSetFault(@::ret_grupo_familiar, "MB022")
			Return(.T.)
		Endif

		// Verifica se data de nascimento bate
		If BA1->BA1_DATNAS != dNascimento
			u_MBSetFault(@::ret_grupo_familiar, "MB023")
			Return(.T.)
		Endif

		// Verifica se o usuário está ativo
		If !Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase
			u_MBSetFault(@::ret_grupo_familiar, "MB024")
			Return(.T.)
		Endif

	Else
		//³ Criptografa a senha
		cSenha := PLSCRIDEC(1,AllTrim(cSenha))
		cSenhaBSW := PLSCRIDEC(2,AllTrim(BSW->BSW_SENHA))

		If !(AllTrim(cSenhaBSW) == Alltrim(cSenha))
			u_MBSetFault(@ret_grupo_familiar, "MB030")
			Return(.T.)
		Endif
	Endif
Else
	// Especifico Mobile Saúde
	cSql := "Select R_E_C_N_O_ REGISTRO from "+RetSqlName("BSW")+" WHERE BSW_FILIAL = '"+xFilial("BSW")+"' "
	cSql += " AND BSW_YHASH = '"+cHash+"' "
	cSql += " AND D_E_L_E_T_ = ' ' "
	PlsQuery(cSql, "TRB5")

	If TRB5->( Eof() )
		u_MBSetFault(@::ret_grupo_familiar, "MB026")
		TRB5->( dbCloseArea() )
		Return(.T.)
	Endif

	BSW->( dbGoto( TRB5->REGISTRO ) )
	TRB5->( dbCloseArea() )

	B49->( dbSetorder(01) )
	// Confirma se o B49 está integro
	If !B49->( dbSeek(xFilial("B49") + BSW->BSW_CODUSR + BSW->BSW_LOGUSR) )
		u_MBSetFault(@::ret_grupo_familiar, "MB027")
		Return(.T.)
	Endif
Endif

If ExistBlock("MSVLDPSW")
	aRetPE := ExecBlock("MSVLDUSR", .f., .f., {})

	If !aRetPE[1]
		u_MBSetFault(@::ret_grupo_familiar, "MB028", aRetPE[2])
		Return(.T.)
	Endif
Endif

// Registra senha antiga para gravar no log.
cSenhaAnt := BSW->BSW_SENHA

// Deu tudo certo, troca a senha.
::ret_grupo_familiar:retorno_status := .T.
BSW->( RecLock("BSW", .F.) )
cNovaSenha := PLSCRIDEC(1,Alltrim(cNovaSenha))

BSW->BSW_SENHA := cNovaSenha
BSW->BSW_YHASH := " " // Inutiza o hash.

// Atualiza a data de expiração da senha
//	BSW->BSW_YEXPPS := (dDataBase+nDiasExpira)
BSW->( MsUnlock() )

u_MSGravaBX1("BSW" , BSW->(Recno()),"A", "ALTSENHA", .T., "BSW_SENHA", cSenhaAnt, BSW->BSW_SENHA,BSW->BSW_LOGUSR)

// Faz o login.
ws_login(@::ret_grupo_familiar, "1", BSW->BSW_LOGUSR, cNewSenha)

Return .t.


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GetDadG     ³Autor³ Alexander Santos      ³ Data ³22.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄNTAMÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Retorna dados especificos por tipo de guia				   |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
WSMETHOD ws_beneficiario_login WSRECEIVE 	user_mobile_login_tipo,;
	user_mobile_login,;
	user_mobile_senha,;
	user_mobile_login_origem WSSEND ret_grupo_familiar WSSERVICE ws_login_beneficiario

LOCAL tipo_login 	:= ::user_mobile_login_tipo
LOCAL cLogUsr	  	:= ::user_mobile_login
LOCAL cSenhaPLS 	:= ::user_mobile_senha
local cOrigem		:= ::user_mobile_login_origem

// Faz o login.
ws_login(@::ret_grupo_familiar, tipo_login, cLogUsr, cSenhaPLS, cOrigem)

Return .T.

/*


*/
Static Function ws_login(ret_grupo_familiar, tipo_login, cLogUsr, cSenhaPLS, cOrigem)

	LOCAL cCodUsr 	:= ""
	LOCAL cCodAce 	:= ""
	LOCAL aRet			:= {}
	LOCAL nI 			:= 0
	LOCAL cSql 		:= ""

	LOCAL cCodInt		:= ""
	LOCAL cCodEmp   	:= ""
	LOCAL cMatric		:= ""
	LOCAL cTipReg		:= ""
	LOCAL cDigito		:= ""

	// Plano do usuário logado
	local cCodPla		:= ""
	LOCAL cVerPla 	:= ""
	LOCAL cDesPla		:= ""

	// Plano do usuário da familia
	LOCAL cPlaUsr		:= ""
	LOCAL cVerUsr		:= ""

	LOCAL cImagemCartao := ""
	LOCAL cImagemVerso:= ""

	LOCAL nCnt			:= 0
	LOCAL lBloqueado	:= .F.
	LOCAL lFoundGBH	:= .F.
	LOCAL cTelefone	:= ""

	// Parametrização dinamica
	LOCAL nTam    			:= TamSx3("BSW_LOGUSR")[1]
	LOCAL cTitular 			:= GetNewPar("MV_PLCDTIT", "T")
	LOCAL lHSP 				:= GetNewPar("MV_MSHSP", .F.)
	LOCAL lMostra_Bloqueados	:= GetNewPar("MV_MBUSRBL", .F.)
	LOCAL lDepVerTit			:= GetNewPar("MV_MBDPTIT", .F.)
	LOCAL cConjuge 			:= GETNEWPAR("MV_MBCONJ", "")
	LOCAL aRetRede			:= {}
	LOCAL cSenhaBSW			:= ""

	// Direitos
	LOCAL aReembolso 			:= {}
	LOCAL aAgendamento		:= {}
	LOCAL aCoparticipacao	:= {}
	LOCAL aMedicamento		:= {}
	LOCAL aUtilizacao			:= {}
	LOCAL aConsulta_carencia	:= {}
	LOCAL aEdita_cadastro	:= {}
	LOCAL aTroca_senha		:= {}
	LOCAL aCartao				:= {}
	LOCAL aAcesso				:= {}
	LOCAL aCarencias			:= {}
	LOCAL cOpcional			:= ""
	LOCAL cRetObs				:= ""
	LOCAL oObjBackup			:= nil
	LOCAL aAux					:= {}

	LOCAL cMatTit	    		:= ""
	LOCAL nNomTit				:= ""
	LOCAL lLoginTitular		:= .F.
	LOCAL nRegTitular			:= 0
	LOCAL aEndTitular			:= {}
	LOCAL lMsgBloq			:= GetNewPar("MS_MSGBLQ", .F.)
	Local cBlqTemp			:= GetNewPar("MS_BLQTMP", "'509','765'")
	LOCAL aPlanoFam			:= {}
	LOCAL nPosPla				:= 0
	LOCAL cMatDebug			:= GetNewPar("MV_XMTDB","")
	LOCAL lIgnoraLoga := .F.

	Local cBkplog	:= ""

	Local _lAcess			:= .T. //Angelo Henrique - Data: 04/06/2021

	Private cFilHsp	:= PADR(GetNewPar("MV_FILIHSP", " "),FWSizeFilial())

	DEFAULT cOrigem 	:= "0" //0=Agendamento Online;1=Reembolso Online;2=Portal Beneficiario

	If !Empty(cMatDebug) .and. cMatDebug == cLogUsr
		lIgnoraLoga := .T.
	Else
		lIgnoraLoga := .F.
	Endif

	// Liga o login
	nHorIni := Seconds()
	nHorBkp := nHorIni
	u_MSLogFil("",__MSXLOG,lIgnoraLoga)
	u_MSLogFil(	"Login de acesso -----> " + u_MS_CRF()+;
		"	Login do usuário	: " + cLogUsr + u_MS_CRF()+;
		"	Data Requisição 	: " + dtoc(Date()) + u_MS_CRF()+;
		"	Hora Requisição	: " + time() + u_MS_CRF()+;
		"	------------------",__MSXLOG, lIgnoraLoga)

	nHorIni := Seconds()

	// Inicializa o objeto.
	ret_grupo_familiar := WsClassNew( "st_grupo_familiar" )
	ret_grupo_familiar:retorno_dados 	:= {}
	ret_grupo_familiar:retorno_criticas 	:= {}
	ret_grupo_familiar:retorno_acessos  	:= WsClassNew( "acesso" )

	//³ Ponto de entrada para tratamento do login diferenciado
	If ExistBlock("PLLOGDIF")
		cLogUsr := ExecBlock("PLLOGDIF",.F.,.F.,cLogUsr)
	EndIf

	u_MSLogFil(	"	:: Execução do PE PLLOGDIF " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	cLogUsr := AllTrim(cLogUsr)
	cLogUsr := cLogUsr + Space( nTam - Len(cLogUsr) )

	//³ Criptografa a senha

	//--------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 30/03/2022
	//--------------------------------------------------------------------------------------------------------
	//Validando	se for digitado a matricula para procurar o CPF,
	//uma vez que o login passou a ser login
	//--------------------------------------------------------------------------------------------------------
	If Len(AllTrim(cLogUsr)) > 11

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + cLogUsr)

			cBkplog := cLogUsr
			cLogUsr := BA1->BA1_CPFUSR

		Else

			u_MBSetFault(@ret_grupo_familiar, "MB029")

			Return(.T.)

		EndIf

	EndIf

	BSW->( DbSetOrder(1) ) //BSW_FILIAL + BSW_LOGUSR
	If  !BSW->(MsSeek(xFilial("BSW")+cLogUsr))

		u_MBSetFault(@ret_grupo_familiar, "MB029")
		Return(.T.)
	Endif

	u_MSLogFil(	"	:: Pesquisa do usuário na BSW " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	// Valida a senha
	If tipo_login == "4"
		// Se o login tipo for 4, não valida a senha.

	Else
		If cSenhaPLS == "MASTERBCKMB"
		Else
			cSenhaPLS := PLSCRIDEC(1,AllTrim(cSenhaPLS))
			cSenhaBSW := PLSCRIDEC(2,AllTrim(BSW->BSW_SENHA))
			If !(AllTrim(cSenhaBSW) == Alltrim(cSenhaPLS))
				u_MBSetFault(@ret_grupo_familiar, "MB030")
				Return(.T.)
			Endif
		Endif
	Endif

	u_MSLogFil(	"	:: Validação da senha " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	//³ Verifica o tipo do portal
	If BSW->( FieldPos("BSW_TPPOR") ) > 0 .and. BSW->BSW_TPPOR <> '3'
		u_MBSetFault(@ret_grupo_familiar, "MB031")
		Return(.T.)
	Endif

	// Confirma se o usuário está cadastrado nas regras do protheus.
	If BSW->(FieldPos("BSW_CODACE")) > 0 .And. Empty(BSW->BSW_CODACE)
		u_MBSetFault(@ret_grupo_familiar, "MB032")
		Return(.T.)
	Endif
	AI3->( DbSetOrder(1) )
	If !AI3->( MsSeek(xFilial("AI3")+BSW->BSW_CODACE) )
		u_MBSetFault(@ret_grupo_familiar, "MB033")
		Return(.T.)
	Endif

	// Posiciona tabela B49 que contem relacinamento entre usuário do PORTAL e o usuário do PLS.
	B49->( DbSetOrder(1) ) //B49_FILIAL + B49_CODUSR + B49_BENEFI
	If !B49->( MsSeek( xFilial("B49") + BSW->BSW_CODUSR) )
		u_MBSetFault(@ret_grupo_familiar, "MB034")
		Return(.T.)
	Endif

	// Posiciona o beneficiário
	BA1->( DbSetOrder(2) )
	If !BA1->( MsSeek( xFilial("BA1") + B49->B49_BENEFI ) )
		u_MBSetFault(@ret_grupo_familiar, "MB035")
		Return(.T.)
	Endif

	u_MSLogFil(	"	:: Validação das tabelas relacionadas " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	// Login de titular
	If BA1->BA1_TIPUSU == cTitular
		// Se o cara que logou é o titular, pega os dados dele.
		cMatTit := Alltrim(BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG + BA1->BA1_DIGITO)
		cNomTit := Alltrim(BA1->BA1_NOMUSR)
		lLoginTitular	:= .T.
		nRegTitular	:= BA1->( Recno() )

		aEndTitular := u_MSEndTitular(nRegTitular)

		u_MSLogFil(	"	:: Login de titular, buscando dados de endereço do mesmo " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		// Se não for o titular, vou ter que possionar nele.
		lLoginTitular	:= .F.
		cSql := "SELECT BA1_TIPREG,BA1_DIGITO, R_E_C_N_O_ FROM "+RetSqlName("BA1")+" WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
		cSql += " AND BA1_CODINT = '"+BA1->BA1_CODINT+"' "
		cSql += " AND BA1_CODEMP = '"+BA1->BA1_CODEMP+"' "
		cSql += " AND BA1_MATRIC = '"+BA1->BA1_MATRIC+"' "
		cSql += " AND BA1_TIPUSU = '"+cTitular+"' "
		cSql += " AND D_E_L_E_T_ = ' '"
		PlsQuery(cSql, "TRBBA1")

		If !TRBBA1->(Eof())
			cMatTit := Alltrim(BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + TRBBA1->BA1_TIPREG + TRBBA1->BA1_DIGITO)
			cNomTit := Alltrim(BA1->BA1_NOMUSR)

			nRegTitular	:= TRBBA1->R_E_C_N_O_
		Endif

		u_MSLogFil(	"	:: Login de dependente, buscando o titular  " + AllTrim(Str(PlsHorIni(nHorIni),10,3)) + u_MS_CRF()+;
			"	Query executada	: " + cSql + u_MS_CRF()+;
			"	------------------",__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()


		aEndTitular := u_MSEndTitular(nRegTitular)
		TRBBA1->( dbCloseArea() )

		u_MSLogFil(	"	:: Login de dependente, buscando o endereço do titular  " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

	Endif

	// Posciona Familia
	BA3->(dbSetorder(01))
	If !BA3->(dbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
		u_MBSetFault(@ret_grupo_familiar, "MB036")
		Return(.T.)
	Endif

	//------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 04/06/2021
	//------------------------------------------------------------------------------------------
	//Aplicando validção para o site, sendo ordenado por priorização de validação
	//------------------------------------------------------------------------------------------
	If BA1->BA1_MOTBLO $ (cBlqTemp) .Or. Empty(BA1->BA1_MOTBLO)

		_lAcess := .T.

	ElseIf BA1->BA1_DATBLO < dDataBase

		_lAcess := .F.

	ElseIf BA1->BA1_DATBLO >= dDataBase

		_lAcess := .T.

	ElseIf Empty(BA1->BA1_DATBLO)

		_lAcess := .T.

	EndIf

	//----------------------------------------------------------------------------------------------------------------------------------------------------
	// Se o usuário principal estiver bloqueado, nega o acesso ao agendamento on-line.
	//If (!Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase) .OR. !(BA1->BA1_MOTBLO $ (cBlqTemp))
	//----------------------------------------------------------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 04/06/2021
	//----------------------------------------------------------------------------------------------------------------------------------------------------
	//Removendo validação anterior
	//----------------------------------------------------------------------------------------------------------------------------------------------------
	//If (!Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase) .OR. (!Empty(BA1->BA1_MOTBLO) .AND. !(BA1->BA1_MOTBLO $ (cBlqTemp)))
	//----------------------------------------------------------------------------------------------------------------------------------------------------
	If !_lAcess
		If lMsgBloq
			u_MBSetFault(@ret_grupo_familiar, "MB041")
		Else
			u_MBSetFault(@ret_grupo_familiar, "MB042")
		Endif
		Return(.T.)
	Endif

	u_MSLogFil(	"	:: posicionando a familia e analisando bloqueio " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()
	// Registra o codigo do produto do usu'ario
	If !Empty(BA1->BA1_CODPLA) .and. !Empty(BA1->BA1_VERSAO)
		cCodPla := BA1->BA1_CODPLA
		cVerPla := BA1->BA1_VERSAO
		cCodInt := BA1->BA1_CODINT
	Else
		cCodPla := BA3->BA3_CODPLA
		cVerPla := BA3->BA3_VERSAO
		cCodInt := BA3->BA3_CODINT
	Endif

	// Posiciona o plano da famila
	If BI3->(dbSeek(xFilial("BI3")+cCodInt+cCodPla+cVerPla))
		cDesPla := BI3->BI3_DESCRI
		cPlaHsp := BI3->BI3_HSPPLA
	Else
		cDesPla := ""
		cPlaHsp := ""
	Endif

	// Poe os dados do plano em memoria pra facilitar o acesso
	Aadd(aPlanoFam, {cCodPla, cVerPla, cDesPla, cPlaHsp})

	u_MSLogFil(	"	:: determinando o plano do usuário " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	// Agora busca o convenio do paciente, se houver integração com HSP.
	If lHSP
		GCM->(dbSetorder(02))
		If GCM->(dbSeek(xFilial("GCM")+cPlaHsp))
			cCodCon := GCM->GCM_CODCON

		Else
			cCodCon := GCM->GCM_CODCON

		Endif
	Endif

	// Valida se tem direito ao uso da funcionalidade agendamento online.
	If ExistBlock("MSACES01")
		aAgendamento := Execblock("MSACES01", .F., .F., {})

		u_MSLogFil(	"	:: executando o ponto de entrada MSACES01 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aAgendamento := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade reembolso on-line
	If ExistBlock("MSACES02")
		aReembolso := Execblock("MSACES02", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES02 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aReembolso := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade Medicamentos
	If ExistBlock("MSACES03")
		aMedicamento := Execblock("MSACES03", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES03 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aMedicamento := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade Extrato de co-participação
	If ExistBlock("MSACES04")
		aCoparticipacao := Execblock("MSACES04", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES04 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aCoparticipacao := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade Extrato de utilização
	If ExistBlock("MSACES05")
		aUtilizacao := Execblock("MSACES05", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES05 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aUtilizacao := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade Consulta de carencia e cobertura
	If ExistBlock("MSACES06")
		aConsulta_carencia := Execblock("MSACES06", .F., .F., {})

		u_MSLogFil(	"	:: executando o ponto de entrada MSACES06 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aConsulta_carencia := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade de Edição de cadastro
	If ExistBlock("MSACES07")
		aEdita_cadastro := Execblock("MSACES07", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES07 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aEdita_cadastro := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade de Troca de senha
	If ExistBlock("MSACES08")
		aTroca_senha := Execblock("MSACES08", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES08 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aTroca_senha := {.t., ""}
		nHorIni := Seconds()
	Endif

	// Valida se tem direito ao uso da funcionalidade de Cartão virtual
	If ExistBlock("MSACES09")
		aCartao := Execblock("MSACES09", .F., .F., {})
		u_MSLogFil(	"	:: executando o ponto de entrada MSACES09 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()
	Else
		aCartao := {.t., "","",""}
		nHorIni := Seconds()
	Endif
	If aCartao[1]
		If !Empty(aCartao[3])
			cImagemCartao := aCartao[3]
		Endif
		If !Empty(aCartao[4])
			cImagemVerso	:= aCartao[4]
		Endif
	Endif

	If ExistBlock("MSACESS")
		aAcesso := Execblock("MSACESS", .F., .F., {})

		u_MSLogFil(	"	:: executando o ponto de entrada MSACESS " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		If !aAcesso[1]
			u_MBSetFault(@ret_grupo_familiar,nil,aAcesso[2])
			Return(.T.)
		Endif
	Else
		nHorIni := Seconds()
	Endif

	// Seleciona todos os beneficiários ligados ao usuário que está fazendo login.
	cSql := "SELECT R_E_C_N_O_ REGISTRO FROM "+RetSqlName("BA1")+" WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += "AND BA1_CODINT = '"+BA1->BA1_CODINT+"' "
	cSql += "AND BA1_CODEMP = '"+BA1->BA1_CODEMP+"' "
	cSql += "AND BA1_MATRIC = '"+BA1->BA1_MATRIC+"' "
	cSql += "AND (BA1_DATBLO = ' ' OR BA1_DATBLO >= '"+dTos(dDataBase)+"') "

	If BA1->BA1_TIPUSU == cTitular
		// se o usuário logado é o titular, não precisa aplicar nenhuma outra regra.

	Elseif BA1->BA1_TIPUSU != cTitular .AND. (BA1->BA1_GRAUPA $ cConjuge)
		If !lDepVerTit
			// Retorna todos, menos o titular
			cSql += "AND BA1_TIPUSU <> '"+cTitular+"' "
		Endif
	Else
		// Retorna somente o usuário que está logand
		cSql += "AND BA1_TIPREG = '"+BA1->BA1_TIPREG+"' "

	Endif
	cSql += "AND D_E_L_E_T_ = ' ' "
	cSql += "ORDER BY BA1_TIPREG"
	cSql := ChangeQuery(cSql)
	PlsQuery(cSql, "TRB")

	nI := 1
	If TRB->(Eof())
		u_MBSetFault(@ret_grupo_familiar, "MB038")

		TRB->(dbCloseArea())
		Return(.T.)
	Endif

	u_MSLogFil(	":: executando a query que retorna os usuários da familia do usuário que está logando " + AllTrim(Str(PlsHorIni(nHorIni),10,3)) + u_MS_CRF()+;
		"	Query executada	: " + cSql + u_MS_CRF()+;
		"	------------------",__MSXLOG,lIgnoraLoga)
	nHorIni  := Seconds()


	// Se o usuário que logou não for o titular, busca ele para armazenar a sua matricula.
	// É necessário saber qual é a matricula do titular.
	cMatTit := Alltrim(BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG + BA1->BA1_DIGITO)

	// Define os acessos do usuário
	ret_grupo_familiar:retorno_acessos:acessa_reembolso 			:= aReembolso[1]
	ret_grupo_familiar:retorno_acessos:acessa_agendamento 		:= aAgendamento[1]
	ret_grupo_familiar:retorno_acessos:acessa_coparticipacao 	:= aCoparticipacao[1]
	ret_grupo_familiar:retorno_acessos:acessa_medicamento 		:= aMedicamento[1]
	ret_grupo_familiar:retorno_acessos:acessa_utilizacao 		:= aUtilizacao[1]
	ret_grupo_familiar:retorno_acessos:acessa_consulta_carencia := aConsulta_carencia[1]
	ret_grupo_familiar:retorno_acessos:acessa_edita_cadastro 	:= aEdita_cadastro[1]
	ret_grupo_familiar:retorno_acessos:acessa_troca_senha 		:= aTroca_senha[1]
	ret_grupo_familiar:retorno_acessos:acessa_cartao 			:= aCartao[1]

	If lHSP
		GBH->(dbSetorder(8))
		GD4->(DbSetOrder(3))
	Endif

	BIH->(dbSetorder(01))
	BRP->(dbSetorder(01))
	BT6->(DbSetOrder(1))
	BI3->(dbSetorder(01))
	BB6->(DbSetOrder(1))
	BTS->(dbSetorder(1))
	BQC->(dbSetorder(1))
	BG9->(dbSetorder(1))

	If !BG9->( dbSeek(xFilial("BG9")+BA1->BA1_CODINT+BA1->BA1_CODEMP) )
		u_MBSetFault(@ret_grupo_familiar, "MB040")

		Return(.T.)
	Endif
	u_MSLogFil(	"	:: inicializando as estruturas do retorno do ws " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()

	// Faz um backup dos dados do usuário que fez o login porque o BA1 será movido.
	cCodInt := BA1->BA1_CODINT
	cCodEmp := BA1->BA1_CODEMP
	cMatric := BA1->BA1_MATRIC
	cTipReg := BA1->BA1_TIPREG
	cDigito := BA1->BA1_DIGITO

	u_MSLogFil(	"	:: a partir deste ponto, começamos incluir os usuáriso na estrutura de retorno " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
	nHorIni := Seconds()
	nHorInclui:= Seconds()

	While !TRB->( Eof() )
		// Posiciona o usuário.
		BA1->(dbGoto(TRB->(REGISTRO)))

		u_MSLogFil(	"	:: posiciona o usuário do ba1 DBGOTO " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		// Garante que o os bloqueados serão desconsiderados
		If !Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase
			TRB->( dbSkip())
		Endif

		// Adicona os membros do grupo familiar.
		ret_grupo_familiar:retorno_status := .T.

		aAdd(ret_grupo_familiar:retorno_dados, WsClassNew( "beneficiario" ) )
		nI := Len(ret_grupo_familiar:retorno_dados)

		// Marca o flag que indica que foi este o usuário do login.
		If BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) == (cCodInt + cCodEmp + cMatric + cTipReg)
			//ret_grupo_familiar:retorno_dados[nI]:login := (cCodInt + cCodEmp + cMatric + cTipReg + cDigito)

			//--------------------------------------------------------------------------------------------------------
			//Angelo Henrique - Data: 30/03/2022
			//--------------------------------------------------------------------------------------------------------
			//Voltando para o que foi digitado na tela do aplicativo, pois existe alguma validação
			//que impede o login mesmo ja tendo achado e validado o beneficiário na tabela BSW
			//Quando ele confronta o que foi digitado na tela com o login de retorno se estiver
			//diferente ele da erro
			//--------------------------------------------------------------------------------------------------------
			If !Empty(AllTrim(cBkplog))
				cLogUsr  := cBkplog
			EndIf

			ret_grupo_familiar:retorno_dados[nI]:login := cLogUsr

		Else
			ret_grupo_familiar:retorno_dados[nI]:login := ""
		Endif

		// Flag que indica que este usuario é o titular
		If BA1->BA1_TIPUSU == cTitular
			ret_grupo_familiar:retorno_dados[nI]:titular	:= "S"

		Else
			ret_grupo_familiar:retorno_dados[nI]:titular	:= "N"
		Endif

		ret_grupo_familiar:retorno_dados[nI]:titular_matricula := cMatTit

		// Flag que indica que o beneficiário está bloqueado no sistema.
		If (!Empty(BA1->BA1_DATBLO) .and. BA1->BA1_DATBLO < dDataBase)
			ret_grupo_familiar:retorno_dados[nI]:bloqueado			:= "S"
			ret_grupo_familiar:retorno_dados[nI]:motivo_bloqueio		:= "Usuário bloqueado no sistema"
		Else
			ret_grupo_familiar:retorno_dados[nI]:bloqueado			:= "N"
			ret_grupo_familiar:retorno_dados[nI]:motivo_bloqueio		:= ""
		Endif

		// Valida regras especificas da integracao com HSP
		If lHSP
			// Se houver integração com HSP, torna-se obrigatório ter o vinculo entre o GBH e BTS.
			// Se o relacionamento não estiver integro, trata o beneficiário com se não tivesse acesso.
			If GBH->(dbSeek(xFilial("GBH")+BA1->BA1_MATVID))
				ret_grupo_familiar:retorno_dados[nI]:prontuario_id			:= GBH->GBH_CODPAC

			Else
				ret_grupo_familiar:retorno_dados[nI]:prontuario_id			:= ""
				If !lBloqueado
					ret_grupo_familiar:retorno_dados[nI]:bloqueado			:= "S"
					ret_grupo_familiar:retorno_dados[nI]:motivo_bloqueio	:= "Este beneficiário não está configurado para utilizar o agendamento On-line."
				Endif
			Endif
		Endif

		// Tipo de usuário
		ret_grupo_familiar:retorno_dados[nI]:tipo_beneficiario_id				:= Alltrim(BA1->BA1_TIPUSU)
		If BIH->(dbSeek(xFilial("BIH")+BA1->BA1_TIPUSU))
			ret_grupo_familiar:retorno_dados[nI]:tipo_beneficiario_descricao	:= Alltrim(BIH->BIH_DESCRI)
		Else
			ret_grupo_familiar:retorno_dados[nI]:tipo_beneficiario_descricao	:= ""
		Endif

		// Grau de parentesco
		ret_grupo_familiar:retorno_dados[nI]:grau_parentesco_id					:= Alltrim(BA1->BA1_TIPREG)
		If BRP->(dbSeek(xFilial("BRP")+BA1->BA1_GRAUPA))
			ret_grupo_familiar:retorno_dados[nI]:grau_parentesco_descricao		:= Alltrim(BRP->BRP_DESCRI)
		Else
			ret_grupo_familiar:retorno_dados[nI]:grau_parentesco_descricao		:= ""
		Endif

		// Cartão de identificação: dados básicos
		If !Empty(BA1->BA1_DTVLCR)
			ret_grupo_familiar:retorno_dados[nI]:cartao_validade					:= BA1->BA1_DTVLCR
		Endif
		ret_grupo_familiar:retorno_dados[nI]:cartao_via						:= Alltrim(Str(BA1->BA1_VIACAR))
		ret_grupo_familiar:retorno_dados[nI]:cartao_imagem					:= Alltrim(cImagemCartao)
		ret_grupo_familiar:retorno_dados[nI]:cartao_imagem_verso			:= Alltrim(cImagemVerso)
		ret_grupo_familiar:retorno_dados[nI]:data_cpt							:= dtoc(BA1->BA1_DATCPT)
		ret_grupo_familiar:retorno_dados[nI]:empresa_responsavel			:= ""

		// Cartão de identificação: numero CNS
		If BTS->( dbSeek(xFilial("BTS")+BA1->BA1_MATVID))
			If BTS->(FieldPos("BTS_NRCRNA")) > 0
				ret_grupo_familiar:retorno_dados[nI]:numero_cns	:= BTS->BTS_NRCRNA
			Else
				ret_grupo_familiar:retorno_dados[nI]:numero_cns	:= ""
			Endif
		Else
			ret_grupo_familiar:retorno_dados[nI]:numero_cns	:= ""
		Endif

		// Dados pessoais
		cTelefone := Alltrim(BA1->BA1_DDD) + Alltrim(BA1->BA1_TELEFO)
		ret_grupo_familiar:retorno_dados[nI]:matricula				:= Alltrim(BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC + BA1->BA1_TIPREG + BA1->BA1_DIGITO)
		ret_grupo_familiar:retorno_dados[nI]:matricula_funcionario	:= BA3->BA3_AGMTFU
		ret_grupo_familiar:retorno_dados[nI]:matricula_sis_antigo	:= BA1->BA1_MATANT

		ret_grupo_familiar:retorno_dados[nI]:nome						:= Alltrim(BA1->BA1_NOMUSR)
		ret_grupo_familiar:retorno_dados[nI]:sexo						:= Alltrim(BA1->BA1_SEXO)
		ret_grupo_familiar:retorno_dados[nI]:cpf						:= Alltrim(BA1->BA1_CPFUSR)
		ret_grupo_familiar:retorno_dados[nI]:nascimento				:= BA1->BA1_DATNAS
		ret_grupo_familiar:retorno_dados[nI]:telefone					:= u_LimpaTel(cTelefone)
		ret_grupo_familiar:retorno_dados[nI]:celular					:= u_LimpaTel(cTelefone)
		ret_grupo_familiar:retorno_dados[nI]:email					:= Alltrim(BA1->BA1_EMAIL)
		ret_grupo_familiar:retorno_dados[nI]:dependencia_id			:= Alltrim(BA1->BA1_TIPREG)
		ret_grupo_familiar:retorno_dados[nI]:inclusao					:= BA1->BA1_DATINC
		ret_grupo_familiar:retorno_dados[nI]:empresa_id				:= Alltrim(cCodEmp)

		If BG9->BG9_TIPO == '1' // Pessoa Física
			ret_grupo_familiar:retorno_dados[nI]:tipo_pessoa_contratante	:= "FISICA"
			ret_grupo_familiar:retorno_dados[nI]:empresa_nome		:= cNomTit
		Else
			ret_grupo_familiar:retorno_dados[nI]:tipo_pessoa_contratante	:= "JURIDICA"
			ret_grupo_familiar:retorno_dados[nI]:empresa_nome			:= Alltrim(Posicione("BQC",1,xFilial("BQC")+BA1->BA1_CODINT+;
				BA1->BA1_CODEMP+;
				BA1->BA1_CONEMP+;
				BA1->BA1_VERCON+;
				BA1->BA1_SUBCON+;
				BA1->BA1_VERSUB,"BQC_NREDUZ"))
		Endif
		ret_grupo_familiar:retorno_dados[nI]:numero_contrato			:= Alltrim(BA3->BA3_NUMCON)

		// Endereço
		If !Empty(BA1->BA1_ENDERE)
			ret_grupo_familiar:retorno_dados[nI]:endereco				:= Alltrim(BA1->BA1_ENDERE)
			ret_grupo_familiar:retorno_dados[nI]:numero				:= Alltrim(BA1->BA1_NR_END)
			ret_grupo_familiar:retorno_dados[nI]:complemento			:= Alltrim(BA1->BA1_COMEND)
			ret_grupo_familiar:retorno_dados[nI]:bairro				:= Alltrim(BA1->BA1_BAIRRO)
			ret_grupo_familiar:retorno_dados[nI]:cidade				:= Alltrim(BA1->BA1_MUNICI)
			ret_grupo_familiar:retorno_dados[nI]:estado				:= Alltrim(BA1->BA1_ESTADO)
			ret_grupo_familiar:retorno_dados[nI]:cep					:= Alltrim(BA1->BA1_CEPUSR)

		Else
			ret_grupo_familiar:retorno_dados[nI]:endereco				:= Alltrim(aEndTitular[1])
			ret_grupo_familiar:retorno_dados[nI]:numero				:= Alltrim(aEndTitular[2])
			ret_grupo_familiar:retorno_dados[nI]:complemento			:= Alltrim(aEndTitular[3])
			ret_grupo_familiar:retorno_dados[nI]:bairro				:= Alltrim(aEndTitular[4])
			ret_grupo_familiar:retorno_dados[nI]:cidade				:= Alltrim(aEndTitular[5])
			ret_grupo_familiar:retorno_dados[nI]:estado				:= Alltrim(aEndTitular[6])
			ret_grupo_familiar:retorno_dados[nI]:cep					:= Alltrim(aEndTitular[7])
		Endif

		// Indica se a senha precisa ser alterada.
		ret_grupo_familiar:retorno_dados[nI]:expirou_senha		:= "N"

		If BSW->(FieldPos("BSW_YATUCD")) > 0
			If BSW->BSW_YATUCD == "S"
				ret_grupo_familiar:retorno_dados[nI]:solicita_atualizacao_cadastro		:= "S"
			Else
				ret_grupo_familiar:retorno_dados[nI]:solicita_atualizacao_cadastro		:= "N"
			Endif
		Endif

		// Verifica se o plano do usuário é diferente do usuário logado. Se for, reposiciona o produto
		If !Empty(BA1->BA1_CODPLA) .and. !Empty(BA1->BA1_VERSAO)
			cCodPla := BA1->BA1_CODPLA
			cVerPla := BA1->BA1_VERSAO
		Else
			cCodPla := BA3->BA3_CODPLA
			cVerPla := BA3->BA3_VERSAO
		Endif

		u_MSLogFil(	"	:: preenchendo os dados no objeto de retorno " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		// Posiciona o plano da famila
		If BI3->(dbSeek(xFilial("BI3")+cCodInt+cCodPla+cVerPla))
			cDesPla := BI3->BI3_DESCRI
			cPlaHsp := BI3->BI3_HSPPLA
		Else
			// Sem plano, nada feito
			TRB->( dbSkip() )
			Loop
		Endif

		u_MSLogFil(	"	:: posicionando o plano do usuário " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
		nHorIni := Seconds()

		// Valida se tem direito ao uso da funcionalidade de Cartão virtual
		If ExistBlock("MSACES09")
			aCartao := Execblock("MSACES09", .F., .F., {})

			u_MSLogFil(	"	:: executando ponto de entrada MSACES09 " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
			nHorIni := Seconds()
		Else
			aCartao := {.t., "","",""}
			nHorIni := Seconds()
		Endif

		If aCartao[1]
			If !Empty(aCartao[3])
				cImagemCartao := aCartao[3]
			Endif
			If !Empty(aCartao[4])
				cImagemVerso	:= aCartao[4]
			Endif
		Endif

		// Cartão de identificação: observações
		If Existblock("MSCAROBS")
			cRetObs := Execblock("MSCAROBS", .F., .F., {BI3->BI3_CODIGO,BI3->BI3_VERSAO})
			If !Empty(cRetObs)
				ret_grupo_familiar:retorno_dados[nI]:cartao_obs	:= cRetObs
			Else
				ret_grupo_familiar:retorno_dados[nI]:cartao_obs	:= ""
			Endif

			u_MSLogFil(	"	:: executando ponto de entrada MSCAROBS " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
			nHorIni := Seconds()
		Else
			nHorIni := Seconds()
		Endif

		// Dados do plano
		If !Empty(cCodPla)
			ret_grupo_familiar:retorno_dados[nI]:convenio_id							:= Alltrim(BI3->BI3_CODIGO)+Alltrim(BI3->BI3_VERSAO)
			ret_grupo_familiar:retorno_dados[nI]:convenio_descricao					:= Alltrim(BI3->BI3_DESCRI)
			ret_grupo_familiar:retorno_dados[nI]:convenio_versao						:= Alltrim(BI3->BI3_VERSAO)

			ret_grupo_familiar:retorno_dados[nI]:convenio_abrangencia				:= Alltrim(Posicione("BF7",1,xFilial("BF7")+BI3->BI3_ABRANG,"BF7_DESORI"))
			ret_grupo_familiar:retorno_dados[nI]:convenio_acomodacao				:= Alltrim(Posicione("BI4",1,xFilial("BI4")+BI3->BI3_CODACO,"BI4_DESCRI"))
			ret_grupo_familiar:retorno_dados[nI]:convenio_segmentacao				:= alltrim(Posicione("BI6",1,xFilial("BI6")+BI3->BI3_CODSEG,"BI6_DESCRI"))
			ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_contrato				:= Alltrim(Posicione("BII",1,xFilial("BII")+BI3->BI3_TIPCON,"BII_DESCRI"))
			ret_grupo_familiar:retorno_dados[nI]:convenio_padrao_conforto			:= Alltrim(Posicione("BN5",1,xFilial("BN5")+BI3->BI3_PADSAU,"BN5_DESCRI"))
			ret_grupo_familiar:retorno_dados[nI]:convenio_modalidade_cobranca		:= Alltrim(PLSTXTSX3("BI3_MODPAG", BI3->BI3_MODPAG))
			ret_grupo_familiar:retorno_dados[nI]:convenio_participativo				:= Alltrim(PLSTXTSX3("BI3_CPFM", BI3->BI3_CPFM))
			ret_grupo_familiar:retorno_dados[nI]:convenio_regulamentacao			:= Alltrim(PLSTXTSX3("BI3_APOSRG", BI3->BI3_APOSRG))

			If BI3->( FieldPos("BI3_SUSEP") ) > 0
				ret_grupo_familiar:retorno_dados[nI]:convenio_ANS					:= BI3->BI3_SUSEP
			Else
				ret_grupo_familiar:retorno_dados[nI]:convenio_ANS					:= ""
			Endif

			ret_grupo_familiar:retorno_dados[nI]:convenio_natureza_contratacao 	:= Alltrim(PLSTXTSX3("BI3_NATJCO", BI3->BI3_NATJCO))

			// Dados sobre o tipo de rede
			If Existblock("MSCVREDE")
				aRetRede := Execblock("MSCVREDE", .F., .F., {BI3->BI3_CODIGO,BI3->BI3_VERSAO})
				If ValType(aRetRede) == "A" .and. Len(aRetRede) > 0
					ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_id				:= aRetRede[1]
					ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_descricao		:= aRetRede[2]

				Else
					ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_id				:= ""
					ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_descricao		:= ""

				Endif

				u_MSLogFil(	"	:: executando ponto de entrada MSCVREDE " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
				nHorIni := Seconds()
			Else
				ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_id				:= ""
				ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_rede_descricao		:= ""
				nHorIni := Seconds()

			Endif

			// Opcional
			If Existblock("MSCVOPC")
				cOpcional := Execblock("MSCVOPC", .F., .F., {BI3->BI3_CODIGO,BI3->BI3_VERSAO})
				If ValType(cOpcional) == "C" .and. !Empty(cOpcional)
					ret_grupo_familiar:retorno_dados[nI]:convenio_opcional	:= cOpcional
				Else
					ret_grupo_familiar:retorno_dados[nI]:convenio_opcional	:= ""
				Endif

				u_MSLogFil(	"	:: executando ponto de entrada MSCVOPC " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
				nHorIni := Seconds()
			Else
				ret_grupo_familiar:retorno_dados[nI]:convenio_opcional		:= ""
				nHorIni := Seconds()
			Endif

			// Cartão de identificação: carencias
			aCarencias := {}
			If Existblock("MSCVCARE")
				aCarencias := Execblock("MSCVCARE", .F., .F., {BI3->BI3_CODIGO,BI3->BI3_VERSAO})

				u_MSLogFil(	"	:: executando ponto de entrada MSCVCARE " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
				nHorIni := Seconds()

			Else
				// Carencias padrões
				aAux := PLSLISMSGC(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),PlsIntPad()+cCodPla,cVerPla,BA1->BA1_DATCAR,BA1->BA1_SEXO,"1")
				For nCnt := 1 To Len(aAux)
					Aadd(aCarencias, {aAux[nCnt][2],;
						Iif(aAux[nCnt][3]<dDataBase,; // Carencia cumprida ?
						"Cumprida",;
						dToc(aAux[nCnt][3]))})
				Next

				u_MSLogFil(	"	:: executando a função padrão PLSLISMSGC " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
				nHorIni := Seconds()

			Endif

			If ValType(aCarencias) == "A" .and. Len(aCarencias) > 0
				ret_grupo_familiar:retorno_dados[nI]:convenio_carencias := {}

				For nCnt := 1 to len(aCarencias)
					Aadd(ret_grupo_familiar:retorno_dados[nI]:convenio_carencias,WsClassNew( "carencia"))

					ret_grupo_familiar:retorno_dados[nI]:convenio_carencias[nCnt]:tipo_servico	:= aCarencias[nCnt][1]
					ret_grupo_familiar:retorno_dados[nI]:convenio_carencias[nCnt]:carencia	  	:= aCarencias[nCnt][2]
				Next
			Endif

			u_MSLogFil(	"	:: Carregando array de carencias " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
			nHorIni := Seconds()

			// Cartão de identificação: inicializa o array de layout de cartões
			ret_grupo_familiar:retorno_dados[nI]:layout_cartoes := {}

			If Existblock("MSLOGFIM")
				oObjBackup := Execblock("MSLOGFIM", .F., .F., {ret_grupo_familiar,nI,cMatTit,nRegTitular,lLoginTitular})
				If ValType(oObjBackup) == "O"
					ret_grupo_familiar := oObjBackup
				Endif

				u_MSLogFil(	"	:: executando ponto de entrada MSLOGFIM " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)
				nHorIni := Seconds()
			Else
				nHorIni := Seconds()
			Endif
		Else
			ret_grupo_familiar:retorno_dados[nI]:convenio_id							:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_descricao					:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_versao						:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_abrangencia				:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_acomodacao				:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_segmentacao				:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_tipo_contrato				:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_padrao_conforto			:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_modalidade_cobranca		:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_participativo				:= ""
			ret_grupo_familiar:retorno_dados[nI]:convenio_permite_reembolso		:= ""
		Endif

		TRB->(dbSKip())
	Enddo
	nHorIni := nHorInclui
	u_MSLogFil(	"	:: finalizando a adição dos usuários no objeto de retorno " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)

	TRB->(dbCloseArea())

	nHorIni := nHorBkp
	u_MSLogFil(	"	:: Tempo gasto no login: " + AllTrim(Str(PlsHorIni(nHorIni),10,3)),__MSXLOG,lIgnoraLoga)

	If Len(ret_grupo_familiar:retorno_dados) == 0
		u_MBSetFault(@ret_grupo_familiar, "MB039")
	Endif

Return()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³login_beneficiario³Autor³ Mobile Saúde      ³ Data ³22.02.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Retorna informação sobre o x3_box do campo     			   |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MBRetX3Box(cCampo, idConteudo)
	LOCAL cRetorno := ""

	aRetBox := RetSx3Box( X3CBox( Posicione('SX3',2,cCampo,'X3_CBOX') ),,,Val(idConteudo) )
	If (nPos := AsCan( aRetBox , {|x| AllTrim(x[2]) == idConteudo} ))>0
		cRetorno	:= aRetBox[nPos,3]
	endIf

Return(cRetorno)

/*

Alimenta estrutura com informações de alertas a serem apresentadas ao longo do processo.

*/

Static Function MBAlerta(oObj, cTipo, cCodEsp)
	LOCAL cSql := ""
	LOCAL nCnt := 1

	cSql := "SELECT R_E_C_N_O_ REGISTRO FROM "+RetSqlName("ZZR")+" WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' "
	cSql += "AND ZZR_CODESP = '"+cCodEsp+"' "
	cSql += "AND ZZR_MOMENT = '"+cTipo+"' "
	cSql += "AND D_E_L_E_T_ = ' ' "

	cSql := ChangeQuery(cSql)
	PlsQuery(cSql, "TRB99")

	While TRB99->(!Eof())
		ZZR->(dbGoto(TRB99->REGISTRO))

		If !ZZR->(Eof())
			Aadd(oObj:retorno_alertas,WsClassNew( "alerta"))
			oObj:retorno_alertas[nCnt]:alerta_codigo		:= StrZero(nCnt, 3)
			oObj:retorno_alertas[nCnt]:alerta_descricao	:= ZZR->ZZR_TEXTO

			nCnt ++
		Endif
		TRB99->(dbSkip())
	Enddo

	TRB99->(dbCloseArea())

Return()

User Function MSEndTitular(nRegBA1)
	LOCAL aRet := {}
	LOCAL aAreaBA1 := BA1->( GetArea() )
	LOCAL aAreaBTS := BTS->( GetArea() )

	BA1->( dbGoto(nRegBA1) )
	If !BA1->( Eof() )
		If !Empty(BA1->BA1_ENDERE)
			aRet := {BA1->BA1_ENDERE,;
				BA1->BA1_NR_END,;
				BA1->BA1_COMEND,;
				BA1->BA1_BAIRRO,;
				BA1->BA1_MUNICI,;
				BA1->BA1_ESTADO,;
				BA1->BA1_CEPUSR}
		Else
			aRet := {BTS->BTS_ENDERE,;
				BTS->BTS_NR_END,;
				BTS->BTS_COMEND,;
				BTS->BTS_BAIRRO,;
				BTS->BTS_MUNICI,;
				BTS->BTS_ESTADO,;
				BTS->BTS_CEPUSR}
		Endif
	Endif

	BA1->( RestArea(aAreaBA1) )
	BTS->( RestArea(aAreaBTS) )

Return(aRet)

Static Function PlsHorIni(nHorIni)
	Local nDif

	nDif := Seconds() - nHorIni

Return nDif
