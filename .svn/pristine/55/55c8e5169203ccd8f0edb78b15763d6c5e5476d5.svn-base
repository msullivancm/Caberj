#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'UTILIDADES.CH'
#include "Fileio.ch"

#define F_BLOCK  1024

#DEFINE cEnt chr(10)+chr(13)
*************************************************************************************************************

Static lAutentEmail := .F.

*************************************************************************************************************

User Function Util

	Local nRadio 	:= 1
	Local lConf		:= .F.
	Local oDlg1
	Local oRMenu1
	Local oSBtn1

	oDlg1      := MSDialog():New( 095,232,227,521,"Utilidades",,,.F.,,,,,,.T.,,,.T. )

	GoRMenu1   := TGroup():New( 008,007,040,138,"Utilidades",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSBtn1     := SButton():New( 044,112,1,{||lConf := .T.,oDlg1:End()},oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lConf
		If nRadio == 1
			U_UtiCABInt()
		Else
			U_TISS()
		EndIf
	EndIf

Return

************************************************************************************

User Function UtiCABInt

	Local lOk 	:= .F.
	Local aOpc  := {'Ajusta via cartao','Exclui PEG','USERGA e USERGI'}

	Private cOpcCombo

	SetPrvt("oDlg2","oSBtn1","oCBox1")

	oDlg2      := MSDialog():New( 095,232,260,493,"Utilidades Caberj/Integral",,,.F.,,,,,,.T.,,,.T. )

	oCBox1     := TComboBox():New( 012,012,{|u| If(PCount()>0,cOpcCombo:=u,cOpcCombo)},aOpc,108,010,oDlg2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cOpcCombo )

	oSBtn1     := SButton():New( 052,094,1,{||oDlg2:End(),lOk:=.T.},oDlg2,,"", )

	oDlg2:Activate(,,,.T.)

	If lOk

		cAutorizados := GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN') + '|' + GetMv('MV_XTISS')

		If !(RetCodUsr() $ cAutorizados)
			MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
		Else

			Do Case

			Case cOpcCombo == aOpc[1]

				AjuViaCar()

			Case cOpcCombo == aOpc[2]

				U_ExclPEG()

			Case cOpcCombo == aOpc[3]

				U_LogToNome()

			EndCase

		EndIf

	EndIf

Return

************************************************************************************

Static Function AjuViaCar

	Local cMsg 	:= ""
	Local nOpca := 0

	Private oProcess	:= nil
	Private cAlias1		:= GetNextAlias()
	Private cPerg		:= 'AJUVIA'

	AjustaSX1()

	Pergunte(cPerg,.F.)

	aSays := {}
	aAdd(aSays, 'Este programa ajustar a via da matricula informada'   )
	aAdd(aSays, 'pelo usu·rio.')

	aButtons := {}
	aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
	aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
	aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )

	FormBatch( OemToAnsi("Ajuste de via de carteirinha"), aSays, aButtons,, 240, 450 )

	If nOpca == 1

		BA1->(DbSetOrder(2))
		BA1->(DbGoTop())

		If BA1->(MsSeek(xFilial('BA1') + MV_PAR01))

			cMsg += 'Confirma ajuste da via de carteirinha do usuario abaixo?'   							+ cEnt + cEnt
			cMsg += ' - EMPRESA: ' + If(cEmpAnt == '01','CABERJ','INTEGRAL')	  							+ cEnt
			cMsg += ' - MATRICULA: ' + Transform(MV_PAR01,'@R 9999.9999.999999.99-9')					 	+ cEnt
			cMsg += ' - NOME: ' +  AllTrim(BA1->BA1_NOMUSR)													+ cEnt

			If MsgYesNo(cMsg)
				BED->(DbSetOrder(1))//BED_FILIAL + BED_CODINT + BED_CODEMP + BED_MATRIC + BED_TIPREG+BED_DIGITO+BED_FATUR+BED_CONEMP+BED_VERCON+BED_SUBCON+BED_VERSUB+BED_CDIDEN+BED_STATUS
				BED->(DbGoTop())

				If BED->(MsSeek(xFilial('BED') + MV_PAR01))
					nMaxVia := 1//BA1->BA1_VIACAR

					lFinal 		:= .F.
					lAjusVia	:= .F.

					While !BED->(EOF()) .and. ( BED->(BED_FILIAL + BED_CODINT + BED_CODEMP + BED_MATRIC + BED_TIPREG + BED_DIGITO) == xFilial('BED')+MV_PAR01 )
						nMaxVia := If(BED->BED_VIACAR > nMaxVia	,BED->BED_VIACAR,nMaxVia)

						If BED->BED_STACAR <> '2'//Nao Finalizado
							BED->(Reclock('BED',.F.))
							BED->BED_STACAR := '2'
							BED->(MsUnlock())

							lFinal := .T.
						EndIf

						BED->(DbSkip())
					EndDo

					If nMaxVia <> BA1->BA1_VIACAR
						BA1->(Reclock('BA1',.F.))
						BA1->BA1_VIACAR := nMaxVia
						BA1->(MsUnlock())

						lAjusVia := .T.
					EndIf

					cMsg := 'Via de carteirinha ajustada!' + cEnt
					cMsg += If(lFinal,' - Status alterado para finalizado (BED)',' - Nao foi necessario alterar status (BED)') + cEnt
					cMsg += If(lAjusVia,' - Via ajustada para ' + cValToChar(nMaxVia) + ' (BA1)',' - Nao foi necessario ajustar via (BA1)') + cEnt

					MsgInfo(cMsg,If(cEmpAnt == '01','CABERJ','INTEGRAL'))
				Else
					MsgStop('Matricula ' + Transform(MV_PAR01,'@R 9999.9999.999999.99-9') + ': Nao foram encontrados dados para a carteirinha deste usuario!!!',If(cEmpAnt == '01','CABERJ','INTEGRAL'))
				EndIf

			EndIf

		Else
			MsgStop('Matricula ' + Transform(MV_PAR01,'@R 9999.9999.999999.99-9') + ' nao encontrada!!!',If(cEmpAnt == '01','CABERJ','INTEGRAL'))
		EndIf

	EndIf

Return

************************************************************************************

User Function TISS

	Local lOk 	:= .F.
	Local aOpc  := {'Seta Parametros (MV)','Ver guias RDA','Separa guias tipo,ajusta nome e outros','De/para Medlink','Carga Medlink','Importa arq. CRM do CFM','Val. guias verdes/brancas','Sep. Guias Intern. tipo fat.','Rel. mÈdia tempo importacao','RDA X Analista Resp.','Prepara Schemas X usu·rio','Verif. FTP XMLs e distribui p/ usu·rio','De/Para Proc. TUSS','Carga CFM x BB0'}
	Local cUsrAcess :=  SUPERGETMV("MV_XACCTIS", .T., "000833|000716|") // MAX e Fernanda
	
	Private aXMLImp
	Private cPathIni	:= 'SERVIDOR\Protheus_Data\' + Space(200)
	Private cHtmlEntr	:= cPathIni
	Private cPath      	:= cPathIni
	Private cRDAs      	:= Space(300)
	Private cOpcCombo
	Private n_ContNode 	:= 0

	SetPrvt("oDlg2","oSBtn1","oCBox1")
	
	// Ajuste para permitir que somente a opÁ„o de Download FTP apareÁa para o MAX
	if __cUserId $ cUsrAcess
		aOpc  := {'Verif. FTP XMLs e distribui p/ usu·rio'}
	endif 
	
	
	oDlg2      := MSDialog():New( 095,232,260,493,"TISS",,,.F.,,,,,,.T.,,,.T. )

	oCBox1     := TComboBox():New( 012,012,{|u| If(PCount()>0,cOpcCombo:=u,cOpcCombo)},aOpc,108,010,oDlg2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cOpcCombo )

	oSBtn1     := SButton():New( 052,094,1,{||oDlg2:End(),lOk:=.T.},oDlg2,,"", )

	oDlg2:Activate(,,,.T.)

	If lOk

		cAutorizados := GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN') + '|' + GetMv('MV_XTISS')

		If !(RetCodUsr() $ cAutorizados)
			MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
		Else
			if !(__cUserId $ cUsrAcess) // Se n„o for Max e Fernanda
			Do Case

			Case cOpcCombo == aOpc[1]

				ParamTISS()

			Case cOpcCombo == aOpc[2]

				VerGuiasRDA()

			Case cOpcCombo == aOpc[3]

				SepGuiasTipo()

			Case cOpcCombo == aOpc[4]

				DeParaMed()

			Case cOpcCombo == aOpc[5]

				If MsgYesNo('Confirma o envio de carga para a Medlink?')
					u_cargaMedlink()
				EndIf

			Case cOpcCombo == aOpc[6]

				If MsgYesNo('Confirma a atualizaÁ„o da BB0(CRM) atravÈs da importaÁ„o do arquivo do CFM(Conselho Federal de Medicina)?')
					u_caba021()
				EndIf

			Case cOpcCombo == aOpc[7]

				Processa({||ValGVD()},"Processando...")

			Case cOpcCombo == aOpc[8]

				Processa({||SepTpoFat()},"Processando...")

			Case cOpcCombo == aOpc[9]

				U_MEDIAIM()

			Case cOpcCombo == aOpc[10]

				U_RDA_ANA_RES()

			Case cOpcCombo == aOpc[11]

				U_PreImpXML()

			Case cOpcCombo == aOpc[12]

				U_Busc_XML()

			Case cOpcCombo == aOpc[13]

				U_DPProcTUSS()

			Case cOpcCombo == aOpc[14]

				U_CargaBB0()

			EndCase
			
			Else 
			
				U_Busc_XML() 
			
			Endif 

		EndIf

	EndIf

Return

*******************************************

Static Function VerGuiasRDA

	Private cConteudo	:= ''
	Private aFiles
	Private aSizes
	Private nX
	Private cXML
	Private aRDA
	Private aMove		:= {}
	Private aMovePJ		:= {}
	Private aMovePF		:= {}
	Private lConfirm	:= .F.
	Private lIncluiRDA 	:= .T.
	Private lConsEmail 	:= .F.
	Private lSepPFPJ	:= .F.

	SetPrvt("oDlg1","oSay1","oSay3","oSay2","oGet1","oGet3","oCBox1","oSBtn1","oSBtn2","oGet2","oBtn1","oCBox2")

	Set Date to British

	While .T.

		cXML 	:= ''
		aFiles 	:= {}
		aSizes 	:= {}

		oDlg1      := MSDialog():New( 095,232,450,803,"SeleÁ„o TISS",,,.F.,,,,,,.T.,,,.T. )

		oGrp1      := TGroup():New( 008,008,064,280,"DescriÁ„o",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
		oSayT1     := TSay():New( 024,012,{||"Este programa lÍ um arquivo HTML (geralmente enviado por e-mail pela Medlink) e move os arquivos XML que"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)
		oSayT2     := TSay():New( 036,012,{||"existirem na pasta para uma pasta criada automaticamente (movidos) dentro da pasta informada. Somente"}		,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)
		oSayT3     := TSay():New( 048,012,{||"s„o movidos os XML encontrados no e-mail. TambÈm È possÌvel filtrar o RDA (incluir ou excluir do filtro)"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)

		oSay1      := TSay():New( 078,008,{||"Caminho XMLs"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
		oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlg1,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
		oBtn1      := TButton():New( 078,272,"...",oDlg1,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_RETDIRECTORY+GETF_NETWORKDRIVE ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )

		oSay2      := TSay():New( 094,008,{||"RDAs (,)"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
		oGet2      := TGet():New( 094,029,{|u| If(PCount()>0,cRDAs:=u,cRDAs)},oDlg1,251,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRDAs",,)
		oCBox2     := TCheckBox():New( 108,008,"Inclui os RDAs na pesquisa (X) ou exclui da pesquisa ( )",{|u| If(PCount()>0,lIncluiRDAs:=u,lIncluiRDAs)},oDlg1,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

		oSay3      := TSay():New( 124,008,{||"HTML Entrega"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
		oGet3      := TGet():New( 124,029,{|u| If(PCount()>0,cHtmlEntr:=u,cHtmlEntr)},oDlg1,242,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cHtmlEntr",,)
		oBtn1      := TButton():New( 124,272,"...",oDlg1,{||cHtmlEntr:=cGetFile('*.*','HTML',1, cPathIni, .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )
		oCBox4     := TCheckBox():New( 140,008,"Considera e-mail",{|u| If(PCount()>0,lConsEmail:=u,lConsEmail)},oDlg1,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

		oCBox5     := TCheckBox():New( 156,008,"Separa PJ/PF",{|u| If(PCount()>0,lSepPFPJ:=u,lSepPFPJ)},oDlg1,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

		oSBtn1     := SButton():New( 160,224,1,{||oDlg1:End(),lConfirm := .T.},oDlg1,,"", )
		oSBtn2     := SButton():New( 160,254,2,{||oDlg1:End(),lConfirm := .F.},oDlg1,,"", )

		oDlg1:Activate(,,,.T.)

		If lConfirm

			Processa({||ProcXML()},"Processando...")

		Else

			exit

		EndIf

	EndDo

Return

*******************************************

Static Function ProcXML

	Local nX := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nJ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nK := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	If empty(aXMLImp) .and. lConsEmail
		Processa({||aXMLImp := BuscXMLImp(cHtmlEntr)})
	EndIf

	If lSepPFPJ
		cRDAs := ''
	EndIf

	cRDAs 	:= Replace(cRDAs,' ','')

	aRDA 	:= strTokArr(cRDAs,',')

	nCount 	:= aDir(allTrim(cPath) + "*.xml", aFiles, aSizes)

	ProcRegua(nCount)

	nI := 0

	For nX := 1 to nCount

		IncProc('Processando...')

		If lConsEmail .and. aScan(aXMLImp, {|x| Upper(x) == Upper(aFiles[nX])}) <= 0 //XML nao estava no relatorio HTML informado pela Medlink
			loop
		EndIf

		// Abre o arquivo
		nHandle := FT_FUse(cPath + aFiles[nX])

		// Posiciona na primeira linha
		FT_FGoTop()

		While !FT_FEOF()

			cLine := FT_FReadLn() // Retorna a linha corrente

			cTagIni	:= '<ans:codigoPrestadorNaOperadora>'
			cTagFim	:= '</ans:codigoPrestadorNaOperadora>'

			nPosIni	:= At(cTagIni,cLine)
			nPosFim	:= At(cTagFim,cLine)

			If nPosIni <= 0 .or. nPosFim <= 0

				cTagIni	:= '<ansTISS:codigoPrestadorNaOperadora>'
				nPosIni	:= At(cTagIni,cLine)

				cTagFim	:= '</ansTISS:codigoPrestadorNaOperadora>'
				nPosFim	:= At(cTagFim,cLine)

			EndIf

			If nPosIni > 0 .and. nPosFim > 0 //Encontrei a TAG
				exit
			EndIf

			FT_FSKIP()

		EndDo

		// Fecha o Arquivo
		FCLOSE(nHandle)
		FT_FUSE()

		If At(cTagIni,cLine) != Rat(cTagIni,cLine)//As 2 tags estao na mesma linha
			cRDA	:= substr(cLine,nPosIni + 2*len(cTagIni),TamSX3('BAU_CODIGO')[1])
		Else
			cRDA	:= substr(cLine,nPosIni + len(cTagIni),TamSX3('BAU_CODIGO')[1])
		EndIf

		Do Case

		Case !empty(aRDA) .and. lIncluiRDA //Esta verificando XML que contem os RDAs informados

			If aScan(aRDA,{|x|allTrim(x) == allTrim(cRDA)}) > 0

				cXML	+= cValToChar(++nI) + ' - RDA (' + allTrim(cRDA) + '-' + allTrim(posicione('BAU',1,xFilial('BAU') + allTrim(cRDA),'BAU_NOME')) + ')     ' + aFiles[nX] + cEnt

				If aScan(aMove,aFiles[nX]) <=0
					aAdd(aMove,aFiles[nX])
				EndIf

			EndIf

		Case !empty(aRDA) .and. !lIncluiRDA //Esta verificando XML que NAO contem os RDAs informados

			If aScan(aRDA,{|x|allTrim(x) == allTrim(cRDA)}) <= 0

				cXML	+= cValToChar(++nI) + ' - RDA (' + allTrim(cRDA) + '-' + allTrim(posicione('BAU',1,xFilial('BAU') + allTrim(cRDA),'BAU_NOME')) + ')     ' + aFiles[nX] + cEnt

				If aScan(aMove,aFiles[nX]) <=0
					aAdd(aMove,aFiles[nX])
				EndIf

			EndIf

		Otherwise //Nao fez filtro do RDA

			cXML	+= cValToChar(++nI) + ' - RDA (' + allTrim(cRDA) + '-' + allTrim(posicione('BAU',1,xFilial('BAU') + allTrim(cRDA),'BAU_NOME')) + ')     ' + aFiles[nX] + cEnt

			If lSepPFPJ
				If aScan(aMove,aFiles[nX]) <=0
					If posicione('BAU',1,xFilial('BAU') + allTrim(cRDA),'BAU_TIPPE') == 'J'
						aAdd(aMovePJ,aFiles[nX])
					Else
						aAdd(aMovePF,aFiles[nX])
					EndIf
					aAdd(aMove,aFiles[nX])
				EndIf
			ElseIf aScan(aMove,aFiles[nX]) <=0
				aAdd(aMove,aFiles[nX])
			EndIf

		EndCase

	Next

	If nI > 0

		If !empty(aRDA) .and. lIncluiRDA

			cXML	:= 'XML que contÈm os RDAs: ' + cRDAs + cEnt + cEnt + cXML

		ElseIf !empty(aRDA) .and. !lIncluiRDA

			cXML	:= 'XML que n„o contÈm os RDAs: ' + cRDAs + cEnt + cEnt + cXML

		Else

			cXML	:= 'XML' + cEnt + cEnt + cXML

		EndIf

		logErros(cXML,'XMLs')

		cPasta := cPath + 'Movidos\'

		If MsgYesNo('Deseja mover os ' + cValToChar(nI) + ' XML com os RDAs informados para a pasta ' + cPasta)

			MakeDir(cPasta)

			If lSepPFPJ
				MakeDir(cPasta + 'PJ\')
				MakeDir(cPasta + 'PF\')
			EndIf

			nTotMov := If(lSepPFPJ,len(aMovePJ) + len(aMovePF),len(aMove))

			ProcRegua(nTotMov)

			aErrCopy := {}

			If !lSepPFPJ

				For nJ := 1 to nTotMov

					IncProc('Movendo arquivos (' + cValToChar(nJ) + '/' + cValToChar(nTotMov) + ')...')

					If !MoveFile(cPath + aMove[nJ],cPasta + aMove[nJ])
						aAdd(aErrCopy,aMove[nJ])
					EndIf

				Next

			Else
				For nJ := 1 to len(aMovePJ)

					IncProc('Movendo arquivos (' + cValToChar(nJ) + '/' + cValToChar(nTotMov) + ') - PJ...')

					If !MoveFile(cPath + aMovePJ[nJ],cPasta + 'PJ\' + aMovePJ[nJ])
						aAdd(aErrCopy,aMovePJ[nJ])
					EndIf

				Next

				For nJ := 1 to len(aMovePF)

					IncProc('Movendo arquivos (' + cValToChar(nJ) + '/' + cValToChar(nTotMov) + ') - PF...')

					If !MoveFile(cPath + aMovePF[nJ],cPasta + 'PF\' + aMovePF[nJ])
						aAdd(aErrCopy,aMovePF[nJ])
					EndIf

				Next

			EndIf

			If !empty(aErrCopy)

				cMsg := 'Ocorreu um erro ao mover os arquivos' + cEnt + cEnt

				For nK := 1 to len(aErrCopy)
					cMsg += '  - ' + aErrCopy[nK] + cEnt
				Next

				cMsg += cEnt + 'Os outros ' + cValToChar(len(aMove) - len(aErrCopy)) + ' arquivos foram movidos com sucesso'

				LogErros(cMsg,'Erro ao mover os arquivos')

			Else

				MsgInfo(cValToChar(nI) + ' arquivos movidos')

			EndIf

		EndIf

	Else

		MsgInfo('N„o foram encontrados XMLs' + If(!empty(aRDA),' que ' + If(lIncluiRDA,'','n„o') + ' contÈm os RDAs informados.',''))

	EndIf

Return

***************************************************************************

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Verifica o HTML enviado pela medlink e retorna um array somente ≥
//≥com os XML a importar contidos neste HTML.                      ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Static Function BuscXMLImp(cHtmlEntr)

	Local aXMLs 	:= {}
	Local cBuffer 	:= ''

	// Abre o arquivo
	nHandle := FT_FUse(cHtmlEntr)

	// Se houver erro de abertura abandona processamento
	If nHandle == -1
		Alert('N„o foi possÌvel abrir o arquivo HTML')
		Return
	Endif

	// Posiciona na primeira linha
	FT_FGoTop()

	// Retorna o n˙mero de linhas do arquivo
	nLast 	:= FT_FLastRec()
	nCont 	:= 0
	cLast 	:= allTrim(Transform(nLast ,"@E 999,999,999"))

	ProcRegua(nLast)

	While !FT_FEOF()

		IncProc('Lendo a linha ' + allTrim(Transform(++nCont ,"@E 999,999,999")) + ' de ' + cLast + ' do HTML...')

		cBuffer := FT_FReadLn() // Retorna a linha corrente

		nPosXML := at('.xml',cBuffer)

		If nPosXML > 0

			aAdd(aXMLs,substr(cBuffer,nPosXML-53,57))

			cBuffer := substr(cBuffer,nPosXML+4,len(cBuffer)-nPosXML-4)

		EndIf

		FT_FSKIP()

	EndDo

	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE()

Return aXMLs

***************************************************************************

Static Function ParamTISS

	Local lConfirm 	:= .F.

	Private aOpcoes 	:= {"2.01.03","2.02.01","2.02.02","2.02.03"}
	Private cCombo
	Private cMV_TCOMPTP	:= GetMv('MV_TCOMPTP')
	Private cMV_TGUIAS 	:= GetMv('MV_TGUIAS')
	Private cMV_TISS   	:= GetMv('MV_TISS')
	Private cMV_TISSVER	:= GetMv('MV_TISSVER')
	Private cMV_TSIMPTP	:= GetMv('MV_TSIMPTP')
	Private cMV_PLSXMLP	:= GetMv('MV_PLSXMLP') //local da digitacao
	Private cMV_TISSDIR	:= GetMv('MV_TISSDIR')

	aSort(aOpcoes,,,{|x,y| x > y})

	cCombo := aOpcoes[1]

	SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oGet1","oGet2","oGet3","oGet4")
	SetPrvt("oCBox1","oSBtn1","oSBtn2")

	oDlg1      := MSDialog():New( 095,232,464,785,"TISS",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 012,009,162,269,"Par‚metros ImportaÁ„o TISS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 032,017,{||"MV_TISSVER"}	   	   		,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay2      := TSay():New( 046,017,{||"MV_TISS"}				,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay3      := TSay():New( 060,017,{||"MV_TGUIAS"}				,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay4      := TSay():New( 074,017,{||"MV_TCOMPTP"}	   			,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay5      := TSay():New( 088,017,{||"MV_TSIMPTP "}			,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay6      := TSay():New( 130,017,{||"DiretÛrio importaÁ„o"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay7      := TSay():New( 112,017,{||"Alterar p/ vers„o"}		,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)

	oGet1      := TGet():New( 032,061,{|u| If(PCount()>0,cMV_TISSVER:=u,cMV_TISSVER)}		,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TISSVER"		,,)
	oGet2      := TGet():New( 046,061,{|u| If(PCount()>0,cMV_TISS:=u,cMV_TISS)}			,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TISS"		,,)
	oGet3      := TGet():New( 060,061,{|u| If(PCount()>0,cMV_TGUIAS:=u,cMV_TGUIAS)}		,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TGUIAS"		,,)
	oGet4      := TGet():New( 074,061,{|u| If(PCount()>0,cMV_TCOMPTP:=u,cMV_TCOMPTP)}		,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TCOMPTP"		,,)
	oGet5      := TGet():New( 088,061,{|u| If(PCount()>0,cMV_TSIMPTP :=u,cMV_TSIMPTP )}	,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TSIMPTP"		,,)

	cMsg := 'Para mudar o local para importaÁ„o, devem ser copiadas as pastas: TEMP; '
	cMsg += 'CAIXAENTRADA; CAIXASAIDA; PROCESSADOS; NAOPROCESSADOS; SCHEMAS e LOG '
	cMsg += 'do local para importaÁ„o atual para o novo caminho informado!!!' + cEnt + cEnt
	cMsg += '- ESTA ALTERA«√O DEVER¡ SER FEITA MANUALMENTE!!!' + cEnt + cEnt
	cMsg += 'Confirma a alteraÁ„o do local mesmo assim?'

	oCBox1     := TComboBox():New( 112,061,{|u| If(PCount()>0,cCombo:=u,cCombo)},aOpcoes,092,010,oGrp1,,{||altParams(cCombo)},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cCombo )

	oGet6      := TGet():New( 130,061,{|u|If(PCount() > 0,cMV_TISSDIR := u,cMV_TISSDIR)}	,oGrp1,190,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMV_TISSDIR"		,,)
	oBtn1      := TButton():New( 130,252,"...",oGrp1,{||If(MsgYesNo(cMsg),cMV_TISSDIR:=cGetFile('','',1,'\TISS', .F.,GETF_RETDIRECTORY,.T., .T.),)},008,010,,,,.T.,,"",,,,.F. )

	oSay6      := TSay():New( 144,017,{||"Local digitaÁ„o"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
	oGet6      := TGet():New( 144,061,{|u| If(PCount()>0,cMV_PLSXMLP :=u,cMV_PLSXMLP )}	,oGrp1,200,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cMV_PLSXMLP"		,,)

	oSBtn1     := SButton():New( 165,212,1,{||lConfirm := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     := SButton():New( 165,244,2,{||lConfirm := .F.,oDlg1:End()},oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lConfirm .and. MsgYesNo('Confirma a alteraÁ„o dos par‚metros?')

		PutMv('MV_TCOMPTP'	,allTrim(cMV_TCOMPTP)	)
		PutMv('MV_TGUIAS'	,allTrim(cMV_TGUIAS)	)
		PutMv('MV_TISS'		,allTrim(cMV_TISS)		)
		PutMv('MV_TISSVER'	,allTrim(cMV_TISSVER)	)
		PutMv('MV_TSIMPTP'	,allTrim(cMV_TSIMPTP)	)

		If !(allTrim(cMV_PLSXMLP) $ '0002|0011')
			MsgStop('Somente poder· alterar o local para 0002 ou 0011!',AllTrim(SM0->M0_NOMECOM))
		Else
			PutMv('MV_PLSXMLP'	,allTrim(cMV_PLSXMLP)	)
		EndIf

		PutMv('MV_TISSDIR'	,allTrim(cMV_TISSDIR)	)

		MsgInfo('Par‚metros alterados!')

	EndIf

Return

***************************************************************************

Static Function altParams(cCombo)

	Do Case

	Case cCombo == "2.01.03"

		cMV_TCOMPTP	:= 'tissComplexTypesV2_01_03.XSD'
		cMV_TGUIAS 	:= 'tissGuiasV2_01_03.XSD'
		cMV_TISS   	:= 'tissV2_01_03.XSD'
		cMV_TISSVER	:= '2.01.03'
		cMV_TSIMPTP	:= 'tissSimpleTypesV2_01_03.XSD'

	Case cCombo == "2.02.01"

		cMV_TCOMPTP	:= 'tissComplexTypesV2_02_01.XSD'
		cMV_TGUIAS 	:= 'tissGuiasV2_02_01.XSD'
		cMV_TISS   	:= 'tissV2_02_01.XSD'
		cMV_TISSVER	:= '2.02.01'
		cMV_TSIMPTP	:= 'tissSimpleTypesV2_02_01.XSD'

	Case cCombo == "2.02.02"

		cMV_TCOMPTP	:= 'tissComplexTypesV2_02_02.XSD'
		cMV_TGUIAS 	:= 'tissGuiasV2_02_02.XSD'
		cMV_TISS   	:= 'tissV2_02_02.XSD'
		cMV_TISSVER	:= '2.02.02'
		cMV_TSIMPTP	:= 'tissSimpleTypesV2_02_02.XSD'

	Case cCombo == "2.02.03"

		cMV_TCOMPTP	:= 'tissComplexTypesV2_02_03.XSD'
		cMV_TGUIAS 	:= 'tissGuiasV2_02_03.XSD'
		cMV_TISS   	:= 'tissV2_02_03.XSD'
		cMV_TISSVER	:= '2.02.03'
		cMV_TSIMPTP	:= 'tissSimpleTypesV2_02_03.XSD'

	EndCase

Return

***************************************************************************

Static Function SepGuiasTipo

	Private cConteudo	:= ''
	Private aFiles
	Private aSizes
	Private nX
	Private cXML
	Private aRDA
	Private aMove		:= {}
	Private lConfirm	:= .F.
	Private lIncluiRDA 	:= .T.
	Private lAjustaNome	:= .F.
	Private lSepGuiInt	:= .F.
	Private lSepGuiTag	:= .F.
	Private lSepTitTag	:= .F.
	Private oProcess	:= nil

	SetPrvt("oDlg2","oSay1","oSay3","oSay2","oGet1","oGet3","oCBox1","oSBtn1","oSBtn2","oGet2","oBtn1","oCBox2")

	Set Date to British

	cXML 	:= ''
	aFiles 	:= {}
	aSizes 	:= {}

	oDlg2      := MSDialog():New( 095,232,450,803,"SeleÁ„o TISS",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"DescriÁ„o",oDlg2,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||"Este separa os arquivos XML conforme os tipos das guias"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)

	oSay1      := TSay():New( 078,008,{||"Caminho XMLs"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlg2,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
	oBtn1      := TButton():New( 078,272,"...",oDlg2,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_RETDIRECTORY+GETF_NETWORKDRIVE ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )

	oCBox1     := TCheckBox():New( 92,008,"Ajusta nome XML",{|u| If(PCount()>0,lAjustaNome:=u,lAjustaNome)},oDlg2,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox1:cToolTip := 'Retira underlines ( _ ) antes do Hash e forma a string preenchida com zeros atÈ completar 20 caracteres '

	oCBox2     := TCheckBox():New( 102,008,"Separa guias de internaÁ„o",{|u| If(PCount()>0,lSepGuiInt:=u,lSepGuiInt)},oDlg2,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox2:cToolTip := 'Separa guias de internaÁ„o'

	oCBox3     := TCheckBox():New( 112,008,"Separa guias com tag abreviada ( > <\> )",{|u| If(PCount()>0,lSepGuiTag:=u,lSepGuiTag)},oDlg2,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox3:cToolTip := 'Separa guias com tag abreviada ( > <\> ), que est„o dando erro na importaÁ„o.'

	oCBox4     := TCheckBox():New( 122,008,"Separa guias sem tit˙lo da tag (<ansTISS:)",{|u| If(PCount()>0,lSepTitTag:=u,lSepTitTag)},oDlg2,148,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCBox4:cToolTip := 'Separa guias sem tit˙lo da tag (<ansTISS:)'

	oSBtn1     := SButton():New( 150,224,1,{||oDlg2:End(),lConfirm := .T.},oDlg2,,"", )
	oSBtn2     := SButton():New( 150,254,2,{||oDlg2:End(),lConfirm := .F.},oDlg2,,"", )

	oDlg2:Activate(,,,.T.)

	If lConfirm
		oProcess := MsNewProcess():New({||ProcGuiasXML(cPath)},"Processando...","",.T.)
		oProcess:Activate()
	EndIf

Return

*******************************************

Static Function ProcGuiasXML(cPathProc)

	Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local nX := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local nPosSeqTrIni	:= 0
	Local nPosSeqTrFim	:= 0
	Local nAjus 		:= 0
	Local cSeqTrans		:= ''

	nCount 	:= aDir(allTrim(cPathProc) + "*.xml", aFiles, aSizes)

	oProcess:SetRegua1(nCount)

	nI := 0

	For nX := 1 to nCount

		oProcess:IncRegua1('Processando arquivo ' + cValToChar(nX) + ' de ' + cValToChar(nCount))

		// Abre o arquivo
		nHandle := FT_FUse(cPathProc + aFiles[nX])

		//Qtd linhas do arquivos
		nLinhas := FT_FLastRec()

		oProcess:SetRegua2(nLinhas)

		// Posiciona na primeira linha
		FT_FGoTop()

		lInicio := .T.

		While !FT_FEOF()

			oProcess:IncRegua2('Processando...')

			If lInicio

				//Tento ler o arquivo ate a versao, todavia a funcao MemoRead pode nao retornar todo o conteudo do arquivo
				//pois esta possui limitacao de tamanho. Se nao retornar o hash, sou obrigado a ler linha a linha do arquivo
				cArq := MemoRead(cPathProc + aFiles[nX])

				nPosIni	:= At('<ans:versaoPadrao>',cArq)
				nPosFim	:= At('</ans:versaoPadrao>',cArq)

				If nPosIni <= 0 .or. nPosFim <= 0
					nPosIni	:= At('<ansTISS:versaoPadrao>',cArq)
					nPosFim	:= At('</ansTISS:versaoPadrao>',cArq)
				EndIf

				If nPosIni <= 0 .or. nPosFim <= 0
					nPosIni	:= At('<versaoPadrao>',cArq)
					nPosFim	:= At('</versaoPadrao>',cArq)
				EndIf

				nPosSeqTrIni 	:= At('<ans:sequencialTransacao>',cArq)
				nPosSeqTrFim 	:= At('</ans:sequencialTransacao>',cArq)
				nAjus 			:= Len('<ans:sequencialTransacao>')

				If nPosSeqTrIni <= 0 .or. nPosSeqTrFim <= 0
					nPosSeqTrIni	:= At('<ansTISS:sequencialTransacao>',cArq)
					nPosSeqTrFim	:= At('</ansTISS:sequencialTransacao>',cArq)
					nAjus 			:= Len('<ansTISS:sequencialTransacao>')
				EndIf

				If nPosSeqTrIni <= 0 .or. nPosSeqTrFim <= 0
					nPosSeqTrIni	:= At('<sequencialTransacao>',cArq)
					nPosSeqTrFim	:= At('</sequencialTransacao>',cArq)
					nAjus 			:= Len('<sequencialTransacao>')
				EndIf

				If nPosSeqTrIni > 0 .and. nPosSeqTrFim > 0
					cSeqTrans := PadL(substr(cArq,nPosSeqTrIni+nAjus,nPosSeqTrFim-nPosSeqTrIni-nAjus),20,'0')
				EndIf

				If nPosIni > 0 .and. nPosFim > 0
					cVersTiss := substr(cArq,nPosFim-7,7)//substr(cArq,nPosIni+18,nPosFim-nPosIni-18)
					cVersTiss := 'V' + replace(cVersTiss,'.','_')
					exit//Se achou sai e nao precisa ler linha a linha
				EndIf

				lInicio := .F.

			EndIf

			cLine := FT_FReadLn() // Retorna a linha corrente

			nPosIni	:= At('<ans:versaoPadrao>',cLine)
			nPosFim	:= At('</ans:versaoPadrao>',cLine)

			If nPosIni <= 0 .or. nPosFim <= 0
				nPosIni	:= At('<ansTISS:versaoPadrao>',cLine)
				nPosFim	:= At('</ansTISS:versaoPadrao>',cLine)
			EndIf

			If nPosIni <= 0 .or. nPosFim <= 0
				nPosIni	:= At('<versaoPadrao>',cLine)
				nPosFim	:= At('</versaoPadrao>',cLine)
			EndIf

			If nPosIni > 0 .and. nPosFim > 0
				cVersTiss := substr(cLine,nPosFim-7,7)//substr(cLine,nPosIni+18,nPosFim-nPosIni-18)
				cVersTiss := 'V' + replace(cVersTiss,'.','_')
				exit
			EndIf

			FT_FSKIP()

		EndDo

		If lAjustaNome

			cHash := ""

			//Tento ler o arquivo ate o hash, todavia a funcao MemoRead pode nao retornar todo o conteudo do arquivo
			//pois esta possui limitacao de tamanho. Se nao retornar o hash, sou obrigado a ler linha a linha do arquivo
			cArq := MemoRead(cPathProc + aFiles[nX])

			nPosHashIni	:= At('<ans:hash>',cArq)
			nPosHashFim	:= At('</ans:hash>',cArq)

			If nPosHashIni <= 0 .or. nPosHashFim <= 0
				nPosHashIni	:= At('<hash>',cArq)
				nPosHashFim	:= At('</hash>',cArq)
			EndIf

			If nPosHashIni <= 0 .or. nPosHashFim <= 0

				While !FT_FEOF()

					oProcess:IncRegua2('Procurando Hash...')

					cLine := FT_FReadLn() // Retorna a linha corrente

					nPosHashIni	:= At('<ans:hash>',cLine)
					nPosHashFim	:= At('</ans:hash>',cLine)

					If nPosHashIni <= 0 .or. nPosHashFim <= 0
						nPosHashIni	:= At('<hash>',cArq)
						nPosHashFim	:= At('</hash>',cArq)
					EndIf

					If nPosHashIni > 0 .and. nPosHashFim > 0
						cHash := substr(cLine,nPosHashIni+10,nPosHashFim-nPosHashIni-10)

						oProcess:SetRegua2(1)
						oProcess:IncRegua2("Hash encontrado!")

						exit
					EndIf

					FT_FSKIP()

				EndDo

			Else

				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Hash encontrado!")

				cHash 	:= substr(cArq,nPosHashIni+10,nPosHashFim-nPosHashIni-10)
				cArq 	:= ""

			EndIf

		EndIf

		lAchouInter := .F.

		If lSepGuiInt

			cArq := MemoRead(cPathProc + aFiles[nX])

			If At('guiaResumoInternacao',cArq) > 0
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Guia de internaÁ„o encontrada!")
				lAchouInter := .T.
			Else
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Analisando...")
			EndIf

		EndIf

		lAchouTag := .F.

		If lSepGuiTag

			cArq := MemoRead(cPathProc + aFiles[nX])

			If (At(' />',cArq) > 0) .or. (At('><\>',cArq) > 0) .or. (At('> <\>',cArq) > 0) .or. (At('>  <\>',cArq) > 0) .or. (At('>   <\>',cArq) > 0)
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Guia com tag abreviada encontrada!")
				lAchouTag := .T.
			Else
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Analisando...")
			EndIf

		EndIf

		lAchouTitSTag := .F.

		If lSepTitTag

			cArq := MemoRead(cPathProc + aFiles[nX])

			If (At('<ANSTISS:',Upper(cArq)) <= 0)
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Guia sem tit˙lo de tag encontrada!")
				lAchouTitSTag := .T.
			Else
				oProcess:SetRegua2(1)
				oProcess:IncRegua2("Analisando...")
			EndIf

		EndIf

		//Fecha o Arquivo
		FCLOSE(nHandle)
		FT_FUSE()

		MakeDir(cPathProc + cVersTiss + '\')

		If lSepGuiInt .and. lAchouInter
			MakeDir(cPathProc + cVersTiss + '\' + 'Guias_Internacao\')
		Elseif lSepGuiTag .and. lAchouTag
			MakeDir(cPathProc + cVersTiss + '\' + 'Guias_Tags_Abreviadas\')
		ElseIf lSepTitTag .and. lAchouTitSTag
			MakeDir(cPathProc + cVersTiss + '\' + 'Guias_Tags_Sem_Titulo_ansTISS\')
		EndIf

		If lAjustaNome

			cNovoNome 		:= aFiles[nX]

			//nPosUnderDir 	:= Rat('_',cNovoNome)
			nPosPonto 		:= Rat('.',cNovoNome)

			cHashExt 		:= cHash + right(cNovoNome,len(cNovoNome) - nPosPonto + 1)
			/*
			cPrefixo 		:= left(cNovoNome,nPosUnderDir - 1)

			cPrefixo 		:= allTrim(strTran(cPrefixo,'_',''))
			cPrefixo		:= replicate('0',20 - len(cPrefixo)) + cPrefixo

			cNovoNome		:= cPrefixo + '_' + cHashExt
			*/
			cNovoNome		:= cSeqTrans + '_' + cHashExt

			If FRename(cPathProc + aFiles[nX] , cPathProc + cNovoNome) != -1

				aFiles[nX] := cNovoNome

			EndIf

		EndIf

		If lSepGuiInt .and. lAchouInter
			MoveFile(cPathProc + aFiles[nX],cPathProc + cVersTiss + '\' + 'Guias_Internacao\' + aFiles[nX])
		ElseIf lSepGuiTag .and. lAchouTag
			MoveFile(cPathProc + aFiles[nX],cPathProc + cVersTiss + '\' + 'Guias_Tags_Abreviadas\' + aFiles[nX])
		ElseIf lSepTitTag .and. lAchouTitSTag
			MoveFile(cPathProc + aFiles[nX],cPathProc + cVersTiss + '\' + 'Guias_Tags_Sem_Titulo_ansTISS\' + aFiles[nX])
		Else
			MoveFile(cPathProc + aFiles[nX],cPathProc + cVersTiss + '\' + aFiles[nX])
		EndIf

	Next

Return

**************************************************************************************************************************************

Static Function DeParaMed

	Local aButtons := {}

	aAdd(aButtons,{"Exportar",'U_ExpPAT()',0,6})

	AxCadastro("PAT", "De/para Medlink",,,aButtons)

Return

*************************************************************************************************************

User Function ExpPAT

	Local cNome 	:= "TABELA " + allTrim(SM0->M0_NOME) + " - " + DtoS(dDatabase) + "_" + StrTran(Time(),":","")
	Local cArq		:= GetTempPath() + cNome + ".CSV"
	Local nHdl 		:= FCreate(cArq)
	Local cBuffer	:= 'CABERJ;MEDLINK' + cEnt

	FWrite(nHdl,cBuffer,len(cBuffer))

	dbSelectArea('PAT')
	dbSetOrder(1)

	While !PAT->(EOF())

		If PAT->PAT_USADO == 'S'

			cBuffer := "'" + StrZero(Val(PAT->PAT_CABERJ),2) + ";'" + StrZero(Val(PAT->PAT_MEDLINK),2) + cEnt

			FWrite(nHdl,cBuffer,len(cBuffer))

		EndIf

		PAT->(dbSkip())

	EndDo

	FClose(nHdl)

	ExecExcel(cArq,,'GRUPO CABERJ')

Return

********************************************************************************************

User Function AjustaGuias

	Private oProcess   	:= Nil
	Private cCodOpe    	:= Space(4)
	Private cCodPEG    	:= Space(8)
	Private cLocDig    	:= Space(4)
	Private cNumFim    	:= Space(8)
	Private cNumIni    	:= Space(8)
	Private cSoReproc 	:= 'Sim'
	Private cAjustaXX 	:= 'Sim'
	Private lOk		   	:= .F.
	Private clMudaFase	:= 'Sim'
	Private cRegeraBD7	:= 'N„o'

	SetPrvt("oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oGet1","oGet2","oGet3","oGet4","oGet5")
	SetPrvt("oSBtn1","oSBtn2")

	//MsDialog(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight],
	oDlg1      := MSDialog():New( 0,0,400,350,"Ajusta Guias",,,.F.,,,,,,.T.,,,.T. )

	oSay1      := TSay():New( 012,016,{||"Operadora"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      := TSay():New( 028,016,{||"Local de digitaÁ„o"}		,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
	oSay3      := TSay():New( 044,016,{||"PEG"}						,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      := TSay():New( 060,016,{||"N˙mero De"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay5      := TSay():New( 076,016,{||"N˙mero AtÈ"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay6      := TSay():New( 092,016,{||"Somente reprocessa?"}		,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay7      := TSay():New( 108,016,{||"Ajusta XX?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay8      := TSay():New( 124,016,{||"Muda fase?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay8      := TSay():New( 140,016,{||"Regera BD7?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)

	oGet1      := TGet():New( 012,080,{|u| If(PCount()>0,cCodOpe:=u,cCodOpe)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{||cCodOpe:=StrZero(Val(cCodOpe),4)},.F.,.F.,"","cCodOpe",,)
	oGet2      := TGet():New( 028,080,{|u| If(PCount()>0,cLocDig:=u,cLocDig)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{||cLocDig:=StrZero(Val(cLocDig),4)},.F.,.F.,"","cLocDig",,)
	oGet3      := TGet():New( 042,080,{|u| If(PCount()>0,cCodPEG:=u,cCodPEG)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{||cCodPEG:=StrZero(Val(cCodPEG),8)},.F.,.F.,"","cCodPEG",,)
	oGet4      := TGet():New( 060,080,{|u| If(PCount()>0,cNumIni:=u,cNumIni)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{||cNumIni:=StrZero(Val(cNumIni),8)},.F.,.F.,"","cNumIni",,)
	oGet5      := TGet():New( 076,080,{|u| If(PCount()>0,cNumFim:=u,cNumFim)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,{||cNumFim:=StrZero(Val(cNumFim),8)},.F.,.F.,"","cNumFim",,)

	oCBox1     := TComboBox():New( 092,080,{|u| If(PCount()>0,cSoReproc:=u,cSoReproc)}	,{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cSoReproc" )
	oCBox2     := TComboBox():New( 108,080,{|u| If(PCount()>0,cAjustaXX:=u,cAjustaXX)}	,{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cAjustaXX" )
	oCBox3     := TComboBox():New( 122,080,{|u| If(PCount()>0,clMudaFase:=u,clMudaFase)},{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"clMudaFase" )
	oCBox4     := TComboBox():New( 136,080,{|u| If(PCount()>0,cRegeraBD7:=u,cRegeraBD7)},{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cRegeraBD7" )

	oSBtn1     := SButton():New( 160,104,1,{||lOk := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     := SButton():New( 160,136,2,{||lOk := .F.,oDlg1:End()},oDlg1,,"", )

	oDlg1:Activate(,,,.T.)

	If lOk
		If !(RetCodUsr() $ GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN'))
			MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
		Else
			oProcess := MsNewProcess():New({||ProcAjGuias(cCodOpe,cLocDig,cCodPEG,cNumIni,cNumFim,(cSoReproc == 'Sim'),(cAjustaXX == 'Sim'),( clMudaFase == 'Sim'),(cRegeraBD7 == 'Sim')) },'Ajuste de guias',"",.T.)
			oProcess:Activate()
		EndIf
	EndIf

Return

********************************************************************************************

//Ajusta guias em lote

User Function AjustaGLT

	Local cAutorizados 	:= GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN')
	Local aGuiasRev		:= {}

	Private c_GuiasRev
	Private cLocalDig
	Private cCodOpe
	Private c_CodPeg
	Private c_RDA
	Private c_Guia        
	Private oProcess  := nil

	If !(RetCodUsr() $ cAutorizados)
		MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
		Return
	EndIf

	nOpca := 0

	cMsg := "Informe em cada linha: Operadora, Local de Digitacao, PEG, Guia. Separe os codigos por ponto-e-virgula ( ; )" + cEnt + cEnt
	cMsg += 'CONTINUA?'

	If MsgYesNo(cMsg,SM0->M0_NOMECOM)

		c_GuiasRev := LogErros('','Ajuste de guias em lote. (Informe: Operadora;Local de Digitacao;PEG;Guia p/ linha)',.F.,'M')

		If empty(c_GuiasRev)
			MsgStop('Informe as PEGs/Guias',SM0->M0_NOMECOM)
		Else

			Processa({||aGuiasRev := GetAjGuias(c_GuiasRev)},"Verificando dados de entrada")

			c_GuiasRev := ''

			If !empty(aGuiasRev)

				Private cSoReproc 	:= 'Sim'
				Private cAjustaXX 	:= 'Sim'
				Private lOk		   	:= .F.
				Private clMudaFase	:= 'Sim'
				Private cRegeraBD7	:= 'N„o'

				SetPrvt("oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oGet1","oGet2","oGet3","oGet4","oGet5")
				SetPrvt("oSBtn1","oSBtn2")

				oDlg1      := MSDialog():New( 0,0,400,350,"Ajusta Guias",,,.F.,,,,,,.T.,,,.T. )

				oSay6      := TSay():New( 012,016,{||"Somente reprocessa?"}		,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
				oSay7      := TSay():New( 028,016,{||"Ajusta XX?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
				oSay8      := TSay():New( 042,016,{||"Muda fase?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
				oSay8      := TSay():New( 060,016,{||"Regera BD7?"}				,oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)

				oCBox1     := TComboBox():New( 012,080,{|u| If(PCount()>0,cSoReproc:=u,cSoReproc)}	,{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cSoReproc" )
				oCBox2     := TComboBox():New( 028,080,{|u| If(PCount()>0,cAjustaXX:=u,cAjustaXX)}	,{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cAjustaXX" )
				oCBox3     := TComboBox():New( 042,080,{|u| If(PCount()>0,clMudaFase:=u,clMudaFase)},{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"clMudaFase" )
				oCBox4     := TComboBox():New( 060,080,{|u| If(PCount()>0,cRegeraBD7:=u,cRegeraBD7)},{"Sim","Nao"},044,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cRegeraBD7" )

				oSBtn1     := SButton():New( 084,104,1,{||lOk := .T.,oDlg1:End()},oDlg1,,"", )
				oSBtn2     := SButton():New( 084,136,2,{||lOk := .F.,oDlg1:End()},oDlg1,,"", )

				oDlg1:Activate(,,,.T.)

				If lOk
					Processa({||ProcAjuGuias(aGuiasRev)},"Ajuste de guias")
					MsgInfo('Ajuste de guias realizado!',SM0->M0_NOMECOM)

				EndIf
			Else
				MsgAlert('Array de guias retornou vazio!',SM0->M0_NOMECOM)
			EndIf

		EndIf

	EndIf

Return

***************************************************************************************************************

Static Function GetAjGuias(c_GuiasRev)

	Local aRet 		:= {}
	Local aBuffer 	:= {}
	Local nI 		:= 1
	Local nCount	:= 1

	ProcRegua(0)

	For nI:=1 to 5
		IncProc('Verificando...')
	Next

	aBuffer := Separa(c_GuiasRev,CHR(13) + CHR(10))

	ProcRegua(len(aBuffer))

	For nCount := 1 to len(aBuffer)
		IncProc('Lendo dados... ' + cValToChar(nCount) + ' de ' + cValToChar(len(aBuffer)))

		//So adiciono ao vetor de ajuste os que nao sao duplicados
		If ( aScan(aBuffer,{|x|x == aBuffer[nCount]}) == nCount )
			aAdd(aRet,Separa(aBuffer[nCount],';'))
		EndIf
	Next

	aBuffer := {}

	ProcRegua(len(aRet))

	For nCount := 1 to len(aRet)

		IncProc('Validando dados... ' + cValToChar(nCount) + ' de ' + cValToChar(len(aRet)))

		If ValType(aRet) <> 'A'
			MsgStop('Linha ' + cValToChar(nCount) + ' : Erro nos parametros. Retorno do Separa(cLinha,";") nao eh array!',SM0->M0_NOMECOM)
			Return {}
		ElseIf len(aRet[nCount]) <> 4
			MsgStop('Linha ' + cValToChar(nCount) + ' : Informada a quantidade errada de parametros!',SM0->M0_NOMECOM)
			Return {}
		EndIf

	Next

Return aRet

***************************************************************************************************************

Static Function ProcAjuGuias(aGuias)

	Local cTot
	Local nContador := 0
	Local nQtdGuias	:= len(aGuias)

	ProcRegua(nQtdGuias)

	cTot := cValToChar(nQtdGuias)

	For nContador := 1 to nQtdGuias

		IncProc('Processando ' + cValToChar(nContador) + ' de ' + cTot)

		cCodOpe		:= aGuias[nContador][1]
		cLocalDig	:= aGuias[nContador][2]
		c_CodPeg	:= aGuias[nContador][3]
		c_Guia		:= aGuias[nContador][4]

		oProcess := MsNewProcess():New({|| ProcAjGuias(cCodOpe,cLocalDig,c_CodPeg,c_Guia,c_Guia,(cSoReproc == 'Sim'),(cAjustaXX == 'Sim'),( clMudaFase == 'Sim'),(cRegeraBD7 == 'Sim'),.F.,.F.) },'Ajuste de guias',"",.T.)
		//ProcAjGuias(cCodOpe,cLocalDig,c_CodPeg,c_Guia,c_Guia,(cSoReproc == 'Sim'),(cAjustaXX == 'Sim'),( clMudaFase == 'Sim'),(cRegeraBD7 == 'Sim'),.F.,.F.)
		oProcess:Activate()

	Next

Return

***************************************************************************************************************

Static Function ProcAjGuias(cCodOpe,cLocDig,cCodPEG,cNumIni,cNumFim,lSoReprocessa,lAjustaXX,lMudaFase,lRegeraBD7,lMostraMsg,lProcMsg)

	Local cNumero		:= cNumIni
	Local cChaveBD6 	:= xFilial('BD6') + cCodOpe + cLocDig + cCodPEG
	Local nTot			:= Val(cNumFim)-Val(cNumIni)+1
	Local nCont			:= 0

	Default lMostraMsg 	:= .T.
	Default lProcMsg 	:= .T.

	oProcess:SetRegua1((nTot * 2) + 1)
	oProcess:SetRegua2(0)

	oProcess:IncRegua1('Iniciando processamento...')

	BD6->(DbSetOrder(1))//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO

	While Val(cNumero) <= Val(cNumFim)

		++nCont

		If lProcMsg
			oProcess:IncRegua1('Processando...' + cValToChar(nCont) + ' de ' + cValToChar(nTot) + ' (BD6)')
		EndIf

		If BD6->(MsSeek(cChaveBD6 + cNumero))

			//Protocolo de entrega de guias
			BCI->(DbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC

			If !BCI->(MsSeek(xFilial('BCI') + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG)))
				cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
				Loop
			EndIf

			//Tipos de guias
			BCL->(DbSetOrder(1))//BCL_FILIAL + BCL_CODOPE + BCL_TIPGUI

			If !BCL->(MsSeek(xFilial('BCL') + BD6->(BD6_CODOPE + BD6_TIPGUI)))
				cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
				Loop
			EndIf

			Do Case

			Case ( BCL->BCL_ALIAS == 'BD5' )

				BD5->(DbSetOrder(1))

				If !BD5->(DbSeek(xFilial('BD5') + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)) ) .or. ( BD5->BD5_FASE == '4' ) .or. ( BD5->BD5_SITUAC <> '1' )
					cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
					Loop
				EndIf

				If ( BD5->BD5_FASE $ '2|3' )//CONFERENCIA | PRONTA

					If lProcMsg
						oProcess:IncRegua2('Retornando fase...')
					EndIf

					a_ArBD6 	:= BD6->(GetArea())
					a_ArCorr 	:= GetArea()

					//Retorno a fase para reprocessar
					PLSA500RFS('BD5',BD5->(Recno()),0,nil,.T.)

					BD6->(RestArea(a_ArBD6))
					RestArea(a_ArCorr)

				EndIf

			Case ( BCL->BCL_ALIAS == 'BE4' ) .and. ( BCL->BCL_TIPGUI == '05' )//GRI

				BE4->(DbSetOrder(1))

				If !BE4->(DbSeek(xFilial('BE4') + BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)) ) .or. ( BE4->BE4_FASE == '4' ) .or. ( BE4->BE4_SITUAC <> '1' )
					cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
					Loop
				EndIf

				If ( BE4->BE4_FASE $ '2|3' )//CONFERENCIA | PRONTA

					If lProcMsg
						oProcess:IncRegua2('Retornando fase...')
					EndIf

					a_ArBD6 	:= BD6->(GetArea())
					a_ArCorr 	:= GetArea()

					//Retorno a fase para reprocessar
					PLSA500RFS('BE4',BD5->(Recno()),0,nil,.T.)

					BD6->(RestArea(a_ArBD6))
					RestArea(a_ArCorr)

				EndIf

			Case ( BCL->BCL_ALIAS == 'BE4' )//Nao implementado

				cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
				Loop

			Otherwise

				cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])
				Loop

			EndCase

			While BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == ( cChaveBD6 + cNumero )

				If lProcMsg
					oProcess:IncRegua2('Verificando BD6...')
				EndIf

				//Ajusta tabelas que foram informadas erradas e o sistema colocou como XX na tabela. So altera se encontrar somente uma tabela para o procedimento.
				If BD6->BD6_CODPAD == Replicate('X',TamSx3('BD6_CODPAD')[1])
					aAreaBD6 := BD6->(GetArea())

					cAlias := GetNextAlias()

					cQuery := "SELECT BR8_CODPAD,BR8_DESCRI" 					+ cEnt
					cQuery += "FROM " + RetSqlName('BR8') 						+ cEnt
					cQuery += "WHERE D_E_L_E_T_ = ' '" 							+ cEnt
					cQuery += "		AND BR8_FILIAL = '" + xFilial('BR8') + "'" 	+ cEnt
					cQuery += "		AND BR8_CODPSA = '" + BD6->BD6_CODPRO + "'"	+ cEnt
					cQuery += "		AND BR8_CODPAD IN ('01','16')" 				+ cEnt

					TcQuery cQuery New Alias cAlias

					cAlias->(DbGoTop())
					nTot2 := 0
					cAlias->(DbEval({||++nTot2}))
					cAlias->(DbGoTop())

					cTab 	:= cAlias->BR8_CODPAD
					cDescri	:= Left(AllTrim(cAlias->BR8_DESCRI),TamSx3('BD6_DESPRO')[1])

					cAlias->(DbCloseArea())

					BD6->(RestArea(aAreaBD6))

					If nTot2 == 1 .and. (!lSoReprocessa .or. lAjustaXX)
						BD6->(Reclock('BD6',.F.))

						BD6->BD6_CODPAD 	:= cTab
						BD6->BD6_DESPRO		:= cDescri

						BD6->(MsUnlock())
					EndIf

				EndIf

				If lRegeraBD7

					If lProcMsg
						oProcess:IncRegua2('Verificando BD7 (regerando)...')
					EndIf

					a_ArBD6 	:= BD6->(GetArea())
					a_ArBD7 	:= BD7->(GetArea())
					a_ArCorr 	:= GetArea()

					If ( BD6->BD6_STATUS <> "0" )//Nao autorizada - Vermelho no BMP

						BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC

						If BD7->(MsSeek(cChaveBD6 + cNumero)) .and. ( BD7->BD7_FASE <> '4' )

							While BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) == (cChaveBD6 + cNumero)

								If  ( BD6->( BD6_CODPAD + BD6_CODPRO + BD6_SEQUEN ) == BD7->( BD7_CODPAD + BD7_CODPRO + BD7_SEQUEN ) ) .and. ( BD7->BD7_FASE <> '4' )

									//Deleto a BD7 para ser regerada no PLS720IBD7 que vem a seguir

									BD7->(Reclock('BD7',.F.))
									BD7->(DbDelete())
									BD7->(MsUnlock())

								EndIf

								BD7->(DbSkip())

							EndDo

						EndIf

					EndIf

					BD7->(RestArea(a_ArBD7))
					BD6->(RestArea(a_ArBD6))
					RestArea(a_ArCorr)

				EndIf

				If lProcMsg
					oProcess:IncRegua2('Verificando BD7 (inclus„o)...')
				EndIf

				//Inclui BD7 se nao existir
				PLS720IBD7(BD6->BD6_PACOTE,BD6->BD6_VLPGMA,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODTAB,BD6->BD6_CODOPE,BD6->BD6_CODRDA,;
					BD6->BD6_REGEXE,BD6->BD6_SIGEXE,BD6->BD6_ESTEXE,BD6->BD6_CDPFRE,BD6->BD6_CODESP,BD6->(BD6_CODLOC+BD6_LOCAL),;
					"1",BD6->BD6_SEQUEN,BCL->BCL_CDORIT,BCL->BCL_TIPGUI,BD6->BD6_DATPRO)

				BD6->(DbSkip())

			EndDo

			c_AliasCorr := BCL->BCL_ALIAS

			&(c_AliasCorr + '->(DbSetOrder(1))')//(BD5 OU BE4) BD5_FILIAL + BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_SITUAC + BD5_FASE + DTOS(BD5_DATPRO) + BD5_OPERDA + BD5_CODRDA

			If lProcMsg
				oProcess:IncRegua1('Processando...' + cValToChar(nCont) + ' de ' + cValToChar(nTot) + ' ' + c_AliasCorr)
			EndIf

			If &(c_AliasCorr + "->(MsSeek('" + cChaveBD6 + cNumero + "'))")

				aAreaB := &(c_AliasCorr + '->(GetArea())')
				/*
				If ( BD5->BD5_SITUAC == '1' ) .and. ( BD5->BD5_FASE $ '2|3' )//CONFERENCIA | PRONTA
					oProcess:IncRegua2('Retornando fase...')

					//Retorno a fase para reprocessar
					PLSA500RFS('BD5',BD5->(Recno()),0,nil,.T.)
				EndIf
				*/
				BD6->(DbSetOrder(1))//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO

				If ( BD6->(MsSeek(cChaveBD6 + cNumero)) )

					While BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == cChaveBD6 + cNumero

						If !lSoReprocessa .and. ( BD6->BD6_STATUS <> "0" ) .and. ( BD6->BD6_FASE <> '4' )//BD6_STATUS: Nao autorizada - Vermelho no BMP

							BD6->(Reclock('BD6',.F.))

							BD6->BD6_BLOPAG 	:= ""
							BD6->BD6_MOTBPG 	:= Space(TamSX3('BD6_MOTBPG')[1])
							BD6->BD6_DESBPG		:= Space(TamSX3('BD6_DESBPG')[1])

							BD6->(MsUnlock())

						EndIf

						If ( BD6->BD6_STATUS <> "0" )//Nao autorizada - Vermelho no BMP

							BD7->(DbSetOrder(2))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_CODPAD + BD7_CODPRO + BD7_CODUNM + BD7_NLANC

							If BD7->(MsSeek(cChaveBD6 + cNumero))
								//Tratamento das guias bloqueadas
								While BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) == (cChaveBD6 + cNumero)

									If lProcMsg
										oProcess:IncRegua2('Verificando BD7 (bloqueio)...')
									EndIf

									If ( BD7->BD7_FASE <> '4' )

										BD7->(Reclock('BD7',.F.))

										If ( AllTrim(BD7->BD7_CODUNM) <> 'PA' ) .and. ( BD7->BD7_BLOPAG <> '0' )
											BD7->BD7_BLOPAG := '0'
											BD7->BD7_MOTBLO := Space(TamSX3('BD7_MOTBLO')[1])
											BD7->BD7_DESBLO := Space(TamSX3('BD7_DESBLO')[1])
										//ElseIf ( AllTrim(BD7->BD7_CODUNM) == 'PA' ) .and. ( BD7->BD7_BLOPAG <> '1' )
										//	BD7->BD7_BLOPAG := '1'
										EndIf

										If empty(BD7->BD7_CODTPA)
											BD7->BD7_CODTPA := "H"
										EndIf

										BD7->(MsUnlock())
										
										//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio CobranÁa
										u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
	    	
									EndIf

									BD7->(DbSkip())
								EndDo
							EndIf

						EndIf

						BD6->(DbSkip())

					EndDo

				EndIf

				&(c_AliasCorr + '->(RestArea(aAreaB))')

				If lProcMsg
					oProcess:IncRegua2('Mudando fase...')
				EndIf

				If !lSoReprocessa .and. lMudaFase
					//Muda a fase da guia
					&("PLSA500FAS('" + c_AliasCorr + "',,,,.F.)")
				EndIf

			EndIf

		EndIf

		cNumero := StrZero(Val(cNumero)+1,TamSX3('BD6_NUMERO')[1])

	EndDo

	BD5->(DbCommit())
	BD6->(DbCommit())
	BD7->(DbCommit())

	If lMostraMsg
		MsgInfo('Processamento finalizado.')
	EndIf

Return

*******************************************************************************

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Valida guias verdes. Busca a primeira guia do arquivo e verifica se existe outro tipo no mesmo XML. Somente versao 2.02.03≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Static Function ValGVD

	Local n_I := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local n_X := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local nCount 	:= 0
	Local cError   	:= ""
	Local cWarning 	:= ""
	Local oXml 		:= Nil
	Local cFile 	:= ""
	Local nX		:= 0
	Local nY		:= 0
	Local cPath 	:= ""
	Local cPathIni	:= "SERVIDOR\tiss\caixaentrada\_"
	Local cMsg 		:= "Este programa valida guias verdes e brancas. Busca a primeira guia do arquivo e verifica se existe outro tipo no mesmo XML. Somente versao 2.02.03" + cEnt + cEnt
	Local lGrava 	:= .F.
	Local oException
	Local lOk 		:= .F.
	Local cCriticas	:= ""
	Local cTipoArq	:= ""
	Local lInicio 	:= .T.
	Local cImp		:= ""
	Local lLog 		:= .F.
	Local lContinua	:= .T.

	Private aFiles 	:= {}
	Private aSizes 	:= {}
	Private aErros	:= {}
	Private aPrint	:= {}

	cMsg := "Selecione a pasta os est„o os arquivos XML. Estes N√O PODEM estar compactados!"

	oDlgQtdMed := MSDialog():New( 095,232,450,803,"ValidaÁ„o guias verdes e brancas",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"DescriÁ„o",oDlgQtdMed,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||cMsg}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)

	oSay1      := TSay():New( 078,008,{||"Caminho XMLS"},oDlgQtdMed,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlgQtdMed,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
	oBtn1      := TButton():New( 078,272,"...",oDlgQtdMed,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_RETDIRECTORY ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )

	oSBtn1     := SButton():New( 150,224,1,{||lOk := .T.,oDlgQtdMed:End()},oDlgQtdMed,,"", )

	oSBtn2     := SButton():New( 150,254,2,{||oDlgQtdMed:End()},oDlgQtdMed,,"", )

	oDlgQtdMed:Activate(,,,.T.)

	If lOk

		nCount 	:= aDir(allTrim(cPath) + "*.xml", aFiles, aSizes)

		ProcRegua(nCount)

		cImp := ""

		For nX := 1 to nCount

			IncProc('Processando arquivo ' + cValToChar(nX) + ' de ' + cValToChar(nCount))

			cImp += cEnt + "Arquivo:" + aFiles[nX] + cEnt + cEnt

			oException 	:= Nil
			oXml		:= Nil
			cErr 		:= ""

			TRY
			//Gera o Objeto XML
			oXml 		:= XmlParserFile( cPath + aFiles[nX], "_", @cError, @cWarning )
			lContinua 	:= Empty(cError) .And. Empty(cWarning) .And. oXml <> Nil
			oXmlChild 	:= XmlGetChild(oXml,1)
			cNameSpace 	:= left(oXmlChild:REALNAME,At(':',oXmlChild:REALNAME) - 1)
			oXmlFat 	:= RetNod(oXmlChild,cNameSpace + ':guiaFaturamento')
			aGuiasFat	:= XmlGetChild(oXmlFat,1)

			CATCH USING oException

			If ( ValType( oException ) == "O" )
				cErr := If( !Empty( oException:Description ) 	, oException:Description , "" )
				cErr += If( !Empty( oException:ErrorStack ) 	, oException:ErrorStack  , "" )
			EndIf

			lContinua := .F.
			aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - Erro ao carregar o arquivo!' + cEnt + cErr)

		ENDCATCH

		cNumImp		:= ""
		nQtd		:= 0

		If lContinua

			If ValType(aGuiasFat) == 'O'
				nQtd := 1
				lObj := .T.
			Else
				nQtd := len(aGuiasFat)
				lObj := .F.
			EndIf

			For n_I := 1 to nQtd

				n_ContNode := 0

				If lObj
					If (oNode := RetNod(aGuiasFat,cNameSpace + ':tipoFaturamento')) <> Nil
						cCriticas := 'Arquivo ' + aFiles[nX] + ' - Tipo de Faturamento da ' + cValToChar(n_I) + ' guia: ' + oNode:TEXT
					Else
						cCriticas := 'Arquivo ' + aFiles[nX] + ' - Guia numero: ' + StrZero(n_I,3) + ' - Tag ' + cNameSpace + ':numeroGuiaOperadora' + ' n„o encontrada!' + cEnt
						lContinua := .F.
					EndIf
				ElseIf (oNode := RetNod(aGuiasFat[n_I],cNameSpace + ':numeroGuiaOperadora')) <> Nil
					cNumImp := oNode:TEXT
				Else
					cCriticas := ' - Guia numero: ' + StrZero(n_I,3) + ' - Tag ' + cNameSpace + ':numeroGuiaOperadora' + ' n„o encontrada!' + cEnt
					lContinua := .F.
				EndIf

				If lContinua
					If lInicio
						cTipoArq := If(lGuiaVerde(cNumimp),'ARQ_GUIA_VERDE','ARQ_GUIA_BRANCA')
						lInicio := .F.
					Else
						If ( cTipoArq == 'ARQ_GUIA_VERDE' ) .and. ( !lGuiaVerde(cNumimp) )
							cCriticas += 'Guia branca (' + cNumimp + ') em arquivo de guias verdes (primeira guia verde)'
						ElseIf ( cTipoArq == 'ARQ_GUIA_BRANCA' ) .and. ( lGuiaVerde(cNumimp) )
							cCriticas += 'Guia verde (' + cNumimp + ') em arquivo de guias branca (primeira guia branca)'
						EndIf
					EndIf
				Else
					lContinua := .T.
				EndIf

				If !empty(cCriticas)
					lLog := .T.
					cImp += cCriticas + cEnt
				EndIf

				cCriticas := ""

			Next

		EndIf

	Next

	If len(aErros) > 0
		cMsgErr := ''
		For n_X := 1 to len(aErros)
			cMsgErr += aErros[n_X] + cEnt
		Next
		LogErros(cMsgErr,'Erros...')
	ElseIf lLog
		LogErros(cImp,'CrÌticas...')
	Else
		LogErros('N„o foram encontradas crÌticas...','CrÌticas...')
	EndIf

EndIf

Return

********************************************************************************************************************************

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Retorna a primeira ocorrencia de um node no arquivo Xml.            ≥
//≥Rotina recursiva que varre do primeiro ao ultimo node, verificando  ≥
//≥cada node filho. Retorna Nil se nao encontrar a tag ou retorna o    ≥
//≥objeto node se encotrar.                                            ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Static Function RetNod(oXmlBuscar,cRealName)

	Local aNos 		:= {}
	Local oChild 	:= Nil
	Local nCont		:= XmlChildCount(oXmlBuscar)
	Local nInc		:= 0
	Local n_J		:= 0
	Local lOkChild	:= .F.

	n_ContNode++

	cRealName := AllTrim(Upper(cRealName))

	If oXmlBuscar <> Nil

		If AllTrim(Upper(oXmlBuscar:REALNAME)) == cRealName
			oChild := oXmlBuscar
		Else

			For nInc := 1 to nCont
				oChild := XmlGetChild(oXmlBuscar,nInc)

				//Tratar futuramente ARRAY retornado pelo XmlGetChild para varrer os objetos retornados em cada indice do Array
				If ValType(oChild) == 'A'
					oChild := Nil
				Else
					If AllTrim(Upper(oChild:REALNAME)) == cRealName
						Exit
					Else
						oChild := RetNod(oChild,cRealName)
						If oChild <> Nil
							Exit
						EndIf
					EndIf
				EndIf

			Next

		EndIf

		If oChild <> Nil .and. AllTrim(Upper(oChild:REALNAME)) <> cRealName
			oChild := Nil
		EndIf

	Else
		oChild := Nil
	EndIf

Return oChild

*************************************************************************************************************

Static Function lGuiaVerde(cNumimp)

	Local lGVD		:= .F.
	Local cAliGVD	:= GetNextAlias()
	Local cQryGVD	:= ""

	cQryGVD := "SELECT 'GVD' TIPO, ZC_NUMINI, ZC_NUMFIM, ZC_SITUAC" 				+ cEnt
	cQryGVD += "FROM " + RetSqlName('SZC') 											+ cEnt
	cQryGVD += "WHERE D_E_L_E_T_ = ' '" 											+ cEnt
	cQryGVD += "   AND ZC_FILIAL = '" + xFilial('SZC') + "'"						+ cEnt
	cQryGVD += "   AND ZC_SITUAC = '1'" 											+ cEnt	//Normal
	cQryGVD += "   AND " + AllTrim(cNumimp) +  " BETWEEN ZC_NUMINI AND ZC_NUMFIM" 	+ cEnt

	TcQuery cQryGVD New Alias cAliGVD

	lGVD := ! ( cAliGVD->(EOF()) )

	cAliGVD->(DbCloseArea())

Return lGVD


*******************************************************************************

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Lista as guias de internacao por tipo de faturamento, parcial ou total≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Static Function SepTpoFat

	Local n_I := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local n_X := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local nCount 	:= 0
	Local cError   	:= ""
	Local cWarning 	:= ""
	Local oXml 		:= Nil
	Local cFile 	:= ""
	Local nX		:= 0
	Local nY		:= 0
	Local cPath 	:= ""
	Local cPathIni	:= "SERVIDOR\tiss\caixaentrada\_"
	Local cMsg 		:= "Este programa Lista as guias de internacao por tipo de faturamento, parcial ou total. Somente versao 2.02.03" + cEnt + cEnt
	Local lGrava 	:= .F.
	Local oException
	Local lOk 		:= .F.
	Local cCriticas	:= ""
	Local cTipoArq	:= ""
	Local lInicio 	:= .T.
	Local cImp		:= ""
	Local lLog 		:= .F.
	Local lContinua	:= .T.

	Private aFiles 	:= {}
	Private aSizes 	:= {}
	Private aErros	:= {}
	Private aPrint	:= {}

	ProcRegua(0)

	For nX := 1 to 5
		IncProc('Processando...')
	Next

	cMsg := "Selecione a pasta os est„o os arquivos XML. Estes N√O PODEM estar compactados!"

	oDlgQtdMed := MSDialog():New( 095,232,450,803,"Lista as guias de internacao por tipo de faturamento, parcial ou total",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 008,008,064,280,"DescriÁ„o",oDlgQtdMed,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSayT1     := TSay():New( 024,012,{||cMsg}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,270,008)

	oSay1      := TSay():New( 078,008,{||"Caminho XMLS"},oDlgQtdMed,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
	oGet1      := TGet():New( 078,049,{|u| If(PCount()>0,cPath:=u,cPath)},oDlgQtdMed,222,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPath",,)
	oBtn1      := TButton():New( 078,272,"...",oDlgQtdMed,{||cPath:=cGetFile('','XML',1, cPathIni, .F., GETF_RETDIRECTORY ,.T., .T.)},008,010,,,,.T.,,"",,,,.F. )

	oSBtn1     := SButton():New( 150,224,1,{||lOk := .T.,oDlgQtdMed:End()},oDlgQtdMed,,"", )

	oSBtn2     := SButton():New( 150,254,2,{||oDlgQtdMed:End()},oDlgQtdMed,,"", )

	oDlgQtdMed:Activate(,,,.T.)

	If lOk

		nCount 	:= aDir(allTrim(cPath) + "*.xml", aFiles, aSizes)

		ProcRegua(nCount)

		cImp := ""

		For nX := 1 to nCount

			IncProc('Processando arquivo ' + cValToChar(nX) + ' de ' + cValToChar(nCount))

			cImp += cEnt + "Arquivo:" + aFiles[nX] + cEnt + cEnt

			oException 	:= Nil
			oXml		:= Nil
			cErr 		:= ""

			TRY
			//Gera o Objeto XML
			oXml 		:= XmlParserFile( cPath + aFiles[nX], "_", @cError, @cWarning )
			lContinua 	:= Empty(cError) .And. Empty(cWarning) .And. oXml <> Nil
			oXmlChild 	:= XmlGetChild(oXml,1)
			cNameSpace 	:= left(oXmlChild:REALNAME,At(':',oXmlChild:REALNAME) - 1)
			oXmlFat 	:= RetNod(oXmlChild,cNameSpace + ':guiaFaturamento')
			aGuiasFat	:= XmlGetChild(oXmlFat,1)

			CATCH USING oException

			If ( ValType( oException ) == "O" )
				cErr := If( !Empty( oException:Description ) 	, oException:Description , "" )
				cErr += If( !Empty( oException:ErrorStack ) 	, oException:ErrorStack  , "" )
			EndIf

			lContinua := .F.
			aAdd(aErros,'Arquivo: ' + aFiles[nX] + ' - Erro ao carregar o arquivo!' + cEnt + cErr)

		ENDCATCH

		cNumImp		:= ""
		nQtd		:= 0

		If lContinua

			If ValType(aGuiasFat) == 'O'
				nQtd := 1
				lObj := .T.
			Else
				nQtd := len(aGuiasFat)
				lObj := .F.
			EndIf

			For n_I := 1 to nQtd

				n_ContNode := 0

				If lObj
					If (oNode := RetNod(aGuiasFat,cNameSpace + ':tipoFaturamento')) <> Nil
						cCriticas := ' - Tipo de Faturamento da ' + cValToChar(n_I) + ' guia: ' + oNode:TEXT
					Else
						cCriticas := ' - Guia numero: ' + StrZero(n_I,3) + ' - Tag ' + cNameSpace + ':tipoFaturamento' + ' n„o encontrada!' + cEnt
						lContinua := .F.
					EndIf
				ElseIf (oNode := RetNod(aGuiasFat[n_I],cNameSpace + ':tipoFaturamento')) <> Nil
					cCriticas := ' - Tipo de Faturamento da ' + cValToChar(n_I) + ' guia: ' + oNode:TEXT
				Else
					cCriticas := ' - Guia numero: ' + StrZero(n_I,3) + ' - Tag ' + cNameSpace + ':tipoFaturamento' + ' n„o encontrada!' + cEnt
					lContinua := .F.
				EndIf

				If !empty(cCriticas)
					lLog := .T.
					cImp += cCriticas + cEnt
				EndIf

				cCriticas := ""

			Next

		EndIf

	Next

	If len(aErros) > 0
		cMsgErr := ''
		For n_X := 1 to len(aErros)
			cMsgErr += aErros[n_X] + cEnt
		Next
		LogErros(cMsgErr,'Erros...')
	ElseIf lLog
		LogErros(cImp,'CrÌticas...')
	Else
		LogErros('N„o foram encontradas crÌticas...','CrÌticas...')
	EndIf

EndIf

Return

************************************************************************************************************************************

Static Function AjustaSX1

	Local aHelp 	:= {}
	Local aArea		:= GetArea()

	aAdd(aHelp, "Matricula")
	PutSX1(cPerg , "01" , "Matricula" 	  			,"","","mv_ch1","C",17		,0,0,"G",""	,""		,"","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

	RestArea(aArea)

Return

*******************************************


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥BUSC_XML  ∫Autor  ≥Leonardo Portella   ∫ Data ≥  16/10/12   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Programa para baixar os arquivos do FTP da Medlink, separar ∫±±
±±∫          ≥os arquivos por usuario X RDA X Guia Verde X Internacao.    ∫±±
±±∫          ≥Baixa o arquivo e descompacta os mesmos.                    ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥CABERJ                                                      ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

*********************************************************************

Static cRDA_Sem_Resp	:= 'RDA_SEM_RESP'
Static aEmpresas		:= {'CABERJ','INTEGRAL'}

*********************************************************************

User Function Busc_XML

	Local aRetDownload 	:= {}
	Local aRetDesComp	:= {}
	Local aRetMail		:= {}
	Local cMsg 			:= ""
	Local nCount		:= 0
	Local nI			:= 0
	Local aRetDesComp	:= {}
	Local aRetSepRDA	:= {}
	Local aRetMovOri	:= {}

	// InÌcio Mateus  - 19/01/2018
	Local cArqLog		:= 'Log_'+cvaltochar(Randomize(1,2000))+'.log'
	// Mateus Medeiros - 19/01/2018 - Criada para controle da variavel cMsg - Devido a mesma estar
	// estourando - String Size OveFlow
	Local cBuffer   := ' '
	Local nInfile   := 0
	Local nBytesR 	:= 0
	Local cUsrAcess :=  SUPERGETMV("MV_XACCTIS", .T., "000833|000716|") // MAX e Fernanda
	
	// Fim Mateus  - 19/01/2018

	Private cVersaoTiss	:= ''
	Private c_NameSpace	:= ''

	//Leonardo Portella - 22/11/13 - Virada P11 - Inicio

	//Private cRaiz		:= "\\srvap01n\Protheus10\Protheus_Data"//"\\srvap02\Protheus10TST\Protheus_Data"
	//Private cRaiz		:= "E:\Totvs\Protheus11\Protheus_Data" //"E:\Totvs_Desenv\P11\Protheus_Data"//"/*"\\10.19.1.8\Protheus_Data"*///"\\srvap02\Protheus10TST\Protheus_Data"
	//Private cRaiz		:= "E:\Totvs\P12\Protheus_Data"   /*P12 - Virada*/
	Private cRaiz:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\P12\Protheus_Data"   /*P12R27 - Virada*/
	//Leonardo Portella - 22/11/13 - Virada P11 - Fim

	Private cPastaDes
	Private cPathVerde
	Private cPathRecip // Mateus Medeiros - 24/11/2018
	Private cPathExtr
	Private cPathTMP
	Private cPathOrig
	Private aTmpExtr	:= {}
	Private aUsr_XML	:= {}
	Private cEmpresa	:= ""
	//Conforme solicitacao, a rotina devera ser executada apenas uma vez para ambas empresas. Logo irei gravar os dados somente na Caberj.
	If cEmpAnt <> '01'
		MsgAlert('Rotina de download dever· ser executada somente na empresa CABERJ',AllTrim(SM0->M0_NOMECOM))
		Return
	EndIf

	If !MsgYesNo('Confirma verificacao do FTP e download dos XMLs?')
		Return
	EndIf

	For nCount := 1 to len(aEmpresas)

		cEmpresa 	:= aEmpresas[nCount]
		aUsr_XML 	:= {}

		cPastaDes	:= '\Tiss\Download_TISS\' + cEmpresa + '\'
		cPathVerde	:= 'Guias_Verdes\'
		//		cPathRecip	:= 'Guias_Reciprocidade\' // Mateus Medeiros - 24/01/2018
		cPathExtr	:= cPastaDes + 'Analistas\'
		cPathTMP	:= cPastaDes + 'Temp\'
		cPathOrig	:= cPastaDes + 'Arqs_Originais\'

		//Leonardo Portella - 11/12/14 - Inicio - Devido a erro no FTP, criei a possibilidade de receber os
		//arquivos e colocar numa pasta

		If 	( RetCodUsr() $ GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN')  +'|'+cUsrAcess ) .and. ;
				( Aviso('T.I.','Baixar do FTP ou verificar arquivos ZIPADOS na pasta ' + cPastaDes + ' ?',{'FTP','Pasta'}) == 1 )

			Processa({||aRetDownload := DownloadFTP(cEmpresa)},'Verificando arquivos no FTP [ ' + cEmpresa + ' ]')
		Else
			aRetDownload := { File(cPastaDes + '*.zip'), 'Busca na pasta',{ 'Busca Pasta: ' + cPastaDes + '*.zip' } }
		EndIf

		//Leonardo Portella - 11/12/14 - Fim

		//If aRetDownload[1]
		//****************************************************
		// Inicio
		// Mateus Medeiros
		//****************************************************
		cMsg := '- Download FTP [ ' + cEmpresa + ' ]' + cEnt + cEnt
		nInfile := fopen('/data/'+cEmpresa+cArqLog, FO_READWRITE )
		nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
		FWrite(nInfile, cMsg + cEnt + cEnt,len(cBuffer + cMsg + cEnt + cEnt))
		FClose(nInFile)

		MemoWrite( '/data/'+cEmpresa+cArqLog, '- Download FTP [ ' + cEmpresa + ' ]' + cEnt + cEnt )
		// Fim Mateus

		//cMsg := '- Download FTP [ ' + cEmpresa + ' ]' + cEnt + cEnt

		For nI := 1 to len(aRetDownload[3])

			//cMsg += aRetDownload[3][nI] + cEnt
			nInfile := fopen('/data/'+cEmpresa+cArqLog, FO_READWRITE )
			nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
			FWrite(nInfile, aRetDownload[3][nI] + cEnt,len(cBuffer + aRetDownload[3][nI] + cEnt))
			FClose(nInFile)
		Next

		Processa({||aRetDesComp := DescWinRar()},'Descompactando arquivos [ ' + cEmpresa + ' ]')

		If aRetDesComp[1]

			//cMsg := cEnt + '- Descompactacao [ ' + cEmpresa + ' ]' + cEnt + cEnt
			cMsg := cEnt + '- Descompactacao [ ' + cEmpresa + ' ]' + cEnt + cEnt
			nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
			nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
			FWrite(nInfile, cMsg,len(cBuffer+ cMsg))
			FClose( nInfile )

			For nI := 1 to len(aRetDesComp[3])
				//cMsg += aRetDesComp[3][nI] + cEnt

				nInfile := fopen('/data/'+cEmpresa+cArqLog , FO_READWRITE )
				nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
				FWrite(nInfile,  aRetDesComp[3][nI] + cEnt,len(cBuffer+  aRetDesComp[3][nI] + cEnt))
				FClose(nInFile)
			Next

			Processa({||aRetSepRDA := SepXMLRDA()},'Separando arq. por RDA e analista resp. [ ' + cEmpresa + ' ]')

			If aRetSepRDA[1]

				cMsg := cEnt + '- SeparaÁ„o arquivos por RDA e analista responsavel [ ' + cEmpresa + ' ]' + cEnt + cEnt
				nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
				nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
				FWrite(nInfile,  cMsg ,len( cBuffer + cMsg ))
				FClose( nInfile )

				For nI := 1 to len(aRetSepRDA[3])

					//cMsg += aRetSepRDA[3][nI] + cEnt
					nInfile := fopen('/data/'+cEmpresa+cArqLog , FO_READWRITE)
					nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
					FWrite(nInfile,  aRetSepRDA[3][nI] + cEnt,len(cBuffer + aRetSepRDA[3][nI] + cEnt))
					FClose(nInfile)
				Next

				Processa({||aRetSepRDA := SepXMLRDA(.T.)},'Separando arq. de Guias Verdes por RDA e analista resp. [ ' + cEmpresa + ' ]')

				If aRetSepRDA[1]

					cMsg := cEnt + '- SeparaÁ„o arquivos de Guias Verdes por RDA e analista responsavel [ ' + cEmpresa + ' ]' + cEnt + cEnt
					nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
					nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
					FWrite(nInfile,  cMsg ,len( cBuffer + cMsg))
					FClose( nInfile )
					For nI := 1 to len(aRetSepRDA[3])
						//cMsg1 += aRetSepRDA[3][nI] + cEnt

						//cMsg += aRetSepRDA[3][nI] + cEnt
						nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
						nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
						FWrite(nInfile,  aRetSepRDA[3][nI] + cEnt,len(cBuffer + aRetSepRDA[3][nI] + cEnt))
						FClose( nInfile )
					Next

					Processa({||aRetMovOri := MovArqOr()},'Movendo arquivos originais [ ' + cEmpresa + ' ]')

					If aRetMovOri[1]

						cMsg := cEnt + '- MudanÁa de pasta dos arq. originais [ ' + cEmpresa + ' ]' + cEnt + cEnt
						nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
						nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
						FWrite(nInfile, cMsg ,len(cBuffer+ cMsg))
						FClose( nInfile )

						For nI := 1 to len(aRetMovOri[3])
							//	cMsg += aRetMovOri[3][nI] + cEnt // analisar alteraÁ„o da concatenaÁ„o

							nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
							nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
							FWrite(nInfile,  aRetMovOri[3][nI] + cEnt,len( cBuffer +  aRetMovOri[3][nI] + cEnt))
							FClose( nInfile )
						Next

						Processa({||aRetMail := EnviaMail()},'Enviando e-mail informativo para os resp. pelos RDAs [ ' + cEmpresa + ' ]')

						cMsg := cEnt + '- Envio de e-mail informativo para os responsaveis pelos RDAs [ ' + cEmpresa + ' ]' + cEnt + cEnt
						nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
						nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
						FWrite(nInfile,  cMsg + cEnt,len( cBuffer+cMsg + cEnt)   )
						FClose( nInfile )

						If !aRetMail[1]
							cMsg += 'Falha no envio de e-mail ' + cEnt + aRetMail[2] + cEnt
						Else
							cMsg += aRetMail[2] + cEnt
						EndIf

						nInfile    	:= FOPEN('/data/'+cEmpresa+cArqLog, FO_READWRITE)
						nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
						FWrite(nInfile, cMsg + cEnt,len( cBuffer+cMsg + cEnt))
						FClose( nInfile )

						cLine := MemoRead( '/data/'+cEmpresa+cArqLog)
						// Verifica o n˙mero de linhas no texto
						nLines := MLCount( cLine )
						cTexto := ""
						// Varre todas as linhas do texto
						For nX := 1 To nLines
							cTexto +=  MemoLine( cLine, , nX )
						Next nX

						LogErros(cTexto,'Arquivos baixados com sucesso [ ' + cEmpresa + ' ]',.T.,'M')

						//****************************************
						// apaga o arquivo log apÛs a finalizaÁ„o.
						fErase('/data/'+cEmpresa+cArqLog)
						//****************************************
						//LogErros(cMsg,'Arquivos baixados com sucesso [ ' + cEmpresa + ' ]',.T.,'M')

						//LogTiss('/data/'+cEmpresa+cArqLog)
					Else
						LogErros(aRetMovOri[2],'Log download FTP - MudanÁa de pasta dos arquivos originais [ ' + cEmpresa + ' ]',.T.,'M')

					EndIf
				Else
					LogErros(aRetMovOri[2],'Log download FTP - SeparaÁ„o arquivos de Guias Verdes por RDA e analista responsavel [ ' + cEmpresa + ' ]',.T.,'M')
				EndIf
			Else
				LogErros(aRetSepRDA[2],'Log download FTP - SeparaÁ„o arquivos por RDA e analista responsavel [ ' + cEmpresa + ' ]',.T.,'M')
			EndIf

		Else
			LogErros(aRetDesComp[2],'Log download FTP - DescompactaÁ„o dos arquivos [ ' + cEmpresa + ' ]',.T.,'M')
		EndIf

		/*
	Else
		EnviaMail(.T.)
		LogErros(aRetDownload[2],'Log download FTP - VerificaÁ„o do FTP [ ' + cEmpresa + ' ]',.T.,'M')
	EndIf
	*/
Next

Return

**********************************************************************

Static Function DownloadFTP(cEmpresa)

	Local lRet 		:= .T. // Comentado - 15/01/2018 - Mateus Medeiros
	Local cLog		:= ""
	Local cServidor := "ftp.so2.com.br"//"ftp.medlinksaude.com.br"
	Local nPorta	:= 21
	Local cLogin	:= "caberj"
	Local cSenha	:= "caberj@operativa"//"caberj@medlink"

	//Leonardo Portella - 02/12/13 - Inicio - Virada P11

	//Local cPastaBus	:= "/caberj/fatel/" + cEmpresa + "/20203" //Pasta onde serao procurados os arquivo no FTP - O primeiro Caberj nao eh visivel no FTP (oculto)
	Local aPastaBus	:= {"/fatel/" + Lower(cEmpresa) + "/20203","/fatel/" + Lower(cEmpresa) + "/30200","/web/" + Lower(cEmpresa) + "/30200"} //Pasta onde serao procurados os arquivo no FTP - O primeiro Caberj nao eh visivel no FTP (oculto)

	//Leonardo Portella - 02/12/13 - Fim

	Local aInfoFTP	:= {}
	Local aLogs		:= {}
	Local nI		:= 0
	Local cLogPBH	:= ''

	/* 15/01/2018 - Mateus */
	// Devido as funÁıes de FTP antigas n„o conseguirem fazer o download
	// dos arquivos, foi necess·ria a alteraÁ„o das funÁıes antigas pela
	// classe tFtpClient
	Local nRet      := 0
	Local sRet		:= ""
	Private oFTPHandle

	oFTPHandle := tFtpClient():New() // 15/01/2018 - Mateus Medeiros

	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Acessando o FTP...')
	Next

	//Crio a pasta em que serao gravados os arquivos caso ela nao exista
	If !ExistDir(cPastaDes)
		MakePath(cPastaDes)
	EndIf

	//*****************************************
	// Conecta no servidor FTP - 15/01/2018
	// Mateus Medeiros
	//*****************************************

	nRet := oFTPHandle:SetType( 1 )
	oFTPHandle:nTransferMode := 2

	nRet := oFTPHandle:FTPConnect(cServidor,nPorta,cLogin,cSenha) //,cLogin)
	sRet := oFTPHandle:GetLastResponse()
	Conout( sRet )

	// comentado 15/01/2018 - substituÌda pela classe acima
	//FTPDISCONNECT()
	//lConnect := FTPCONNECT(cServidor,nPorta,cLogin,cSenha)

	If nRet != 0 //!lConnect

		nTent := 0

		//FTPDISCONNECT()
		oFTPHandle:Close()
		While nTent <= 5 //.and. !lConnect

			IncProc('Tentativa ' + cValToChar(nTent) + ' de acesso ao FTP...')

			sleep(10000)
			nTent++

			nRet := oFTPHandle:FTPConnect(cServidor,nPorta,cLogin,cSenha)
			sRet := oFTPHandle:GetLastResponse()
			Conout( sRet )
			/*FTPDISCONNECT()
			lConnect := FTPCONNECT(cServidor,nPorta,cLogin,cSenha)*/


		EndDo

		If nRet != 0
			lRet 	:= .F.
			cLog 	:= 'N„o foi possÌvel conectar ao servidor FTP [ ' + cEmpresa + ' ]'
			cLogPBH	:= cLog
		EndIf

	EndIf

	If lRet

		//aPasta 		:= Separa(cPastaBus,'/',.F.)
		cNovoCam	:= ''
		/*
		For nI := 1 to len(aPasta)

			cNovoCam += '/' + aPasta[nI]
			*/

			for nK := 1 to len( aPastaBus)

				cNovoCam := /*'/' +*/ aPastaBus[nK]
				cPastaBus  := aPastaBus[nK]
				nRet := oFTPHandle:ChDir(cPastaBus)
				sRet := oFTPHandle:GetLastResponse()
				//oFTPHandle:bFireWallMode := .T. // Indica o tipo de conex„o com o servidor
				conout(sRet)
				If (nRet != 0)
					lRet 	:= .F.
					cLog 	:= 'N„o foi possÌvel mudar para o diretorio [ ' + cNovoCam + ' ] - Diretorio atual [ ' + "FtpGetCurDir()" + ' ] - DiretÛrio destino [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
					cLogPBH	:= 'N„o foi possÌvel mudar diretorio [ ' + cNovoCam + ' ]'
					//exit
				EndIf

				//	Next

				If lRet
					//aInfoFTP := FTPDirectory("*.ZIP",)
					aInfoFTP := oFTPHandle:Directory("*.ZIP")
					varinfo("Directory ret",nRet)
					sRet := oFTPHandle:GetLastResponse()
					If empty(aInfoFTP)
						lRet 	:= .F.
						cLog 	:= 'N„o foram encontrados arquivos no diretorio [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
						cLogPBH	:= 'N„o existem arqs FTP [ ' + cPastaBus + ' ]'
					Else

						cLog := ""
						aDiretorio := {}
						aDir(cPathOrig+'*.zip',@aDiretorio)

						// Exclui arquivos que j· foram baixados.
					//	aInfoFTP := ExcDupl(aInfoFTP, aDiretorio)

						ProcRegua(len(aInfoFTP))

						For nI := 1 to len(aInfoFTP)

							IncProc('Baixando arquivo da pasta '+cPastaBus+' do FTP [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aInfoFTP)) + ;
								' ] [ ' + cValToChar(NoRound(aInfoFTP[nI][2]/1024,1)) + ' KB ]')
							//if ascan(aDiretorio,{|x|  alltrim(upper(SUBSTR(x,9,LEN(aInfoFTP[nI][1])))) $ aInfoFTP[nI][1]   }) == 0
							if ascan(aDiretorio,{|x|  aInfoFTP[nI][1]  $ x  }) == 0
							    conout(aInfoFTP[nI][1])
								nRet := oFTPHandle:ReceiveFile(aInfoFTP[nI][1], cPastaDes+aInfoFTP[nI][1])
								varinfo("Receive ret",nRet)
								sRet := oFTPHandle:GetLastResponse()
								Conout(sRet)

								If nRet # 0

									Conout(sRet)
									nRet := oFTPHandle:ReceiveFile(substr(aInfoFTP[nI][1],1,len(aInfoFTP[nI][1])-3)+"zip", cPastaDes+aInfoFTP[nI][1])
									varinfo("Receive ret",nRet)
									sRet := oFTPHandle:GetLastResponse()
									Conout(sRet)

									If nRet # 0

											lRet 	:= .F.
											cLog 	+= ' - N„o foi possivel baixar o arquivo [ ' + aInfoFTP[nI][1] + ' ] [ ' + cEmpresa + ' ]'					+ cEnt

											If File(cPastaDes + aInfoFTP[nI][1])
												cLog 	+= '   Ja existe um arquivo com o mesmo nome na pasta destino [ ' + cPastaDes + aInfoFTP[nI][1] + ' ]'	+ cEnt
											Else
												cLog 	+= '   N„o foi possÌvel baixar o arquivo [ ' + aInfoFTP[nI][1] + ' ]' 									+ cEnt
											EndIf

											cLogPBH	:= 'N„o poss. baixar [ ' + aInfoFTP[nI][1] + ' ]'
										exit
									endif

								EndIf

								/*IncProc('Removendo arquivo do FTP [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aInfoFTP)) + ;
									' ] [ ' + cValToChar(NoRound(aInfoFTP[nI][2]/1024,1)) + ' KB ]')
								*/

								aAdd(aLogs,'- Arquivo ' + aInfoFTP[nI][1] + ' baixado do FTP para a pasta ' + cPastaDes )

							Endif

						Next

					EndIf

				EndIf
			Next nK
		EndIf


		oFTPHandle:Close()
		sRet := oFTPHandle:GetLastResponse()

		If !lRet

			DbSelectArea('PBH')

			Reclock('PBH',.T.)

			PBH_FILIAL 	:= xFilial('PBH')
			PBH_EMPRESA	:= cEmpresa
			PBH_XML		:= cLogPBH
			PBH_DTDOWN	:= Date()
			PBH_HRDOWN	:= Time()
			PBH_USRCHK	:= RetCodUsr() + ' - ' + Upper(AllTrim(UsrFullName(RetCodUsr())))
			PBH_STATUS	:= '-'
			PBH_TIPXML	:= '-'
			PBH_CODRDA	:= '-'

			MsUnlock()

		EndIf

		Return {lRet, cLog, aLogs}

		**********************************************************************

	Static Function DescWinRar

		Local aArqsCompac 	:= {}
		Local aSizes 		:= {}

		//Leonardo Portella - 22/11/13 - Virada P11 - Inicio

		//Local cWinRar 	:= "\WinRAR\WinRAR.exe" //"\\Srvterm2\Desenv$\ToolsFree\WinRar\WinRar.exe"
		//Local cWinRar 	:= "E:\Totvs\Protheus11\Protheus_Data"//"E:\Totvs_Desenv\P11\Protheus_Data\7Zip\"// "\\10.19.1.8\Protheus_Data\7zip\7Zip.exe"
		//Local cWinrar		:= "E:\Totvs\P12\Protheus_Data"  ///teste P12
	    //Local cWinrar		:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\P12\Protheus_Data"   /*P12R27 - Virada*/
		Local cWinrar		:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\P12\Protheus_Data\7Zip\7Za.exe"   /*P12R27 - Virada*/

		//Leonardo Portella - 22/11/13 - Virada P11 - Fim
		Local cDataHora		:= "DtoC(Date()) + ' ' + Time()"
		Local lOk 			:= .T.
		Local aLogs			:= {}
		Local cErro 		:= ""
		Local cDestExtr		:= ''
		Local nI			:= 0
		Local nQtdArqs		:= 0
		Local cCompet		:= ''
		Local cPathBuffer	:= ''
		Local cAlias		:= GetNextAlias()

		ProcRegua(0)

		For nI := 1 to 5
			IncProc('Descompactando arquivos...')
		Next

		nQtdArqs := aDir(cPastaDes + '*.*', aArqsCompac, aSizes)
		/*
		If !File(cWinRar)
			lOk := .F.
			cErro := &cDataHora + " - Programa compactador WinRar n„o encontrado no caminho " + cWinRar + "!"
		Else*/

			If !ExistDir(cPathExtr)
				MakePath(cPathExtr)
			EndIf

			ProcRegua(nQtdArqs)

			For nI := 1 to nQtdArqs

				IncProc('Descompactando [ ' + cValToChar(nI) + ' de ' + cValToChar(nQtdArqs) + ;
					' ] [ ' + cValToChar(NoRound(aSizes[nI]/1024,1)) + ' KB ]')

				aNome 	:= Separa(aArqsCompac[nI],'_',.T.)


				//Leonardo Portella - 13/11/15 - AlteraÁ„o para separar arquivos da prefeitura em pasta separada
				If ( Upper(AllTrim(aNome[2])) == 'PSSM' )//Prefeitura
					cCompet := StrZero(Month(ddatabase),2) + '-' + AllTrim(MesExtenso(ddatabase))
					//	cCompet := StrZero(Month(StoD(AllTrim(aNome[4]))),2) + '-' + AllTrim(MesExtenso(StoD(AllTrim(aNome[4]))))
					cPathBuffer := cPathTMP + cCompet + '\'
					cDestExtr 	:= cRaiz + cPathBuffer
					aAdd(aTmpExtr,{.T.,cPathBuffer,cCompet,StoD(AllTrim(aNome[4])),'PREFEITURA'})
				ElseIf ( Upper(AllTrim(aNome[2])) == 'VERDES' )
					cCompet := StrZero(Month(ddatabase),2) + '-' + AllTrim(MesExtenso(ddatabase))
					//cCompet		:= StrZero(Month(StoD(AllTrim(aNome[4]))),2) + '-' + AllTrim(MesExtenso(StoD(AllTrim(aNome[4]))))
					cPathBuffer := cPathTMP + cCompet + '\' + cPathVerde + '\'
					cDestExtr 	:= cRaiz + cPathBuffer
					aAdd(aTmpExtr,{.T.,cPathBuffer,cCompet,StoD(AllTrim(aNome[4])),'VERDES'})
				ElseIf ( Upper(AllTrim(aNome[2])) == 'RECIPROCIDADE' ) // MATEUS MEDEIROS - 24/01/2018
					cCompet := StrZero(Month(ddatabase),2) + '-' + AllTrim(MesExtenso(ddatabase))
					//cCompet		:= StrZero(Month(StoD(AllTrim(aNome[4]))),2) + '-' + AllTrim(MesExtenso(StoD(AllTrim(aNome[4]))))
					cPathBuffer := cPathTMP + cCompet + '\'
					cDestExtr 	:= cRaiz + cPathBuffer
					aAdd(aTmpExtr,{.T.,cPathBuffer,cCompet,StoD(AllTrim(aNome[4])),'NORMAL'})
				ElseIf ( IsDigit(AllTrim(aNome[1])) ) // MATEUS MEDEIROS - 24/01/2018 -- caso tenha digito
					cCompet := StrZero(Month(ddatabase),2) + '-' + AllTrim(MesExtenso(ddatabase))
					//cCompet		:= StrZero(Month(StoD(AllTrim(aNome[2]))),2) + '-' + AllTrim(MesExtenso(StoD(AllTrim(aNome[2]))))
					cPathBuffer := cPathTMP + cCompet + '\'
					cDestExtr 	:= cRaiz + cPathBuffer
					aAdd(aTmpExtr,{.T.,cPathBuffer,cCompet,StoD(AllTrim(aNome[2])),'NORMAL'})
				Else
					cCompet := StrZero(Month(ddatabase),2) + '-' + AllTrim(MesExtenso(ddatabase))
					//cCompet		:= StrZero(Month(StoD(AllTrim(aNome[3]))),2) + '-' + AllTrim(MesExtenso(StoD(AllTrim(aNome[3]))))
					cPathBuffer := cPathTMP + cCompet + '\'
					cDestExtr 	:= cRaiz + cPathBuffer
					aAdd(aTmpExtr,{.F.,cPathBuffer,cCompet,StoD(AllTrim(aNome[3])),'NORMAL'})
				EndIf

				If !ExistDir(cPathBuffer)
					MakePath(cPathBuffer)
				EndIf

				//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
				//≥WaitRunSrv( cCommandLine , lWaitRun , cPath ) : lSuccess                ≥
				//≥cCommandLine : Instrucao a ser executada                                ≥
				//≥lWaitRun     : Se deve aguardar o termino da Execucao                   ≥
				//≥Path         : Onde, no server, a funcao devera ser executada           ≥
				//≥Retorna      : .T. Se conseguiu executar o Comando, caso contrario, .F. ≥
				//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

				//Descompacta e extrai o arquivo na pasta

				//Leonardo Portella - 22/11/13 - Virada P11 - Inicio
				lDescompacta := .T.
				/*
				If RetCodUsr() $ GetMV('MV_XGETIN')
					lDescompacta := MsgYesNo('Descompacta arquivo [ ' + aArqsCompac[nI] + ' ] para [ ' + cDestExtr + ' ] ?')
				EndIf*/

				lResWait := .T.


				If lDescompacta

					//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
					//≥Obs: Caso trave na descompactacao, encerre os processos de ≥
					//≥WinRAR.exe nos servidores de Teste ou Producao, dependendo ≥
					//≥de onde esta rodando. Delete tambem o conteudo dentro da   ≥
					//≥pasta TEMP da empresa logada                               ≥
					//≥( \Protheus_Data\tiss\download_tiss\caberj\Temp )          ≥
					//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
					cNomeBat := MontaBat(aArqsCompac[nI],cRaiz + cPastaDes , /*cRaiz+*/cDestExtr,cWinRar,Substr( aArqsCompac[nI],1,len(aArqsCompac[nI])-4 ) )

					//lResWait := WaitRunSrv( cWinRar + ' x "' + cRaiz + cPastaDes + aArqsCompac[nI] + '" "' + cDestExtr + '"' , .T. , "\\Srvap01n\Protheus10\" )
					lResWait := WaitRunSrv( cNomeBat , .T. , cDestExtr )
					//WaitRunSrv( @cCommand , @lWait , @cPath )
					// exclui a bat criada apÛs a execuÁ„o
					//sleep(3000)
					fErase(substr(cNomeBat, at("Tiss",cNomeBat)-1,len(cNomeBat)))
				EndIf

				//Leonardo Portella - 22/11/13 - Virada P11 - Fim

				If !lResWait
					lOk		:= .F.
					cErro 	:= &cDataHora + ' - Resultado WaitRunSrv: Erro na execuÁ„o da descompactaÁ„o do arquivo [ ' + aArqsCompac[nI] + ' ] [ ' + cEmpresa + ' ]'
				Else
					aAdd(aLogs,'- Arquivo [ ' + aArqsCompac[nI] + ' ] extraido para a pasta [ ' + cDestExtr + ' ]')
				EndIf


				//Leonardo Portella - 22/11/13 - Virada P11 - Fim

				If !lResWait
					lOk		:= .F.
					cErro 	:= &cDataHora + ' - Resultado WaitRunSrv: Erro na execuÁ„o da descompactaÁ„o do arquivo [ ' + aArqsCompac[nI] + ' ] [ ' + cEmpresa + ' ]'
				Else
					aAdd(aLogs,'- Arquivo [ ' + aArqsCompac[nI] + ' ] extraido para a pasta [ ' + cDestExtr + ' ]')
				EndIf

			Next

			//EndIf

			Return {lOk,cErro,aLogs}

			**********************************************************************

		Static Function SepXMLRDA(lGuiasVerdes)

			Local aSizes 		:= {}
			Local aArqsProc 	:= {}
			Local cRDA	  		:= ''
			Local aLogs	 		:= {}
			Local lOk	  		:= .T.
			Local cErro	  		:= ''
			Local cQuery		:= ''
			Local cAlias  		:= GetNextAlias()
			Local cAnalResp		:= ''
			Local nI	  		:= 0
			Local nJ	  		:= 0
			Local nQtdArqs
			Local cPathProc		:= ''
			Local cCompet		:= ''
			Local cPathDest		:= ''
			Local nAux			:= 0
			Local cCodAna  		:= ''
			Local aDescEmail 	:= {}
			Local dEnvMedlink
			Local lPrefeitura 	:= .F.

			Local nQtdImport	:= GetNewPar('MV_XQTDIMP',1) //Leonardo Portella - 06/10/16
			Local aAnaResImp	:= {} //Leonardo Portella - 06/10/16
			Local aRDAxImp		:= {} //Leonardo Portella - 06/10/16
			Local nPosRDAImp 	:= 0  //Leonardo Portella - 06/10/16
			Local nPosImport	:= 0  //Leonardo Portella - 06/10/16
			Local cImportador	:= ''
			Local aArTmp		:= {}

			Default lGuiasVerdes := .F.

			For nI := 1 to nQtdImport
				cImportador := 'IMPORTADOR_' + cValToChar(nI) + "\" + DtoS(Date())
				aAdd(aAnaResImp,{cImportador,0})
			Next

			cImportador	:= ''

			//-----------------------------------------------------------------------------------------------------------------------
			//Leonardo Portella - 19/10/16 - InÌcio - Verifica se arquivos antigos tiveram protocolo emitido e coloca para distribuir
			//-----------------------------------------------------------------------------------------------------------------------

			cQry := "SELECT *"									 																							+ cEnt
			cQry += "FROM PBH010 A" 																														+ cEnt
			cQry += "WHERE PBH_FILIAL = ' '" 																												+ cEnt
			cQry += "  AND PBH_EMPRES = '" + cEmpresa + "'"																									+ cEnt
			cQry += "  AND D_E_L_E_T_ = ' '" 																												+ cEnt
			cQry += "  AND SUBSTR(PBH_DTMEDL,1,6) BETWEEN  '" + Left(DtoS(MonthSub(dDataBase,3)),6) + "' AND '" + Left(DtoS(dDataBase),6) + "'"			+ cEnt
			//cQry += "  AND SUBSTR(PBH_DTMEDL,1,6) IN (  '" + Left(DtoS(MonthSub(dDataBase,6)),6) + "', '" + Left(DtoS(dDataBase),6) + "')"					+ cEnt
			cQry += "  AND SUBSTR(PBH_DTMEDL,1,6) >= '201610'"	 																							+ cEnt
			//cQry += "  AND UPPER(PBH_PATHAR) LIKE '%\" + Left(DtoS(dDataBase),4) + "%'"																		+ cEnt
			cQry += "  AND UPPER(PBH_PATHAR) LIKE '%SEM_PROTOCOLO%'" 																						+ cEnt
			cQry += "  AND" 																																+ cEnt
			cQry += "  ("	 																																+ cEnt
			cQry += "      PBH_CODRDA IN ( '139785','070416','136158','139718','136174','079693','032883','034479','141097','139785','070416' ) --REDE DOR" + cEnt
			cQry += "      OR" 																																+ cEnt
			cQry += "      EXISTS" 																															+ cEnt
			cQry += "      (" 																																+ cEnt
			cQry += "        SELECT 1" 																														+ cEnt
			cQry += "        FROM " + If(cEmpresa == 'CABERJ',"ZRW010","ZRW020") + " ZRW" 																	+ cEnt
			cQry += "		 INNER JOIN " + If(cEmpresa == 'CABERJ','ZZP010','ZZP020')  + " ZZP ON ZZP_FILIAL = '" + xFilial('ZZP') + "'" 					+ cEnt
			cQry += "			AND ZZP_IDOPER = ZRW_IDTOTA" 																								+ cEnt
			cQry += "			AND ZZP_NUMREM = ZRW_NUMREM" 																								+ cEnt
			cQry += "			AND ZZP_STATUS = 'CPR'" 																									+ cEnt
			cQry += "			AND ZZP.D_E_L_E_T_ = ' '" 																									+ cEnt
			cQry += "        WHERE ZRW_FILIAL = ' '" 																										+ cEnt
			cQry += "          AND UPPER(ZRW_XML) = UPPER(PBH_XML)" 																						+ cEnt
			cQry += "          AND ZRW.D_E_L_E_T_ = ' '" 																									+ cEnt
			cQry += "      )" 																																+ cEnt
			cQry += "  )"	 																																+ cEnt
			cQry += "  AND NOT EXISTS" 																														+ cEnt
			cQry += "  (" 																																	+ cEnt
			cQry += "    SELECT 1" 																															+ cEnt
			cQry += "    FROM PBH010 B" 																													+ cEnt
			cQry += "    WHERE B.PBH_FILIAL = ' '" 																											+ cEnt
			cQry += "      AND B.PBH_EMPRES = A.PBH_EMPRES"																									+ cEnt
			cQry += "      AND B.D_E_L_E_T_ = ' '" 																											+ cEnt
			//cQry += "      AND B.PBH_DTMEDL LIKE SUBSTR(A.PBH_DTMEDL,1,6) || '%'" 																			+ cEnt
			cQry += "      AND B.PBH_XML = A.PBH_XML" 																										+ cEnt
			cQry += "      AND INSTR(UPPER(B.PBH_PATHAR),'SEM_PROTOCOLO') <= 0 --J¡ FOI COLOCADO EM OUTRO DESTINO QUE N√O SEM_PROTOCOLO" 					+ cEnt
			cQry += "  )" 																																	+ cEnt
			//	cQry += "  AND PBH_XML = '00000000000008937861_5E0D94AF9C3915FEA81F3F84FD8648DB.XML'   "

			TcQuery cQry New Alias cAlias

			cPathDesOld := cPathDest
			cPathProOld	:= cPathProc
			aLogsOld	:= aLogs
			aUsr_XMLOld	:= aClone(aUsr_XML)

			cPathDest	:= ''
			cPathProc	:= ''
			aLogs		:= {}
			aUsr_XML	:= {}

			While !cAlias->(EOF())

				cPathProc	:= AllTrim(cAlias->PBH_PATHAR)
				cPathDest	:= AllTrim(cAlias->PBH_PATHAR)

				cRet 		:= cAnaResRDA(cAlias->PBH_CODRDA)

				If !empty(cRet)
					cAnalResp 	:= Upper(AllTrim(UsrRetName(AllTrim(cRet))))
					cCodAna		:= AllTrim(cRet)
				Else
					cAnalResp 	:= cRDA_Sem_Resp
					cCodAna		:= ''
				EndIf

				cPathDest	:= Replace(cPathDest,cAlias->PBH_DTDOWN,DtoS(dDataBase))

				cPathDest	:= Replace(cPathDest,"Sem_Protocolo\","")

				//A competÍncia deve ser a de envio da Medlink e n„o a data base. A data de download deve ser da data base
				//Exemplo de pasta: 12 - Dezembro/20170124

				//cCompet		:= StrZero(Month(StoD(cAlias->PBH_DTMEDL)),2) + '-' + AllTrim(MesExtenso(StoD(cAlias->PBH_DTMEDL)))

				cCompet		:= StrZero(Month(DDATABASE),2) + '-' + AllTrim(MesExtenso(DDATABASE))

				If (nPos := At("IMPORTADOR_", Upper(cPathDest)) ) > 0
					cPathDest	:= cPathExtr + cCompet + '\' + Substr(cPathDest, nPos, len(cPathDest) - nPos + 1)
				EndIf

				If Right(cPathDest,9) == ( DtoS(dDataBase) + '\' )
					cPathDest	+= '\'
				EndIf

				If !ExistDir(cPathDest)
					MakePath(cPathDest)
				EndIf

				cPathProc += If(Right(AllTrim(cPathProc),1) <> '\','\','')
				cPathDest += If(Right(AllTrim(cPathDest),1) <> '\','\','')

				Copy File &(AllTrim(cPathProc + cAlias->PBH_XML)) TO &(AllTrim(cPathDest + cAlias->PBH_XML))

				If !File(AllTrim(cPathDest + cAlias->PBH_XML))
					aAdd(aLogs,cAlias->PBH_XML + ' - Nao foi possivel copiar o arquivo para a pasta [ ' + cPathDest + ' ]')
				Else
					aAdd(aLogs,cAlias->PBH_XML + ' - Copiado para a pasta [ ' + cPathDest + ' ]')
					aDescEmail := {cAlias->PBH_XML,cPathDest,dDataBase,cAlias->PBH_TIPXML,cAlias->PBH_CODRDA}

					If ( nAux := aScan(aUsr_XML,{|x|x[1] == cAnalResp}) ) > 0
						aAdd(aUsr_XML[nAux][3],aDescEmail)
					Else
						aAdd(aUsr_XML,{cAnalResp,cCodAna,{aDescEmail}})
					EndIf

				EndIf

				cAlias->(DbSkip())

			EndDo

			cAlias->(DbCloseArea())

			Processa({||aRetMail := EnviaMail(,.T.)},'Enviando e-mail informativo para os resp. pelos RDAs [ ' + cEmpresa + ' ]')

			cPathDest 	:= cPathDesOld
			cPathProc	:= cPathProOld
			aLogs		:= aLogsOld
			aUsr_XML	:= aClone(aUsr_XMLOld)

			//-----------------------------------------------------------------------------------------------------------------------
			//- Leonardo Portella - 19/10/16 - Fim
			//-----------------------------------------------------------------------------------------------------------------------

			DbSelectArea('PBH')
			DbSetOrder(1)

			For nJ := 1 to len(aTmpExtr)

				If ( aTmpExtr[nJ][1] <> lGuiasVerdes )
					loop
				EndIf

				cPathProc 		:= aTmpExtr[nJ][2]
				cCompet			:= aTmpExtr[nJ][3]
				dEnvMedlink		:= aTmpExtr[nJ][4]
				lPrefeitura		:= ( aTmpExtr[nJ][5] == 'PREFEITURA' )//Leonardo Portella - 13/11/15

				nQtdArqs 	:= aDir(cPathProc + '*.*', aArqsProc, aSizes)

				If nQtdArqs == 0
					aAdd(aLogs,'Nao foram encontrados arquivos ' + If(lGuiasVerdes,' de Guias Verdes ','') + 'na pasta [ ' + cPathProc + ' ]')
				Else

					ProcRegua(nQtdArqs)

					For nI := 1 to nQtdArqs
						IncProc('XML X ' + If(lGuiasVerdes,'Guias Verdes X ','') + 'RDA X analista [ ' + cValToChar(nI) + ' de ' + cValToChar(nQtdArqs) + ' ]')

						//Leonardo Portella - 03/12/13 - Inicio - Virada P11

						If Upper(Right(AllTrim(aArqsProc[nI]),3)) <> 'XML'
							Loop
						EndIf

						//Leonardo Portella - 03/12/13 - Fim

						aVersaoTiss := c_VersaoTiss(cPathProc + aArqsProc[nI])
						cVersaoTiss	:= aVersaoTiss[1]
						c_NameSpace	:= aVersaoTiss[2]

						cRDA := cRDA_XML(cPathProc + aArqsProc[nI])

						cRet := cAnaResRDA(cRDA)

						If !empty(cRet)
							cAnalResp 	:= Upper(AllTrim(UsrRetName(AllTrim(cRet))))
							cCodAna		:= AllTrim(cRet)
						Else
							cAnalResp 	:= cRDA_Sem_Resp
							cCodAna		:= ''
						EndIf

						cArq := MemoRead(cPathProc + aArqsProc[nI])

						If At('guiaResumoInternacao',cArq) > 0
							cTipoXML := "INTERNACAO"
						ElseIf At('guiaSP_SADT',cArq) > 0
							cTipoXML := "SADT"
						ElseIf At('guiaConsulta',cArq) > 0
							cTipoXML := "CONSULTA"
						ElseIf At('guiaHonorarioIndividual',cArq) > 0
							cTipoXML := "HONORARIO"
						Else
							cTipoXML := "-"
						EndIf

						//-----------------------------------------------------------------------------------
						//DistribuiÁ„o por apenas alguns importadores - Leonardo Portella - 06/10/16 - InÌcio
						//-----------------------------------------------------------------------------------

						If len(aAnaResImp) > 0

							nPosRDAImp 	:= 0
							nPosImport	:= 0

							//Se J· existe um importador para este RDA (priorizo que todas as guias do mesmo RDA fiquem com o mesmo importador)
							If ( nPosRDAImp := aScan(aRDAxImp,{|x| x[1] == cRDA}) ) > 0

								cImportador := aRDAxImp[nPosRDAImp][2]
								nPosImport	:= aScan(aAnaResImp,{|x| x[1] == cImportador})
								++aAnaResImp[nPosImport][2]	//Incrementa quantidade no importador

							Else

								//Ordena do importador com menos arquivos para o importador com mais arquivos
								aSort(aAnaResImp,,,{|x,y| If(x[2] == y[2], x[1] < y[1], x[2] < y[2])})

								cImportador := aAnaResImp[1][1] 		//Importador com menos arquivos
								++aAnaResImp[1][2] 						//Incrementa quantidade no importador
								aAdd(aRDAxImp,{cRDA, cImportador}) 		//Coloco o com menos arquivos como novo importador deste RDA

							EndIf

						EndIf

						//-----------------------------------------------------------------------------------
						//DistribuiÁ„o por apenas alguns importadores - Leonardo Portella - 06/10/16 - Fim
						//-----------------------------------------------------------------------------------

						//-----------------------------------------------------------------------------------
						//ImportaÁ„o discriminando se o XML possui protocolo ou n„o - 11/10/16 - InÌcio
						//-----------------------------------------------------------------------------------

						lProtOk := lProtXML(cRDA, aArqsProc[nI])

						//-----------------------------------------------------------------------------------
						//ImportaÁ„o discriminando se o XML possui protocolo ou n„o - 11/10/16 - Fim
						//-----------------------------------------------------------------------------------

						//SERGIO CUNHA SOLICITACAO MAX 09/03/2017 - INICIO

						//-----------------------------------------------------------------------------------
						// INÕCIO
						//-----------------------------------------------------------------------------------
						//MATEUS MEDEIROS - 23/01/2018 - 12:15
						//-----------------------------------------------------------------------------------
						//ImportaÁ„o separando arquivos de NUPRES em pastas separadas.
						// Chamado GLPI - 37260
						//-----------------------------------------------------------------------------------
						if ( cRDA $ '125970|131903|136204|' )
							//				if 		cRDA == '125970'
							//					cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + cRDA) +'\NUPRES\125970' + If(lProtOk,'','\Sem_Protocolo') + '\'+ ''
							//				Elseif  cRDA == '131903'
							//					cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + cRDA) +'\NUPRES\131903' + If(lProtOk,'','\Sem_Protocolo') + '\'+ ''
							//				Elseif  cRDA == '136204'
							//					cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + cRDA) +'\NUPRES\136204' + If(lProtOk,'','\Sem_Protocolo') + '\'+ ''
							//				Else
							cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + cRDA) +'\NUPRES' + If(lProtOk,'','\Sem_Protocolo') + '\'+ ''

							//				Endif

						else
							cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + '\'
						endif
						//-----------------------------------------------------------------------------------
						// FIM - GLPI - 37260
						//-----------------------------------------------------------------------------------

						/*
						//Leonardo Portella - 13/11/15 - Inclus„o do trecho "If(lPrefeitura,'\Prefeitura','') + "
						If !lGuiasVerdes
							If cTipoXML == "INTERNACAO"
								cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + If(lPrefeitura,'\Prefeitura','') + '\Internacao\'
							ElseIf cTipoXML == "HONORARIO"
								cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + If(lPrefeitura,'\Prefeitura','') + '\Honorarios\'
							Else
								cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + If(lPrefeitura,'\Prefeitura','') + '\Cons\'
							EndIf
						Else
							//Leonardo Portella - 13/11/15 - Conforme conversa com M·rcia, CM n„o usa mais Guas Verdes. Desabilitada separaÁ„o na pasta de guias verdes
							//cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + If(lPrefeitura,'\Prefeitura','') /*+ If(lGuiasVerdes,'\Guias_Verdes','') + '\Cons\'
							cPathDest := cPathExtr + cCompet + '\' + If(!empty(cImportador),cImportador, cAnalResp + '\' + cRDA) + If(lProtOk,'','\Sem_Protocolo') + '\'
						EndIf
						*/

						//SERGIO CUNHA SOLICITACAO MAX 09/03/2017 - FIM

						If !ExistDir(cPathDest)
							MakePath(cPathDest)
						EndIf

						If !MoveFile(cPathProc + aArqsProc[nI],cPathDest + aArqsProc[nI])
							aAdd(aLogs,aArqsProc[nI] + ' - Nao foi possivel mover o arquivo para a pasta [ ' + cPathDest + ' ]')
						Else
							aAdd(aLogs,aArqsProc[nI] + ' - Movido para a pasta [ ' + cPathDest + ' ]')
							aDescEmail := {aArqsProc[nI],cPathDest,dEnvMedlink,cTipoXML,cRDA}

							If ( nAux := aScan(aUsr_XML,{|x|x[1] == cAnalResp}) ) > 0
								aAdd(aUsr_XML[nAux][3],aDescEmail)
							Else
								aAdd(aUsr_XML,{cAnalResp,cCodAna,{aDescEmail}})
							EndIf

						EndIf
					Next

				EndIf

			Next

			If lGuiasVerdes

				If ( aDir(cPathTMP + '*.*', aArqsProc, aSizes) == 0 )
					cPathProc := If(Right(cPathProc,1) == '\',Left(cPathProc,len(cPathProc) - 1),cPathProc)

					If ( FErase(cPathTMP) == -1 )
						aAdd(aLogs,'- Erro ao tentar deletar a pasta [ ' + cPathTMP + ' ]' + cEnt + 'Descricao do erro: [ ' + cDesFerror(FError()) + ' ] [ ' + cEmpresa + ' ]')
					Else
						aAdd(aLogs,'- Pasta [ ' + cPathTMP + ' ] deletada [ ' + cEmpresa + ' ]')
					EndIf
				Else
					aAdd(aLogs,'- Existem arquivos na pasta [ ' + cPathTMP + ' ] e por isso a mesma nao foi deletada [ ' + cEmpresa + ' ]')
				EndIf

			EndIf

			Return {lOk,cErro,aLogs}

			**********************************************************************

		Static Function cRDA_XML(cXML)

			Local nHandle 		:= FT_FUse(cXML)
			Local cRDA			:= ''

			// Posiciona na primeira linha
			FT_FGoTop()

			While !FT_FEOF()

				cLine := FT_FReadLn() // Retorna a linha corrente

				cTagIni	:= '<' + c_NameSpace+ ':codigoPrestadorNaOperadora>'//'<ansTISS:codigoPrestadorNaOperadora>'
				nPosIni	:= At(cTagIni,cLine)

				cTagFim	:= '</' + c_NameSpace+ ':codigoPrestadorNaOperadora>'//'</ansTISS:codigoPrestadorNaOperadora>'
				nPosFim	:= At(cTagFim,cLine)

				If nPosIni > 0 .and. nPosFim > 0 //Encontrei a TAG
					exit
				EndIf

				FT_FSKIP()

			EndDo

			// Fecha o Arquivo
			FCLOSE(nHandle)
			FT_FUSE()

			If At(cTagIni,cLine) <> Rat(cTagIni,cLine)//As 2 tags estao na mesma linha
				cRDA	:= substr(cLine,nPosIni + 2*len(cTagIni),TamSX3('BAU_CODIGO')[1])
			Else
				cRDA	:= substr(cLine,nPosIni + len(cTagIni),TamSX3('BAU_CODIGO')[1])
			EndIf

			Return cRDA

			**********************************************************************

		Static Function c_VersaoTiss(cXML)

			Local nHandle 		:= FT_FUse(cXML)
			Local cRDA			:= ''
			Local nContAux 		:= 0
			Local nI			:= 0
			Local aRet			:= Array(2)

			// Posiciona na primeira linha
			FT_FGoTop()

			While !FT_FEOF() .and. ( ++nContAux <= 50 )//Se nao encontrar o codigo do RDA nas 50 primeiras linhas houve algum erro

				cLine := FT_FReadLn() // Retorna a linha corrente

				cTagIni	:= ':versaoPadrao>'
				nPosIni	:= At(cTagIni,cLine)

				While ( nPosIni > 0 ) .and. ( Substr(cLine,nPosIni - nI,1) <> '<' )
					nI++
				EndDo

				c_NameSpace := Substr(cLine,nPosIni-nI+1,nI-1)

				cTagIni	:= '<' 	+ c_NameSpace + ':versaoPadrao>'
				cTagFim	:= '</' + c_NameSpace + ':versaoPadrao>'

				nPosIni	:= At(cTagIni,cLine)
				nPosFim	:= At(cTagFim,cLine)

				If nPosIni > 0 .and. nPosFim > 0 //Encontrei a TAG
					aRet[1] := Substr(cLine,( nPosIni + len(cTagIni) ),( nPosFim - nPosIni - len(cTagFim) + 1))
					aRet[2] := c_NameSpace
					Exit
				EndIf

				FT_FSKIP()

			EndDo

			// Fecha o Arquivo
			FCLOSE(nHandle)
			FT_FUSE()

			If empty(c_NameSpace)
				If MsgYesNo('NameSpace vazio!!! XML: ' + cXML + cEnt + 'Continua?')
					Return
				EndIf
			EndIf

			Return aRet

			**********************************************************************

		Static Function MovArqOr()

			Local aFiles 	:= {}
			Local aSizes 	:= {}
			Local aLogs		:= {}
			Local lOk		:= .T.
			Local cErro		:= ''
			Local nI		:= 0
			Local nQtdArqs 	:= aDir(cPastaDes + '*.ZIP', aFiles, aSizes)

			ProcRegua(nQtdArqs)

			//Crio a pasta em que serao gravados os arquivos caso ela nao exista
			If !ExistDir(cPathOrig)
				MakePath(cPathOrig)
			EndIf

			For nI := 1 to nQtdArqs

				IncProc('Movendo arquivos originais [ ' + cValToChar(nI) + ' de ' + cValToChar(nQtdArqs) + ' ]')

				If !MoveFile(cPastaDes + aFiles[nI],cPathOrig + aFiles[nI])
					aAdd(aLogs,cPastaDes + aFiles[nI] + ' - Nao foi possivel mover o arquivo [ ' + cEmpresa + ' ]')
				Else
					aAdd(aLogs,cPastaDes + aFiles[nI] + ' - Movido para a pasta [ ' + cPathOrig + ' ] [ ' + cEmpresa + ' ]')

					If ( FRename(cPathOrig + aFiles[nI],cPathOrig + 'EXT_AUT_' + aFiles[nI]) == -1 )
						aAdd(aLogs,'Nao foi possivel renomear o arquivo [ ' + cPathOrig + aFiles[nI] + ' ] para [ ' + cPathOrig + 'EXT_' + aFiles[nI] + '] [ ' + cEmpresa + ' ]')
					Else
						aAdd(aLogs,'Arquivo [ ' + cPathOrig + aFiles[nI] + ' ] renomeado para [ ' + cPathOrig + 'EXT_' + aFiles[nI] + '] [ ' + cEmpresa + ' ]')
					EndIf
				EndIf

			Next

			Return {lOk,cErro,aLogs}

			**********************************************************************

		Static Function EnviaMail(lConferencia, lSemProtRecup)

			Local cSubject
			Local cBody 		:= ""
			Local cTo
			Local cCopy			:= 'leonardo.portella@caberj.com.br,roberto.meirelles@caberj.com.br,sergio.cunha@caberj.com.br,denise.rocha@caberj.com.br,filipe.silva@caberj.com.br'
			Local cMailSecund	:= ''
			Local cServer 		:= SuperGetmv("MV_RELSERV")
			Local cAccount		:= SuperGetmv("MV_RELACNT")
			Local cPassword		:= SuperGetMv("MV_RELAPSW")
			Local cRemetente	:= SuperGetMv("MV_WFMAIL")
			Local nTimeOut	    := SuperGetMv("MV_RELTIME",,120)
			Local lAutentica    := SuperGetMv("MV_RELAUTH",,.F.)
			Local cMsgRet 		:= ""
			Local lResult		:= .T.
			Local nI			:= 0
			Local nJ			:= 0
			Local aInfo
			Local cMail
			Local cNomeUsr
			Local cLogAna		:= ''

			Default	lConferencia	:= .F.

			Default lSemProtRecup	:= .F. //lSemProtRecup: .T. - Anteriormente estava sem protocolo mas agora a Operativa disponibilizou

			If lConferencia
				aUsr_XML := {'sendmail'}
			EndIf

			For nI := 1 to len(aUsr_XML)

				cTo	:= 'max.santos@caberj.com.br,fernanda.moura@caberj.com.br,milena.silva@caberj.com.br'

				IncProc('Enviando e-mails de confirmaÁ„o')

				If !lConferencia

					If ( aUsr_XML[nI][1] == cRDA_Sem_Resp )
						//cTo 		:= cMailSecund
						cSubject 	:= cEmpresa + ' - Recebimento de arquivo XML - RDA sem responsavel cadastrado'
						cLogAna		:= cRDA_Sem_Resp + ' - RDA sem respons·vel cadastrado'
					Else
						aStatUsr := StatUsr(aUsr_XML[nI][2])//{lOk,cDescri,cNomeUsr,cMail}

						If !aStatUsr[1]
							//cTo	:= cMailSecund
						Else
							cTo	+= ',' + aStatUsr[4]
						EndIf

						cSubject 	:= cEmpresa + ' - Recebimento de arquivo XML - Analista respons·vel ' + aStatUsr[2]

						cLogAna		:= aUsr_XML[nI][2] + ' - Analista respons·vel ' + aStatUsr[2]
					EndIf

				Else
					cSubject 	:= 'VERIFICACAO DE ARQUIVOS XML'
				EndIf

				//cMailSecund := cTo	:= 'leonardo.portella@caberj.com.br'

				cBody := '<html>'
				cBody += '<head>'
				cBody += '<title>RECEBIMENTO DE ARQUIVO XML</title>'
				cBody += '</head>'
				cBody += '<b><font size="3" face="Arial" color="Black">' + cSubject + '</font></b>'
				cBody += '<br>'
				cBody += '<br>'

				cCor		:= If(cEmpresa == 'CABERJ','#99FF99','#FFA500')
				cCorRealce	:= If(cEmpresa == 'CABERJ','#33FF33','#FF6600')
				cCorCap		:= cCor
				cCorGrp		:= cCor
				cCorSubG	:= cCor
				cFonteCab	:= 'Arial'
				cFonteTxt	:= 'Courier New'

				If !lConferencia

					cBody += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCor + '">'
					cBody += '<tr>'
					cBody += '<td width=500><b><font size="3" face="' + cFonteCab + '" color="Black">XML</font></b></td>'
					cBody += '<td width=500><b><font size="3" face="' + cFonteCab + '" color="Black">Pasta</font></b></td>'
					cBody += '</tr>'

					For nJ := 1 to len(aUsr_XML[nI][3])

						cBody += '<tr>'
						cBody += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + aUsr_XML[nI][3][nJ][1]		+ '</font></td>'	 //XML
						cBody += '<td><font size="3" face="' + cFonteTxt + '" color="Black">' + aUsr_XML[nI][3][nJ][2]		+ '</font></td>'	 //Pasta
						cBody += '</tr>'

					Next

				Else

					cBody += '<table width="100%" border="2" bordercolor="black" bgcolor="' + cCor + '">'
					cBody += '<tr>'
					cBody += '<td width=500><b><font size="3" face="' + cFonteCab + '" color="Black">' + Upper(cEmpresa) + '</font></b></td>'
					cBody += '</tr>'

					cBody += '<tr>'
					cBody += '<td><font size="3" face="' + cFonteTxt + '" color="Black">N√O FORAM ENCONTRADOS ARQUIVOS NO FTP DA MEDLINK</font></td>'	 //XML
					cBody += '</tr>'

				EndIf

				cBody += '</table>'// width="100%">'
				cBody += '<br>'

				cBody += '</body>'
				cBody += '</html>'

				cTo := "" //strtran(cTo,",",";")

				if u_ZSendMail(/*cAccount*/,/*cPassword*/,/*cServer*/,/*cFrom*/,cTo,cSubject,cBody,/*cAttach*/,/*cEmailCCC*/,/*lMsg1*/)

				else
					cSubject := 'Falha no envio de e-mail - ' + ' [ ' + cTo + ' ] ' + cSubject
				endif
				/*CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut RESULT lResult

				If lResult

					If !lAutentEmail //

						if lAutentica
							MailAuth(cAccount,cPassword)
						endif

						SEND MAIL FROM cAccount 	;
							TO cTo					 	;
							CC cCopy					;
							SUBJECT cSubject			;
							BODY cBody					;
							ATTACHMENT ""				;
							RESULT lEnviou

						If !lEnviou
							lResult 	:= .F.

							GET MAIL ERROR cMsgRet

							cMsgRet 	:= 	'  Erro no envio de e-mail ' 				+ cEnt 	;
								+ '   - TO [ ' + cTo + ' ]' 				+ cEnt 	;
								+ '   - CC [ ' + cBody + ' ]' 	  			+ cEnt 	;
								+ '   - SUBJECT [ ' + cSubject + ' ]' 		+ cEnt 	;
								+ '  ' + cMsgRet

							cSubject := 'Falha no envio de e-mail - ' + ' [ ' + cTo + ' ] ' + cSubject

							DISCONNECT SMTP SERVER

							CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword TIMEOUT nTimeOut RESULT lResult

							//cTo := cMailSecund
							if lAutentica
								MailAuth(cAccount,cPassword)
							endif
							//Em caso de falha, mando e-mail para o responsavel
							SEND MAIL FROM cAccount 	;
								TO cTo					 	;
								CC cCopy 					;
								SUBJECT cSubject			;
								BODY cBody					;
								ATTACHMENT ""				;
								RESULT lEnviou

							If !lEnviou
								lResult 	:= .F.

								GET MAIL ERROR cMsgRet

								cMsgRet += 	'  Erro no envio de e-mail ao responsavel'	+ cEnt 	;
									+ '   - TO [ ' + cTo + ' ]' 					+ cEnt 	;
									+ '   - CC [ ' + cBody + ' ]' 	 	 			+ cEnt 	;
									+ '   - SUBJECT [ ' + cSubject + ' ]' 			+ cEnt 	;
									+ '  ' + cMsgRet								+ cEnt

							Else
								cMsgRet += cEnt + '  E-mail enviado ao responsavel alternativo [ ' + cMailSecund + ' ]'
							EndIf

						EndIf

					Else

						lResult 	:= .F.
						cMsgRet 	:= ""

						GET MAIL ERROR cMsgRet

						cMsgRet 	:= 	'Falha na autenticacao com servidor de e-mail...' 	+ cEnt 	;
							+ 'Erro no envio de e-mail ' 						+ cEnt 	;
							+ '   - TO [ ' + cTo + ' ]' 						+ cEnt 	;
							+ '   - CC [ ' + cBody + ' ]' 	  					+ cEnt 	;
							+ '   - SUBJECT [ ' + cSubject + ' ]' 				+ cEnt 	;
							+ '   [ ' + cMsgRet + ' ]'
					End
				Else
					cMsgRet := "Falha na conexao com servidor de e-mail..."
				End

				DISCONNECT SMTP SERVER
				*/
				If !lConferencia

					DbSelectArea('PBH')

					For nJ := 1 to len(aUsr_XML[nI][3])

						IncProc('Gravando logs [ ' + cValToChar(nJ) + ' de ' + cValToChar(len(aUsr_XML[nI][3])) + ' ]')

						Reclock('PBH',.T.)

						PBH_FILIAL 	:= xFilial('PBH')
						PBH_EMPRESA	:= cEmpresa
						PBH_XML		:= aUsr_XML[nI][3][nJ][1]
						PBH_DTDOWN	:= Date()
						PBH_HRDOWN	:= Time()
						PBH_USRCHK	:= RetCodUsr() + ' - ' + Upper(AllTrim(UsrFullName(RetCodUsr())))
						PBH_PATHAR	:= aUsr_XML[nI][3][nJ][2]
						PBH_ANARES	:= cLogAna
						PBH_MAIL	:= cTo
						PBH_DTMEDL	:= aUsr_XML[nI][3][nJ][3]
						PBH_STATUS	:= If(!lSemProtRecup,'BAIXADO','PROT LOC- RECUP')
						PBH_TIPXML	:= aUsr_XML[nI][3][nJ][4]
						PBH_CODRDA	:= aUsr_XML[nI][3][nJ][5]

						MsUnlock()

					Next

				EndIf

			Next

			Return {lResult,cMsgRet}

			*************************************************

			//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
			//≥Prepara para importacao dos arquivos XML. Cria as pastas      ≥
			//≥necessarias a importacao e copia os arquivos para a respectiva≥
			//≥pasta para cada empresa.                                      ≥
			//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

		User Function PreImpXML

			Processa({||PPreImpXML()},'Preparando para importacao dos XML')

			Return

			*************************************************

		Static Function PPreImpXML

			Local aUsuarios := {}
			Local cRetLogin	:= RetLogin()
			Local cUsuario	:= ''
			Local cLog		:= ''
			Local cPathIni	:= '\Tiss\Analistas\'
			Local cPathOri	:= '\Tiss\Schemas\'
			Local cPathDes	:= '\Tiss\Imp\'
			Local aSchemas	:= {}
			Local aSizes	:= {}
			Local nI		:= 0
			Local nJ		:= 0
			Local cArqCria	:= ''
			Local cArqEnt	:= ''
			Local nQtdArqs	:= 0

			If !empty(cRetLogin)
				aUsuarios := Separa(cRetLogin,';')
				nQtdArqs := aDir(cPathOri + '*.XSD', aSchemas, aSizes)
			EndIf

			ProcRegua(len(aUsuarios) * nQtdArqs * 2)

			For nI := 1 to len(aUsuarios)

				//CABERJ

				cUsuario 	:= AllTrim(UsrRetName(aUsuarios[nI]))

				cArqEnt		:= AllTrim(Left(cPathDes + 'Cab\' + cUsuario,25)) + '\caixaentrada\'
				cArqCria 	:= AllTrim(Left(cPathDes + 'Cab\' + cUsuario,25)) + '\Schemas\'

				If !ExistDir(cArqCria)
					MakePath(cArqCria)
				EndIf

				If !ExistDir(cArqEnt)
					MakePath(cArqEnt)
				EndIf

				For nJ := 1 to nQtdArqs
					IncProc('Movendo arquivo ' + cValToChar(nJ) + ' de ' + cValToChar(nQtdArqs) + ' [ Caberj ]')

					If !File(cArqCria + aSchemas[nJ])
						MoveFile(cPathOri + aSchemas[nJ],cArqCria + aSchemas[nJ],.F.)
					EndIf
				Next

				//INTEGRAL

				cArqEnt		:= AllTrim(Left(cPathDes + 'Int\' + cUsuario,25)) + '\caixaentrada\'
				cArqCria 	:= AllTrim(Left(cPathDes + 'Int\' + cUsuario,25)) + '\Schemas\'

				If !ExistDir(cArqCria)
					MakePath(cArqCria)
				EndIf

				If !ExistDir(cArqEnt)
					MakePath(cArqEnt)
				EndIf

				For nJ := 1 to nQtdArqs
					IncProc('Movendo arquivo ' + cValToChar(nJ) + ' de ' + cValToChar(nQtdArqs) + ' [ Integral ]')

					If !File(cArqCria + aSchemas[nJ])
						MoveFile(cPathOri + aSchemas[nJ],cArqCria + aSchemas[nJ],.F.)
					EndIf
				Next

			Next

			If !empty(cRetLogin)
				MsgInfo('Pastas criadas e Schemas copiados!',AllTrim(SM0->M0_NOMECOM))
			EndIf

			Return

			***************************************************

		User Function RDA_ANA_RES

			Processa({||PRDA_ANA_RES()},'Verificando RDAs X Analista Resp.')

			Return

			***************************************************

		Static Function PRDA_ANA_RES

			Local cQuery 	:= ''
			Local cAlias	:= GetNextAlias()
			Local cCriticas	:= ''
			Local nI		:= 0
			Local nTot		:= 0
			Local nCount	:= 0

			ProcRegua(0)

			For nI := 1 to 5
				IncProc('Verificando registros...')
			Next

			For nI := 1 to len(aEmpresas)

				//Chumbado Caberj pois atualmente este controle eh feito somente na Caberj mas eh valido para Integral tambem. Combinado com Eloiza.
				cQuery := "SELECT '" + aEmpresas[nI] + "' EMPRESA,TRIM(NVL(ZN_CODANA,'" + cRDA_Sem_Resp + "')) ZN_CODANA,BAU_CODIGO,BAU_NOME"		+ cEnt
				cQuery += "FROM BAU" + If(aEmpresas[nI] == 'CABERJ','010','020') + " BAU"	  									  					+ cEnt
				cQuery += "LEFT JOIN SZN010 SZN ON SZN.D_E_L_E_T_ = ' '"							  			  				 					+ cEnt
				cQuery += "  AND ZN_FILIAL = '" + xFilial('SZN') + "'" 	 								  											+ cEnt
				cQuery += "  AND ZN_CODRDA = BAU_CODIGO"  																							+ cEnt
				cQuery += "  AND ZN_ATIVO IN (' ','0')" 					  																		+ cEnt
				cQuery += "  AND '" + DtoS(dDataBase) + "' >= ZN_VIGINI" 		   			   														+ cEnt
				cQuery += "  AND (ZN_VIGFIM = ' ' OR '" + DtoS(dDataBase) + "' <= ZN_VIGFIM)"	  										 			+ cEnt
				cQuery += "WHERE BAU.D_E_L_E_T_ = ' '"	 												   					  						+ cEnt
				cQuery += "  AND BAU_FILIAL = '" + xFilial('BAU') + "'" 							   						  						+ cEnt
				cQuery += "  AND BAU_XMEDLI = 'S'" 																			  						+ cEnt
				cQuery += "  AND ( BAU_DATBLO = ' ' OR BAU_DATBLO >= '" + DtoS(dDataBase) + "')" 							  						+ cEnt

				TcQuery cQuery New Alias cAlias

				COUNT TO nTot

				cAlias->(DbGoTop())

				ProcRegua(nTot)

				nCount := 0

				While !cAlias->(EOF())

					IncProc('Processando [ ' + cValToChar(++nCount) + ' de ' + cValToChar(nTot) + ' ] [ ' + aEmpresas[nI] + ' ]')

					If cAlias->(ZN_CODANA) == cRDA_Sem_Resp
						cCriticas 	+= cAlias->(EMPRESA + ' - ' + BAU_CODIGO + ' [ ' + AllTrim(BAU_NOME) + ' ] - ' + 'RDA sem respons·vel')   		 + cEnt
					Else
						aStatUsr 	:= StatUsr(AllTrim(cAlias->(ZN_CODANA)))//{lOk,cDescri,cNomeUsr,cMail}

						If !aStatUsr[1]
							cCriticas 	+= cAlias->(EMPRESA + ' - '  + BAU_CODIGO + ' [ ' + AllTrim(BAU_NOME) + ' ] - Analista: ' + aStatUsr[2])	 + cEnt
						EndIf
					EndIf

					cAlias->(DbSkip())

				EndDo

				cAlias->(DbCloseArea())

			Next

			LogErros(cCriticas,'CrÌticas de RDAs X Analista responsavel',.T.,'M')

			Return

			***************************************************

		Static Function StatUsr(c_CodUsr)

			Local aInfo 	:= {}
			Local cMail 	:= ''
			Local cNomeUsr	:= ''
			Local lOk		:= .T.
			Local cDescri	:= ''

			PswOrder(1)

			If PswSeek(c_CodUsr, .T. )

				aInfo 		:= PswRet()
				cMail 		:= AllTrim(aInfo[1][14])
				cNomeUsr	:= AllTrim(Upper(aInfo[1][4]))

				Do Case

				Case aInfo[1][17]//Usuario bloqueado
					lOk 		:= .F.
					cDescri 	:= 'bloqueado [ ' + c_CodUsr + ' - ' + cNomeUsr + ' ]'

				Case aInfo[1][6] < Date()//Usuario com data de validade vencida
					lOk 		:= .F.
					cDescri		:= 'data de validade vencida [ ' + c_CodUsr + ' - ' + cNomeUsr + ' ]'

				Case empty(cMail)
					lOk 		:= .F.
					cDescri		:= 'sem e-mail cadastrado [ ' + c_CodUsr + ' - ' + cNomeUsr + ' ]'

				Otherwise
					lOk 		:= .T.
					cDescri		:= '[ ' + c_CodUsr + ' - ' + cNomeUsr + ' ]'

				EndCase

			Else

				lOk 		:= .F.
				cDescri 	:= 'nao encontrado [ ' + c_CodUsr + ' ]'

			EndIf

			Return {lOk,cDescri,cNomeUsr,cMail}

			******************************************************************************************************************

		User Function BuscaXML

			Processa({||PBuscaXML()},'Buscando XML')

			Return

			******************************************************************************************************************

		Static Function PBuscaXML

			Local cRet 			:= ""
			Local aXMLBuscar	:= {}
			Local nI			:= 0
			Local cPath			:= cGetFile('','XML',1, "\TISS\", .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_RETDIRECTORY+GETF_NETWORKDRIVE ,.T., .T.)
			Local aArqDIR		:= {}
			Local cLogCab		:= ''
			Local cLog			:= ''
			Local nQtdArqs		:= 0
			Local nQtdDir		:= 0
			Local nQtdAchados	:= 0
			Local nQtdNAchados	:= 0

			If empty(cPath)
				Alert('Informe o local onde est„o os arquivos XML!')
			Else
				cRet := LogErros(cRet,"XMLs a buscar",.F.,'M')

				cLogCab 	+= 'Local do backup dos arquivos: [ ' + cPath + ' ]' + cEnt

				aXMLBuscar := Separa(cRet,cEnt,.F.)

				nQtdArqs 	:= len(aXMLBuscar)

				aDuplicados := aDuplArray(aXMLBuscar)

				For nI := 1 to len(aDuplicados)
					cLogCab 	+= 'Duplicado na lista Verificar[ ' + aDuplicados[nI] + ' ]' + cEnt
				Next

				aDir(cPath + "*.xml", aArqDIR)

				nQtdDir := len(aArqDIR)

				aDuplicados := aDuplArray(aArqDIR)

				For nI := 1 to len(aDuplicados)
					cLogCab 	+= 'Duplicado no diretÛrio [ ' + aDuplicados[nI] + ' ]' + cEnt
				Next

				ProcRegua(nQtdArqs)

				For nI := 1 to nQtdArqs

					IncProc('Buscando XML ' + cValToChar(nI) + ' de ' + cValToChar(nQtdArqs))

					If ( aScan(aArqDIR,{|x|Upper(AllTrim(x)) == Upper(AllTrim(aXMLBuscar[nI]))}) > 0 )
						nQtdAchados++
						cLog 	+= '- Arquivo ' + Upper(AllTrim(aXMLBuscar[nI])) + ' localizado nos backups'
					Else
						nQtdNAchados++
						cLog 	+= '- Arquivo ' + Upper(AllTrim(aXMLBuscar[nI])) + ' N√O localizado nos backups'
					EndIf

					cLog += cEnt
				Next

				cLogCab 	+= 'Arquivos no Local do backup dos arquivos: [ ' + cValToChar(nQtdDir) + ' ]' 	+ cEnt
				cLogCab 	+= 'Arquivos na Lista a serem procurados: [ ' + cValToChar(nQtdArqs) + ' ]'		+ cEnt
				cLogCab 	+= 'Arquivos localizados: [ ' + cValToChar(nQtdAchados) + ' ]' 					+ cEnt
				cLogCab 	+= 'Arquivos N√O localizados: [ ' + cValToChar(nQtdNAchados) + ' ]' 			+ cEnt
				cLogCab 	+= cEnt

				cLog := cLogCab + cLog

				LogErros(cLog,"XMLs a buscar - resultado",.T.,'M')
			EndIf

			Return

			******************************************************************************************************

		Static Function aDuplArray(aVerificar)

			Local aRet 			:= {}
			Local aBuffer		:= {}
			Local nJ			:= 0
			Local nQtdArqs		:= len(aVerificar)

			ProcRegua(nQtdArqs)

			For nJ := 1 to nQtdArqs
				IncProc('Verificando duplicados ' + cValToChar(nJ) + ' de ' + cValToChar(nQtdArqs))

				If aScan(aBuffer,aVerificar[nJ]) > 0
					aAdd(aRet,aVerificar[nJ])
				Else
					aAdd(aBuffer,aVerificar[nJ])
				EndIf
			Next

			Return aRet

			******************************************************************************************************

			//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
			//≥Revaloriza cobranca de guias em lote≥
			//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

		User Function RevCobGuia

			Local cAutorizados 	:= GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN')
			Local aGuiasRev		:= {}

			Private c_GuiasRev
			Private cLocalDig
			Private cCodOpe
			Private c_CodPeg
			Private c_RDA
			Private c_Guia

			If !(RetCodUsr() $ cAutorizados)
				MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
				Return
			EndIf

			nOpca := 0

			cMsg := "Informe em cada linha: RDA, Local de Digitacao, PEG, Guia. Separe os codigos por ponto-e-virgula ( ; )" + cEnt + cEnt
			cMsg += 'CONTINUA?'

			If MsgYesNo(cMsg,SM0->M0_NOMECOM)

				c_GuiasRev := LogErros('','RevalorizaÁ„o de cobranÁa em lote. (Informe: RDA;Local de Digitacao;PEG;Guia p/ linha)',.F.,'M')

				If empty(c_GuiasRev)
					MsgStop('Informe as PEGs/Guias',SM0->M0_NOMECOM)
				Else

					Processa({||aGuiasRev := GetGuias(c_GuiasRev)},"Verificando dados de entrada")

					c_GuiasRev := ''

					If !empty(aGuiasRev)
						Processa({||ProcGuias(aGuiasRev)},"RevalorizaÁ„o de cobranÁa")
						MsgInfo('RevalorizaÁıes de cobranÁa realizadas!')
					EndIf

				EndIf

			EndIf

			Return

			***************************************************************************************************************

		Static Function GetGuias(c_GuiasRev)

			Local aRet 		:= {}
			Local aBuffer 	:= {}
			Local nI 		:= 1
			Local nCount	:= 1

			ProcRegua(0)

			For nI:=1 to 5
				IncProc('Verificando...')
			Next

			aBuffer := Separa(c_GuiasRev,CHR(13) + CHR(10))

			ProcRegua(len(aBuffer))

			For nCount := 1 to len(aBuffer)
				IncProc('Lendo dados... ' + cValToChar(nCount) + ' de ' + cValToChar(len(aBuffer)))

				//So adiciono ao vetor de revalorizacao os que nao sao duplicados
				If ( aScan(aBuffer,{|x|x == aBuffer[nCount]}) == nCount )
					aAdd(aRet,Separa(aBuffer[nCount],';'))
				EndIf
			Next

			aBuffer := {}

			ProcRegua(len(aRet))

			For nCount := 1 to len(aRet)

				IncProc('Validando dados... ' + cValToChar(nCount) + ' de ' + cValToChar(len(aRet)))

				If ValType(aRet) <> 'A'
					MsgStop('Linha ' + cValToChar(nCount + ' : Erro nos parametros. Retorno do Separa(cLinha,";") nao eh array!'),SM0->M0_NOMECOM)
					Return {}
				ElseIf len(aRet[nCount]) <> 4
					MsgStop('Linha ' + cValToChar(nCount + ' : Informada a quantidade errada de parametros!'),SM0->M0_NOMECOM)
					Return {}
				EndIf

			Next

			Return aRet

			***************************************************************************************************************

		Static Function ProcGuias(aGuias)

			Local cTot
			Local nContador := 0
			Local nQtdGuias	:= len(aGuias)

			ProcRegua(nQtdGuias)

			cTot := cValToChar(nQtdGuias)

			For nContador := 1 to nQtdGuias

				IncProc('Processando ' + cValToChar(nContador) + ' de ' + cTot)

				c_RDA		:= aGuias[nContador][1]
				cLocalDig	:= aGuias[nContador][2]
				c_CodPeg	:= aGuias[nContador][3]
				c_Guia		:= aGuias[nContador][4]
				cCodOpe		:= PlsIntPad()

				ProcRevCob()

			Next

			Return

			***************************************************************************************************************

		Static Function ProcRevCob()

			Local c_Alias		:= ''
			Local n_Recno		:= 0
			Local aArea			:= GetArea()

			BCI->(DbSetOrder(1))
			If !BCI->(DbSeek(xFilial('BCI') + cCodOpe + cLocalDig + c_CodPeg)) .or. ( BCI->BCI_CODRDA <> c_RDA )
				MsgStop('PEG n„o localizada - ' + xFilial('BCI') + cCodOpe + cLocalDig + c_CodPeg,AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf

			BD6->(DbSetOrder(1))
			If !BD6->(DbSeek(xFilial('BD6') + cCodOpe + cLocalDig + c_CodPeg + c_Guia)) .or. ( BD6->BD6_CODRDA <> c_RDA )
				MsgStop('BD6 n„o localizada - ' + xFilial('BD6') + cCodOpe + cLocalDig + c_CodPeg + c_Guia,AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf

			BCL->(DbSetOrder(1))
			If !BCL->(DbSeek(xFilial('BCL') + cCodOpe + BD6->BD6_TIPGUI ))
				MsgStop('BCL n„o localizada - ' + xFilial('BCL') + cCodOpe + BD6->BD6_TIPGUI,AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf

			c_Alias := BCL->BCL_ALIAS

			DbSelectArea(c_Alias)
			DbSetOrder(1)
			If !DbSeek(xFilial(c_Alias) + cCodOpe + cLocalDig + c_CodPeg + c_Guia)
				MsgStop(c_Alias + ' n„o localizada - ' + xFilial(c_Alias) + cCodOpe + cLocalDig + c_CodPeg + c_Guia,AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf

			n_Recno := RECNO()

			BD7->(DbSetOrder(1))
			If !BD7->(DbSeek(xFilial('BD7') + cCodOpe + cLocalDig + c_CodPeg + c_Guia)) .or. ( BD7->BD7_CODRDA <> c_RDA )
				MsgStop('BD7 n„o localizada - ' + xFilial('BD7') + cCodOpe + cLocalDig + c_CodPeg + c_Guia,AllTrim(SM0->M0_NOMECOM))
				Return
			EndIf

			PLSA500RCB(c_Alias,n_Recno,10,,.F.)

			RestArea(aArea)

			Return

			*****************************************************************************************************

		User Function HashSIB

			/*
			1 - Retirar alt 167 do arquivo [ ∫ ]
			2 - Retirar tags com conteudo espaco [ > < ]
			3 - Retirar os alt 167 [ ∫ ] do arquivo do hash ou pegar o hash de arquivo ja removido
			3 - Retirar os espacos [ > < ] do arquivo do hash ou pegar o hash de arquivo ja
			removido. Buscar uma referencia proxima e tirar na mao mesmo
			*/

			If Aviso('SIB','Tipo de operaÁ„o:',{'Arq/gera hash','String/gera hash'}) == 1
				Processa({||PHashSIB()},"Processando...")
			Else
				cConteudo := LogErros('','Hash SIB',.F.)
				LogErros(MD5(cConteudo,2),'Hash SIB')
			EndIf

			Return

			*******************************

		Static Function PHashSIB

			Local cArq		:= cGetFile('','SBX|XTE',1, 'C:\', .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE ,.T., .T.)
			Local nHandle 	:= FT_FUse(cArq)
			Local nPosIni	:= 0
			Local nPosFim	:= 0
			Local cConteudo	:= ''
			Local nAux 		:= 0
			Local nTot		:= FT_FLASTREC()
			Local cArqNew	:= Replace(cArq,'.SBX','.TXT')
			Local nTmpXml 	:= FCreate(cArqNew,0,,.F.)
			Local cTemp		:= ''
			Local lValidArq	:= MsgYesNo('ValidaÁ„o por arquivo? [ Usado para arquivos MUITO grandes ]')
			Local cHash		:= ''

			ProcRegua(nTot)

			cTot 	:= AllTrim(Transform(nTot,'@E 999,999,999'))
			nAux 	:= 0
			nCont 	:= 0

			FT_FGOTOP()

			//cConteudo 	+= 'http://www.ans.gov.br/padroes/sib/schemas http://www.ans.gov.br/padroes/sib/schemas/sib.xsd'
			//cTemp			+= 'http://www.ans.gov.br/padroes/sib/schemas http://www.ans.gov.br/padroes/sib/schemas/sib.xsd'

			FWrite(nTmpXml,cTemp,len(cTemp))

			While !FT_FEOF()

				IncProc('Processando linha ' + AllTrim(Transform(++nAux,'@E 999,999,999')) + ' de ' + cTot)

				cLine := FT_FReadLn()

				//AdaptaÁ„o para poder validar tambÈm o arquivo de Monitoramento: pego dinamicamente o conte˙do de xsi:schemaLocation
				If ( nAux <= 2 )

					nPosIni	:= At('xsi:schemaLocation',cLine)

					If ( nPosIni > 0 )
						nPosIni	:= At('"',cLine,nPosIni)
						nPosFim	:= At('"',cLine,nPosIni)
					EndIf

					If ( ( nPosIni > 0 ) .and. ( nPosFim > 0 ) )
						cConteudo 	+= Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
						cTemp		+= Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
					EndIf

				ElseIf ( nAux > 2 ) .and. ( nAux < ( nTot - 4 ) )

					nPosIni	:= At('>',cLine)
					nPosFim	:= At('</',cLine)

					If ( ( nPosIni > 0 ) .and. ( nPosFim > 0 ) )
						cTemp 		:= Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
						FWrite(nTmpXml,cTemp,len(cTemp))

						If !lValidArq
							cConteudo 	+= Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
						EndIf
					EndIf

				EndIf

				FT_FSKIP()

			EndDo

			// Fecha o Arquivo
			FCLOSE(nHandle)
			FT_FUSE()

			// Fecha o Arquivo
			FCLOSE(nTmpXml)
			FT_FUSE()

			If !lValidArq
				cHash 	:= MD5(cConteudo,2)
				LogErros(cHash,'Hash SIB - ValidaÁ„o por vari·vel')
				LogErros(cConteudo,'String usada para calcular o Hash SIB')
			Else
				cHash 	:= &("MD5File('" + cArqNew + "',2)")

				LogErros(	cHash + cEnt + ;
					'Arquivo com String usada para calcular o Hash SIB: ' + cEnt + cArqNew,;
					'Hash SIB - ValidaÁ„o por arquivo')
			EndIf

			Return

			*****************************************************************************************************
			*****************************************************************************************************

		User Function RetChar10

			If Aviso('XML cÛdigos 10 caracteres','Ajuste XML',{'Processar'}) == 1
				Processa({||PRetChar10()},"Ajustando XML...")
			EndIf

			Return

			*******************************

		Static Function PRetChar10

			Local cArq		:= cGetFile('','XML',1, 'C:\SIB\', .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE + GETF_RETDIRECTORY,.T., .T.)
			Local nHandle
			Local nPosIni	:= 0
			Local nPosFim	:= 0
			Local cConteudo	:= ''
			Local nAux 		:= 0
			Local nTot		:= 0
			Local cArq
			Local nCount	:= 0
			Local nX
			Local nAux2		:= 0
			Local nTmpHash 	:= 0
			Local cContHash	:= ''
			Local lComeÁa	:= .F.
			Local lHash		:= .F.
			Local cHash		:= ''
			Local cOldHash	:= ''

			Private aFiles
			Private aSizes

			nCount 	:= aDir(allTrim(cArq) + "*.xml", aFiles, aSizes)

			nI := 0

			MakeDir(cArq + '\CORRIGIDOS\' )

			For nX := 1 to nCount

				nTmpXml 	:= FCreate(cArq + '\CORRIGIDOS\' + aFiles[nX],0,,.F.)
				//nTmpHash 	:= FCreate(Replace(cArq + '\CORRIGIDOS\' + aFiles[nX],'.XML','.HASH'),0,,.F.)

				cContHash	:= ''

				nHandle 	:= FT_FUse(cArq + '\' + aFiles[nX])

				nTot		:= FT_FLASTREC()
				cTot		:= AllTrim(Transform(nTot,'@E 999,999,999'))
				nAux		:= 0
				nAux2++

				lComeÁa 	:= .F.
				lHash		:= .F.

				FT_FGOTOP()

				ProcRegua(nTot)

				While !FT_FEOF()

					IncProc('Processando linha ' + AllTrim(Transform(++nAux,'@E 999,999,999')) + ' de ' + cTot + ' [ ' + AllTrim(Transform(nAux2,'@E 999,999,999')) + ' de ' + AllTrim(Transform(nCount,'@E 999,999,999')) + ' ]')

					cLine := FT_FReadLn()

					If !lComeÁa .and. ( At('<ans:cabecalho>',cLine) > 0 )
						lComeÁa := .T.
					EndIf

					If !lHash .and. ( At('<ans:hash>',cLine) > 0 )
						lHash := .T.
					EndIf

					nPosIni	:= At('>',cLine)
					nPosFim	:= At('</',cLine)

					If lComeÁa .and. ( ( nPosIni > 0 ) .and. ( nPosFim > 0 ) )

						cConteudo := Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)

						If !lHash

							If ( At('<ans:codigoProcedimento>',cLine) > 0 )

								If ( len(AllTrim(cConteudo)) == 10 ) .and. ( Left(AllTrim(cConteudo),2) == '00' )
									cLine := Replace(cLine,cConteudo, Right(cConteudo,8))
									cContHash += Right(cConteudo,8)
								Else
									cContHash += Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
								EndIf

							Else
								cContHash += Substr(cLine,nPosIni + 1,nPosFim - nPosIni - 1)
							EndIf

						Else
							cOldHash := cConteudo
						EndIf

					EndIf

					If lHash
						lHash 	:= .F.
						cHash 	:= MD5(cContHash,2)
						cHash	:= Upper(cHash)
						cLine	:= Replace(cLine, cOldHash, cHash)
					EndIf

					FWrite(nTmpXml,cLine,len(cLine))

					FT_FSKIP()

				EndDo

				// Fecha o Arquivo
				FCLOSE(nHandle)
				FT_FUSE()

				FCLOSE(nTmpXml)
				FT_FUSE()

				FRename(cArq + '\CORRIGIDOS\' + aFiles[nX],Replace(Upper(cArq + '\CORRIGIDOS\' + aFiles[nX]),Upper(cOldHash),cHash))

			Next

			MsgInfo('Arquivos gerados')

			Return

			************************************************************************************************************************************

		Static Function lProtXML(c_RDA, c_XML)

			Local lProtOk	:= .F.
			Local aArea 	:= GetArea()
			Local cAlias	:= GetNextAlias()

			c_XML := AllTrim(Upper(c_XML))

			If ( c_RDA $ '139785|070416|136158|139718|136174|079693|032883|034479|141097|139785|070416' )
				//Rede D'or n„o precisa de protocolo
				lProtOk := .T.
			Else

				cQuery := "SELECT COUNT(*) QTD"					  																		+ cEnt
				cQuery += "FROM " + If(cEmpresa == 'CABERJ','ZRW010','ZRW020') + " ZRW"													+ cEnt
				cQuery += "INNER JOIN " + If(cEmpresa == 'CABERJ','ZZP010','ZZP020')  + " ZZP ON ZZP_FILIAL = '" + xFilial('ZZP') + "'" + cEnt
				cQuery += "		AND ZZP_IDOPER = ZRW_IDTOTA" 																			+ cEnt
				cQuery += "		AND ZZP_STATUS = 'CPR'" 																				+ cEnt
				cQuery += "		AND ZZP.D_E_L_E_T_ = ' '" 																				+ cEnt
				cQuery += "WHERE ZRW_FILIAL = '" + xFilial('ZRW') + "'" 																+ cEnt
				cQuery += "		AND UPPER(ZRW_XML) = '" + c_XML + "'" 																	+ cEnt
				cQuery += "		AND ZRW.D_E_L_E_T_ = ' '" 																				+ cEnt

				TcQuery cQuery New Alias cAlias

				lProtOk := ( cAlias->QTD > 0 )

				cAlias->(DbCloseArea())

			EndIf

			RestArea(aArea)

			Return lProtOk

			************************************************************************************************************************************

		Static Function cAnaResRDA(cRDA)

			Local aArea		:= GetArea()
			Local cAlAnRes 	:= GetNextAlias()
			Local cQuery	:= ''
			Local cRet		:= ''

			//Chumbado Caberj pois atualmente este controle eh feito somente na Caberj mas eh valido para Integral tambem. Combinado com Eloiza.
			cQuery := "SELECT ZN_CODANA,ZN_CODRDA" 									  								+ cEnt
			cQuery += "FROM SZN010 SZN" 																			+ cEnt
			cQuery += "INNER JOIN " + RetSqlName('BAU') + " BAU ON BAU.D_E_L_E_T_ = ' '" 							+ cEnt
			cQuery += "  AND BAU_FILIAL = '" + xFilial('BAU') + "'" 												+ cEnt
			cQuery += "  AND BAU_CODIGO = '" + cRDA + "'" 															+ cEnt
			cQuery += "WHERE SZN.D_E_L_E_T_ = ' '"	 																+ cEnt
			cQuery += "  AND ZN_FILIAL = '" + xFilial('SZN') + "'" 	 												+ cEnt
			cQuery += "  AND ZN_CODRDA = BAU_CODIGO"  																+ cEnt
			cQuery += "  AND ZN_ATIVO IN (' ','0')" 																+ cEnt

			//Leonardo Portella - 10/12/15 - Chamado ID: 11077 - Somente analista GEARI
			cQuery += "  AND ZN_TIPOAN = '1'"		 																+ cEnt

			cQuery += "  AND '" + DtoS(dDataBase) + "' >= ZN_VIGINI" 		   										+ cEnt
			cQuery += "  AND (ZN_VIGFIM = ' ' OR '" + DtoS(dDataBase) + "' <= ZN_VIGFIM)"						 	+ cEnt
			cQuery += "  AND ROWNUM = 1" 										  									+ cEnt
			cQuery += "ORDER BY ZN_CODRDA, ZN_CODANA DESC" 	 														+ cEnt

			TcQuery cQuery New Alias cAlAnRes

			If !cAlAnRes->(EOF())
				cRet := cAlAnRes->ZN_CODANA
			EndIf

			cAlAnRes->(DbCloseArea())

			RestArea(aArea)

			Return cRet

			************************************************************************************************************************************

			//Leonardo Portella - 26/01/17 - Chamado 34345

		User Function CargaBB0

			Local cPath 	:= cGetFile('','TXT',1, "\", .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_RETDIRECTORY+GETF_NETWORKDRIVE ,.T., .T.)
			Local cNomeArq	:= ''
			Local aArqDIR	:= {}
			Local cMascara	:= "??.txt"
			/*
			aDir(cPath + cMascara, aArqDIR)

			nQtdDir := len(aArqDIR)

			If nQtdDir == 0
				MsgStop('Nenhum arquivo TXT [ m·scara de pesquisa: ' + cMascara + ' ] localizado na pasta [ ' + cPath + ' ]', AllTrim(SM0->M0_NOMECOM))
			Else
				Processa({||PCargaBB0(cPath, aArqDIR)})
			EndIf
			*/
			ALERT('ROTINA DESCONTINUADA EM 08/02/2021. GETIN - GLPI 71926')
			ALERT('UTILIZAR A OP«√O << Importa arq. CRM do CFM >> NESTE MENU')

			Return

*************************************************************************************************************

		Static Function PCargaBB0(cPath, aArqDIR)

			Local nI 		:= 0
			Local cHorIni 	:= Time()
			Local cArqOri
			Local cArqDes
			Local cAlias 	:= GetNextAlias()
			Local aArea		:= GetArea()
			Local cHorIni	:= Time()
			Local cHorAux
			Local cMsg		:= ""

			ProcRegua(len(aArqDIR))

			cHorAux	:= Time()

			For nI := 1 to len(aArqDIR)

				IncProc('Copiando arquivos do CFM [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aArqDIR)) + ' ] ...')

				cArqOri := cPath + aArqDIR[nI]
				cArqDes := '\\srvdbp\backup\utl\SIB\' + Upper(Left(aArqDIR[nI],len(aArqDIR[nI]) - 4)) + '.txt'

				If !MoveFile(cArqOri,cArqDes,.F.)
					MsgStop("N„o foi possÌvel copiar o  arquivo  [ " + cArqOri + " ] para [ " + cArqDes + " ]","Atencao!")
					Return .F.
				EndIf

			Next

			cMsg += " - CÛpia dos arquivos: " + ElapTime(cHorAux, Time()) + cEnt

			ProcRegua(0)

			For nI := 1 to 5
				IncProc('Carregando arquivo CFM...')
			Next

			cHorAux := Time()

			aRetSP := TcSPExec("CARGA_BASE_CFM")

			cMsg += " - Procedure CARGA_BASE_CFM: " + ElapTime(cHorAux, Time()) + cEnt

			cQry := "SELECT COUNT(*) QTD" 	+ cEnt
			cQry += "FROM BASE_CFM" 		+ cEnt

			TcQuery cQry New Alias cAlias

			If cAlias->QTD == 0
				MsgStop("Erro ao executar a procedure CARGA_BASE_CFM [ sem registros ]")
				Return .F.
			Else
				LogErros(" - " + cValToChar(cAlias->QTD) + " registros inseridos na tabela BASE_CFM." + cEnt + cMsg,"CARGA_BASE_CFM",.T.,, 7500)
			EndIf

			cAlias->(DbCloseArea())

			cHorAux := Time()

			aRetSP := TcSPExec(	'CARGA_PROFISSIONAL_CFM' )

			cMsg += " - Procedure CARGA_PROFISSIONAL_CFM: " + ElapTime(cHorAux, Time()) + cEnt

			If Empty(aRetSP)
				MsgStop("Erro ao executar a procedure CARGA_PROFISSIONAL_CFM",AllTrim(SM0->M0_NOMECOM))
				Return .F.
			Else

				cMsg += cEnt + " - Tempo total: " + ElapTime(cHorIni, Time())
				cMsg := 'IncluÌdos Caberj: ' + cValToChar(aRetSP[1]) + ' registros, incluÌdos Integral: ' + cValToChar(aRetSP[2]) +  ' registros.' + cEnt + 'Obs: ' + Alltrim(aRetSP[3]) + cEnt + cMsg

				MsgAlert(cMsg, AllTrim(SM0->M0_NOMECOM))

			EndIf

			RestArea(aArea)

			Return

			************************************************************************************************************************************

			//Leonardo Portella - 29/03/17 - Carga de arquivos de retorno do Monitoramento ANS

		User Function CargaMonit

			Local cPath 	:= cGetFile('','XTR',1, "\", .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_RETDIRECTORY+GETF_NETWORKDRIVE ,.T., .T.)
			Local cNomeArq	:= ''
			Local aArqDIR	:= {}
			Local cMascara	:= Replicate('?',12) + ".XTR"

			aDir(cPath + cMascara, aArqDIR)

			nQtdDir := len(aArqDIR)

			If nQtdDir == 0
				MsgStop('Nenhum arquivo XTR [ m·scara de pesquisa: ' + cMascara + ' ] localizado na pasta [ ' + cPath + ' ]', AllTrim(SM0->M0_NOMECOM))
			Else
				Processa({||PCargaMon(cPath, aArqDIR)})
			EndIf

			Return

			*************************************************************************************************************

		Static Function PCargaMon(cPath, aArqDIR)

			Local nI 		:= 0
			Local cHorIni 	:= Time()
			Local cArqOri
			Local cArqDes
			Local cAlias 	:= GetNextAlias()
			Local aArea		:= GetArea()
			Local cHorIni	:= Time()
			Local cHorAux
			Local cMsg		:= ""

			ProcRegua(len(aArqDIR))

			cHorAux	:= Time()

			For nI := 1 to len(aArqDIR)

				IncProc('Copiando arquivos do Monitoramento [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aArqDIR)) + ' ] ...')

				cArqOri := cPath + aArqDIR[nI]
				cArqDes := '\\srvdbp\backup\utl\SIB\' + Upper(Left(aArqDIR[nI],len(aArqDIR[nI]) - 4)) + '.XTR'

				If !MoveFile(cArqOri,cArqDes,.F.)
					MsgStop("N„o foi possÌvel copiar o  arquivo  [ " + cArqOri + " ] para [ " + cArqDes + " ]","Atencao!")
					Return .F.
				EndIf

			Next

			cMsg += " - CÛpia dos arquivos: " + ElapTime(cHorAux, Time()) + cEnt

			aSort(aArqDIR,,,{|x,y| x < y})

			ProcRegua(0)

			For nI := 1 to 5
				IncProc('Carregando arquivos Monitoramento...')
			Next

			cHorAux := Time()

			For nI := 1 to len(aArqDIR)

				IncProc('Carregando arquivos do Monitoramento [ ' + cValToChar(nI) + ' de ' + cValToChar(len(aArqDIR)) + ' ] ...')

				cScript := "BEGIN"  													+ cEnt
				cScript += "  	CARGA_RETORNO_MONITORAMENTO('" + aArqDIR[nI] + "');"  	+ cEnt
				cScript += "  	COMMIT;"  												+ cEnt
				cScript += "END;"  														+ cEnt

				If TcSqlExec(cScript) < 0
					LogErros("Erro ao executar a procedure CARGA_RETORNO_MONITORAMENTO - Arquivo [ " + aArqDIR[nI] + " ]" + cEnt + cEnt + TcSQLError(),AllTrim(SM0->M0_NOMECOM))
					Return .F.
				EndIf

			Next

			cMsg += " - Procedure CARGA_RETORNO_MONITORAMENTO [ executada " + cValToChar(len(aArqDIR)) + " vezes ]: " + ElapTime(cHorAux, Time()) + cEnt

			cMsg += cEnt + " - Tempo total: " + ElapTime(cHorIni, Time())

			MsgAlert(cMsg, AllTrim(SM0->M0_NOMECOM))

			RestArea(aArea)

Return


*************************************************************************************************************

//************************************************
//FunÁ„o para criar arquivo BAT que ser· utilizado para descompactar os
//XMLs da Operativa.
//************************************************

		Static Function MontaBat(cZip,cPath , cExtracPath,c7Z,cNomArq)

			Local cConteudo := " "

			cNomArq := cPath+cNomArq+'.Bat'
			
			cConteudo :="@ECHO OFF"

			cConteudo +='::Declarando as vari·veis do cÛdigo '+' '+cEnt
			//cConteudo +='SET ARQ_7_ZIP=7za '+cEnt
			cConteudo +='SET ARQ_7_ZIP='+c7Z+' '+cEnt
			cConteudo +='SET ARQ_OP_P1='+cZip+' '+cEnt
			cConteudo +='SET ARQ_OP_P2='+cExtracPath+' '+cEnt

			//cConteudo +='SET LOG_P1=\\10.19.1.12\backup\utl\Log_Transferencia_FTP_OPERATIVA_
			//cConteudo +='SET PATH_P1='+cPath+' '+cEnt
			cConteudo +='SET PATH_P1='+cPath+cEnt
			cConteudo +='::ExecuÁ„o de TransferÍncia de Arquivos FTP OPERATIVA '+' '+cEnt

			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO "Descompactando Arquivo"'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			//cConteudo +='cd  %PATH_P1%   '+' '+cEnt
			//cConteudo +='dir   '+' '+cEnt
			//cConteudo +='%ARQ_7_ZIP% e %ARQ_OP_P1% -o%ARQ_OP_P2% -y '+' '+cEnt
			cConteudo +='%ARQ_7_ZIP% e %PATH_P1%%ARQ_OP_P1% -o%ARQ_OP_P2% -y '+' '+cEnt
			cConteudo +='ECHO "Descompactando para FTP Operativa"'+' '+cEnt

			//cConteudo +='copy %ARQ_OP_P1% %ARQ_OP_P2% /y '+' '+cEnt
			cConteudo +='copy %PATH_P1%%ARQ_OP_P1% %ARQ_OP_P2% /y '+' '+cEnt
			cConteudo +='ECHO "Copiando de FTP Operativa"'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO ##########################################################################'+' '+cEnt
			cConteudo +='ECHO "FIM"'+' '+cEnt

			MemoWrite( substr(cNomArq, at("Tiss",cNomArq)-1,len(cNomArq)) ,cConteudo )

			Return cNomArq

//******************************************************/
// Tela para abertura de log
//******************************************************/
		Static Function LogTiss(__cFileLog)

			Local  cTexto := ''
			Default  __cFileLog := ' '

			cTexto := "Log da atualizacao " + CHR(13) + CHR(10) + cTexto // //"Log da atualizacao "

			//__cFileLog := MemoWrite(Criatrab(,.f.) + ".LOG", cTexto)

			DEFINE FONT oFont NAME "Mono AS" SIZE 5,12
			DEFINE MSDIALOG oDlg TITLE " Log de Processa "  From 3,0 to 340,417 PIXEL // //"   FNC: "###"   ReferÍncia: "
			@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
			oMemo:bRClicked := {||AllwaysTrue()}
			oMemo:oFont:=oFont
			DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
			DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
			ACTIVATE MSDIALOG oDlg CENTER

			Return

//******************************************************/
// Excluir arquivos j· baixados do array de download .
//******************************************************/

Static Function ExcDupl(aVetFtp, aVetDir)

Local aRet 	:= {}
Local nX 	:= 0
Local nCont := 0 // Vari·vel que ser· utilizado para contador.

Default aVetFtp := {}
Default aVetDir := {}

		For nX := 1 to len(aVetFtp)
			conout(nX)
			if ascan(aVetDir,{|x|  alltrim(upper(SUBSTR(x,9,LEN(aVetFtp[nX][1])))) == aVetFtp[nX][1]   }) > 0
				aDel(aVetFtp,nX)
				nCont++
			endif

		Next nX

	// Redimensiona o Array de acordo com o que fora achado.
	aVetFtp := aSize(aVetFtp,len(aVetFtp)-nCont)

	// Clona o vetor redimensionado para a vari·vel que ser· utilizada como retorno.
	aRet :=  aClone(aVetFtp)

Return aRet
