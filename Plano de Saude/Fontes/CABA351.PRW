#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TBICONN.CH"
#include "topconn.ch"

#define c_Eol chr(13)+chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO10    ºAutor  ³Marcela Coimbra     º Data ³  06/20/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Suspensão Temporária                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CABA351()

	Private c_AliaBlq 	:= "TQRYPESQ"
	Private c_AliTmp  	:= "u_"+c_AliaBlq
	Private c_Chave 	:= "MATRICULA"
	Private lAgCarta	:= .F.
	Private lAgCob     	:= .F.
	Private lAgPgto    	:= .F.
	Private lAnalisar  	:= .F.
	Private lCartaGer  	:= .F.
	Private cBloqAte   	:= ctod("  /  /  ")
	Private cBloqDe    	:= ctod("01/01/2016")
	Private a_Campos 	:= 	{}
	Private a_Struct 	:= 	{}
	Private nTotReg    	:= 0
	Private a_Vet   	:= {}

	Define FONT oFont 	NAME "Arial" SIZE 0,20  Bold

	Prepare Environment Empresa "02" Filial "01"
	
	c_Dia := cvaltochar(dow(DATE()))

	QOut("CABA351 - INICIANDO ROTINA MUDANCA DE BLOQUEIO PARA DEFINITIVO " )

	f597Gera()

	QOut("CABA351 - FINALIZANDO ROTINA MUDANCA DE BLOQUEIO PARA DEFINITIVO " )

	RESET ENVIRONMENT

Return

Static Function f597Gera()

	Local c_Qry 	:= ""
	Local _cMail	:= GETMV("MV_XMAILBL") //Angelo Henrique - Data: 09/05/2019
	Local _cEmpBlq	:= GETMV("MV_XBLQTMP") //Angelo Henrique - Data: 20/09/2021	

	c_Qry := " SELECT ' ' XOK,   "  + c_Eol
	c_Qry += " TO_DATE(trim(BA3_DATBLO), 'YYYYMMDD') DATBLO,   "  + c_Eol
	c_Qry += " ROUND(SYSDATE - TO_DATE(trim(BA3_DATBLO), 'YYYYMMDD') ) QTDDIAS , "  + c_Eol
	c_Qry += " BG9_XSTEMP ,  "  + c_Eol
	c_Qry += " BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG ,  "  + c_Eol
	c_Qry += " BA1_NOMUSR NOME , "  + c_Eol
	c_Qry += " BG1_DESBLO DESBLO , "  + c_Eol
	c_Qry += " BA1.* "  + c_Eol

	c_Qry += " FROM " + RETSQLNAME("BA3") + " BA3 INNER JOIN " + RETSQLNAME("BG1") + " BG1 ON "  + c_Eol
	c_Qry += "                 BG1_FILIAL = ' ' "  + c_Eol
	c_Qry += "                 AND BG1_CODBLO = BA3_MOTBLO "  + c_Eol
	c_Qry += "                 AND BG1_XSTEMP = '1'  "  + c_Eol
	c_Qry += "                 AND Bg1.D_E_L_E_T_ = ' ' "  + c_Eol

	c_Qry += "                 INNER JOIN " + RETSQLNAME("BG9") + " BG9 ON "  + c_Eol
	c_Qry += "                 BG9_FILIAL = ' ' "  + c_Eol
	c_Qry += "                 AND BG9_CODIGO = BA3_CODEMP "  + c_Eol
	c_Qry += "                 AND BG9_CODIGO in (" + Alltrim(_cEmpBlq) + ") "  + c_Eol //Angelo Henrique - Data: 20/09/2021
	c_Qry += "                 AND Bg9.D_E_L_E_T_ = ' ' "  + c_Eol

	c_Qry += "                 INNER JOIN " + RETSQLNAME("BA1") + " BA1 ON "  + c_Eol
	c_Qry += "                 BA1_FILIAL = ' ' "  + c_Eol
	c_Qry += "                 AND BA1_CODINT = BA3_CODINT "  + c_Eol
	c_Qry += "                 AND BA1_CODEMP = BA3_CODEMP "  + c_Eol
	c_Qry += "                 AND BA1_MATRIC = BA3_MATRIC "  + c_Eol	
	c_Qry += "                 AND BA1_TIPUSU = 'T' "  + c_Eol
	c_Qry += "                 AND BA1_MOTBLO = BA3_MOTBLO "  + c_Eol
	c_Qry += " WHERE BA3_FILIAL = ' ' "  + c_Eol
	c_Qry += " AND   SYSDATE - TO_DATE(trim(BA3_DATBLO), 'YYYYMMDD')  >= 60 "  + c_Eol	
	//	c_Qry += " AND   ba1_codemp = '0010' and ba1_matric = '002599' "  + c_Eol //para testar a rotina
	c_Qry += " ORDER BY 1 "  + c_Eol

	If TcCanOpen("TQRYPESQ")
		TcDelFile("TQRYPESQ")
	Endif
	
	If Select("TQRYPESQ") <> 0

		("TQRYPESQ")->(DbCloseArea())

	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"TQRYPESQ",.T.,.T.)

	While !TQRYPESQ->( EOF() )

		fGeraBsq(TQRYPESQ->BA1_CODINT, TQRYPESQ->BA1_CODEMP, TQRYPESQ->BA1_MATRIC, TQRYPESQ->BA1_TIPREG, TQRYPESQ->BA1_DIGITO, /*TQRYPESQ->DATBLO*/ dDataBase, TQRYPESQ->NOME )

		TQRYPESQ->( dbSkip() )

	EndDo

	TQRYPESQ->( dbCloseArea() )  

	If Len( a_Vet ) > 0

		EnvEmail1( _cMail, a_Vet, "Bloqueio definitivo - Rotina automatica" )

	ELSE

		QOut("CABA351 - VETOR VAZIO - NAO ENVIOU EMAIL" )

	EndIf

Return


Static Function fGeraBsq(c_CodInt, c_CodEmp, c_Matric, c_TipReg, c_Digito, d_DataBlo, c_Nome)

	dbSelectArea("BA3")
	dbSetOrder(1)
	If dbSeek( xFilial("BA3") + c_CodInt + c_CodEmp + c_Matric  )

		RecLock("BA3",.F.)
		
		BA3->BA3_MOTBLO := '995'
		BA3->BA3_DATBLO	:= d_DataBlo
		BA3->BA3_BLOFAT	:= '1'
		BA3->(MsUnlock())

		RecLock("BC3",.T.)

		BC3->(Reclock("BC3",.T.))
		BC3->BC3_FILIAL := xFilial("BC3")
		BC3->BC3_MATRIC :=  c_CodInt + c_CodEmp + c_Matric
		BC3->BC3_TIPO   := "1"
		BC3->BC3_DATA   := d_DataBlo
		BC3->BC3_MOTBLO := '9A4'
		BC3->BC3_OBS    := "Desbloqueado pela rotina: BOQUEIO DEFINITIVO EM: " + DTOC( DATE())
		BC3->BC3_MATANT := BA3->BA3_MATANT
		BC3->BC3_BLOFAT := "1"
		BC3->BC3_NIVBLQ := "F"
		BC3->BC3_USUOPE := cUserName
		BC3->(MsUnlock())

		MSUnLock()

		RecLock("BC3",.T.)

		BC3->(Reclock("BC3",.T.))
		BC3->BC3_FILIAL := xFilial("BC3")
		BC3->BC3_MATRIC :=  c_CodInt + c_CodEmp + c_Matric
		BC3->BC3_TIPO   := "0"
		BC3->BC3_DATA   := d_DataBlo
		BC3->BC3_MOTBLO := '995'
		BC3->BC3_OBS    := "Bloqueado pela rotina: BOQUEIO DEFINITIVO EM: " + DTOC( DATE())
		BC3->BC3_MATANT := BA3->BA3_MATANT
		BC3->BC3_BLOFAT := "1"
		BC3->BC3_NIVBLQ := "F"
		BC3->BC3_USUOPE := cUserName
		BC3->(MsUnlock())

		MSUnLock()

		dbSelectArea("BA1")
		dbSetOrder(2)
		If dbSeek( xFilial("BA1") + c_CodInt + c_CodEmp + c_Matric )

			While !BA1->( EOF() ) .AND. BA1->( BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC ) == xFilial("BA1") + c_CodInt + c_CodEmp + c_Matric

				If BA1->BA1_MOTBLO == '765'

					RecLock("BA1",.F.)

					BA1->BA1_MOTBLO := '995'
					BA1->BA1_DATBLO	:= d_DataBlo
					BA1->BA1_BLOFAT	:= '1'

					BA1->(MsUnlock())

					// DESBLOQUEIO
					BCA->(RecLock("BCA",.T.))

					BCA->BCA_FILIAL := xFilial("BCA")
					BCA->BCA_MATRIC := BA1->( BA1_CODINT +  BA1_CODEMP + BA1_MATRIC )
					BCA->BCA_TIPREG := BA1->BA1_TIPREG
					BCA->BCA_DATA 	:= d_DataBlo
					BCA->BCA_TIPO   := "1"
					BCA->BCA_MOTBLO := '9A4'
					BCA->BCA_OBS    := "Desbloqueado pela rotina: BOQUEIO DEFINITIVO EM: " + DTOC( DATE())
					BCA->BCA_DATLAN := dDataBase
					BCA->BCA_USUOPE := "ROTINA AUTOMATICA"					
					BCA->BCA_BLOFAT := "1"
					BCA->BCA_NIVBLQ := "F"
					BCA->BCA_USUOPE := cUserName

					BCA->(MsUnlock())

					// BLOQUEIO

					BCA->(RecLock("BCA",.T.))

					BCA->BCA_FILIAL := xFilial("BCA")
					BCA->BCA_MATRIC := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC )
					BCA->BCA_TIPREG := BA1->BA1_TIPREG
					BCA->BCA_DATA 	:= d_DataBlo
					BCA->BCA_TIPO   := "0"
					BCA->BCA_MOTBLO := '995'
					BCA->BCA_OBS    := "Bloqueado pela rotina: BOQUEIO DEFINITIVO EM: " + DTOC( DATE())
					BCA->BCA_DATLAN := dDataBase
					BCA->BCA_USUOPE := "ROTINA AUTOMATICA"
					BCA->BCA_BLOFAT := "1"
					BCA->BCA_NIVBLQ := "F"
					BCA->BCA_USUOPE := cUserName

					BCA->(MsUnlock())

				EndIf

				BA1->( dbSkip() )

			EndDo

		EndIf

	EndIf
	
	aadd( a_Vet, {c_CodInt + c_CodEmp + c_Matric + c_TipReg, c_Nome, dtoc(d_DataBlo), dtoc(dDataBase )})

return

//-------------------------------------------------------------------
/*/{Protheus.doc} function EnvEmail1
Rotina para enviar e-mail
@author  Marcela
@since   06/20/17
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function EnvEmail1( c_Dest, a_Vet, c_Assunto )

	Local _cMailServer := GetMv( "MV_RELSERV" )
	Local _cMailConta  := GetMv( "MV_EMCONTA" )
	Local _cMailSenha  := GetMv( "MV_EMSENHA" )
	Local _cTo  	   := c_Dest
	Local _cAssunto    := c_Assunto
	Local _cError      := ""
	Local l_Ok         := .T.
	Local _lSendOk     := .F.
	Local n_Cout	   := 0

	QOut("CABA351 - ENTRANDO NA ROTINA DE EMAIL" )

	c_Mensagem := ' <table>'
	c_Mensagem += ' <TR><TD>'
	c_Mensagem += ' <table class="col550" align="left" border="0" cellpadding="0" cellspacing="0" style="width: 100%; max-width: 550px;" bgcolor="#007a4e">'
	c_Mensagem += '                                                 <tr>'
	c_Mensagem += '                                                     <td height="70">'
	c_Mensagem += '                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">'

	c_Mensagem += '                                                            <tr>'
	c_Mensagem += '                                                                <td style="color:white;font-size:30px;text-align:center"   >'
	c_Mensagem += '                                                                    Bloqueio Definitivo - Log de atualizações '
	c_Mensagem += '                                                                </td>'
	c_Mensagem += '                                                            </tr>'
	c_Mensagem += '                                                        </table>'
	c_Mensagem += '                                                    </td>'
	c_Mensagem += '                                                </tr>'
	c_Mensagem += '                                            </table>'
	c_Mensagem += '<TD></TR><TD>	'

	c_Mensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10) + "Prezado(a) :  "

	c_Mensagem +=  Chr(13) + Chr(13)

	c_Mensagem +=  '<TABLE>'
	c_Mensagem +=  '<tr><td>MATRICULA</TD><TD>NOME</TD><TD>DATA BLOQUEIO</td></Tr>'


	For n_Cout := 1 to Len( a_Vet )

		c_Mensagem +=  '<tr><td>' + a_Vet[n_Cout][1] + "</TD><TD>" + PADR(a_Vet[n_Cout][2], 70) +  "</TD><TD>" + PADR(a_Vet[n_Cout][3], 10)  +'</td></Tr>'

	Next

	c_Mensagem +=  '											</TABLE> '

	If !Empty( _cMailServer ) .And.    !Empty( _cMailConta  )

		CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT l_Ok

		If l_Ok

			QOut("CABA351 - DISPARANDO EMAIL" )
			SEND MAIL From _cMailConta To _cTo  Subject _cAssunto Body c_Mensagem  Result _lSendOk

		Else

			GET MAIL ERROR _cError
			Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )

		EndIf

		If l_Ok

			DISCONNECT SMTP SERVER

		EndIf

	ELSE

		QOut("CABA351 - _cMailServer E _cMailConta VAZIOS" )

	EndIf

	QOut("CABA351 - SAINDO NA ROTINA DE EMAIL" )

return()
