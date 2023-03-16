#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออปฑฑ
ฑฑบPrograma  ณCARGAPRIMAVIDAบAutor  ณLeonardo Portella   บ Data ณ17/05/15 บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออนฑฑ
ฑฑบDesc.     ณRotina para gerar arquivo com beneficiarios para a Primavidaบฑฑ
ฑฑบ          ณInclui no arquivo a matricula odontologica e tambem a matri-บฑฑ
ฑฑบ          ณcula saude.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

******************************************************************************************************

Static cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure gera o arquivo de carga            
Static nFTP 	:= 2//1 Caberj - 2 Primavida 

******************************************************************************************************

User Function CargaPrimavida(aSchedule)

Local lSchedule := .F.

Default aSchedule 	:= {}

Processa({||execCarga(lSchedule)},'Processando...')

Return
        
*************************************************************************************************************************

Static Function execCarga(lSchedule)

Local i := 0
   
If !lSchedule
	ProcRegua(0)
	
	For i:= 1 to 5                                 
		Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando carga PRIMAVIDA...')
	Next
	
	exCarPrima()
EndIf

***********************************************************************************************************************

Static Function exCarPrima()
	
Local cErro 	:= ''
Local lOk		:= .T.
Local cQuery 	:= ''
Local cArq		:= cPath + 'PRIMAVIDA_INCLUSAO_CABERJ_20150526.csv'
	
cQuery := 'BEGIN '
cQuery += 'GERA_ARQUIVO_PRIMAVIDA(); '
cQuery += "END;"
/*
If TcSqlExec(cQuery) <> 0
	
	cErro := " - Erro na execu็ใo da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	lOk := .F.
	MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))

EndIf
*/
If lOk
    
	If !File(cArq)
		lOk := .F.
		cErro := &cDataHora + " - Arquivo de carga Primavida (" + cArq + ") nใo foi encontrado!"
	Else 
		aRet := UploadFTP(cArq)
					
		If !aRet[1]
			lOk		:= .F.
			cErro 	:= aRet[2]
			MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
		Else
			MsgInfo('Upload realizado!!!',AllTrim(SM0->M0_NOMECOM))
		EndIf   
	EndIf
	
EndIf

Return

***********************************************************************************************************************

Static Function UploadFTP(cArq)

Local nI := 0

Local lRet 		:= .T.
Local cLog		:= "" 
Local cServidor := "ftp.medlinksaude.com.br"
Local nPorta	:= 21
Local cLogin	:= "caberj"
Local c_Senha	:= "caberj@medlink"
Local cPastaDes	:= ''
Local cNomeArq	:= Right(cArq,len(cArq) - Rat('\',cArq))

nOpca := Aviso('FTP:','Escolha o FTP',{'Medlink','Caberj','BEM'})

cServidor 	:= "ftp.medlinksaude.com.br"
nPorta		:= 21
cLogin		:= "caberj"
c_Senha		:= "caberj@medlink"

If nOpca == 1
	cServidor 	:= "ftp.medlinksaude.com.br"
	nPorta		:= 21
	cLogin		:= "caberj"
	c_Senha		:= "caberj@medlink"
	cPastaDes	:= "\TESTE\" //Pasta destino do arquivo no FTP  
ElseIf nOpca == 2
	cServidor 	:= "10.19.1.62"
	nPorta		:= 21
	cLogin		:= "envio.operativa@caberj.com.br"
	c_Senha		:= "sistemasoperativa."
	cPastaDes	:= "\carga\" //Pasta destino do arquivo no FTP
ElseIf nOpca == 3
	Return {.F., 'FTP nใo informado'}
EndIf

//Precisa estar abaixo do RootPath
MoveFile(cArq,"\" + cNomeArq, .F.)

FTPDISCONNECT()

lConnect := FTPCONNECT(cServidor,nPorta,cLogin,c_Senha)

If !lConnect

	nTent := 0

	FTPDISCONNECT()

	While nTent <= 5 .and. !lConnect

	    sleep(1000)
		nTent++
		lConnect := FTPCONNECT(cServidor,nPorta,cLogin,c_Senha)

	EndDo

	If !lConnect

		lRet := .F.
		cLog := "Nใo foi possํvel conectar ao servidor FTP..."

	EndIf

EndIf


If lRet

	//FTPGETCURDIR

	If nFTP == 1 
	        
		QOut('Caberj - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')
			
		aPasta 		:= Separa(cPastaDes,'\',.F.) 
		cNovoCam	:= ''
		
		For nI := 1 to len(aPasta)

			cNovoCam += '/' + aPasta[nI]

			If !FTPDirChange(cNovoCam)
				lRet 	:= .F.
				cLog 	:= 'Nใo foi possํvel mudar para o diretorio [ ' + cNovoCam + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] - Diret๓rio destino [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
				exit
			EndIf

		Next

		If lRet 
			
			aInfoFTP 	:= FTPDirectory("*.csv")
        
			If len(aInfoFTP) == 0
				QOut('Operativa - Nenhum arquivo a ser deletado no FTP [ ' + cServidor + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')		
			Else
				//Operativa - Deleto todos os arquivos
				For nI := 1 to len(aInfoFTP)
					FTPERASE(cPastaDes + aInfoFTP[nI][1])
					QOut('Operativa - Arquivo deletado: ' + aInfoFTP[nI][1] + ' [ ' + cServidor + ' ]')
			  	Next
			EndIf
		EndIf
	
	ElseIf nFTP == 2
	        
		QOut('Primavida - Diretorio atual [ ' + FtpGetCurDir() + ' ] ')
			
		aPasta 		:= Separa(cPastaDes,'\',.F.) 
		cNovoCam	:= ''
		
		For nI := 1 to len(aPasta)

			cNovoCam += '/' + aPasta[nI]

			If !FTPDirChange(cNovoCam)
				lRet 	:= .F.
				cLog 	:= 'Nใo foi possํvel mudar para o diretorio [ ' + cNovoCam + ' ] - Diretorio atual [ ' + FtpGetCurDir() + ' ] - Diret๓rio destino [ ' + cPastaBus + ' ] [ ' + cEmpresa + ' ]'
				exit
			EndIf

		Next

		If lRet 
			FTPERASE(cPastaDes + cNomeArq)//Apago o arquivo de mesmo nome, caso exista (2 cargas geradas no mesmo dia, mantenho a segunda)
		EndIf
	
	Endif
EndIf

If lRet .and. !FTPUPLOAD("\" + cNomeArq, cNomeArq)
	lRet := .F.
	cLog := "Nใo foi possํvel realizar o upload..."	
EndIf

FTPDISCONNECT()

FErase("\" + cNomeArq)

Return {lRet, cLog}

******************************************************************************************************************
******************************************************************************************************************
******************************************************************************************************************

//Carrega o arquivo da Primavida na tabela Oracle PRIMAVIDA_VELHA para comparacao com a tabela Oracle PRIMAVIDA_NOVA
//Ocorreu na geracao erro no programa de carga inicial. Se eu comparar os dados da base com os dados atuais nao
//saberei o que foi alterado pois o erro era no programa gerador de matriculas e a base ja foi corrigida.

User Function CompPrima()

Local nOpca 	:= GETF_LOCALHARD + GETF_NETWORKDRIVE
Local cArq 		:= cGetFile('Arquivo CSV | *.CSV','Arquivo CSV', 1,'C:\',.T.,nOpca)   

If !empty(cArq)
	Processa({||PCargaPrimavida(cArq)},'Carga Primavida','Processando...',.F.)
Else
	MsgStop('Informe um arquivo!',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************

Static Function PCargaPrimavida(cArqPrima)

Local cLine		:= ''
Local aLine		:= {}
Local nQtd 		:= 0
Local nI		:= 0
Local nHandle 	:= FT_FUse(cArqPrima)
Local aCabec	:= {}
Local cFimIns	:= ''
Local cErro		:= ''
Local cIniIns	:= ''
Local aUpd		:= {}
Local cMsg		:= ''

cMsg := 'Esta rotina irแ carregar o arquivo da Primavida na tabela Oracle PRIMAVIDA_VELHA' 							+ CRLF 
cMsg += 'para comparacao com a tabela Oracle PRIMAVIDA_NOVA' 														+ CRLF
cMsg += '- A tabela PRIMAVIDA_VELHA terแ todos os seus registros deletados e depois incluํdos conforme a carga!' 	+ CRLF
cMsg += '---> Confirma a execu็ใo da carga?' 

If MsgYesNo(cMsg,AllTrim(SM0->M0_NOMECOM))
	
	FT_FGoTop()
	
	nQtd := FT_FLastRec()
	cTot := AllTrim(Transform(nQtd, "@E 999,999,999"))
	
	ProcRegua(nQtd)
	
	nQtd := 0
	FT_FGoTop()
	
	If TcSqlExec('DELETE FROM PRIMAVIDA_VELHA') <> 0
		
		cErro := "- Erro na execu็ใo do delete" + CRLF + 'TcSqlError [ ' + TcSqlError() + ' ]'
		MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
		
	Else
	
		While !FT_FEOF()
		
			IncProc('Linha: ' + AllTrim(Transform(++nQtd, "@E 999,999,999")) + ' de ' + cTot)
			
		  	cLine := FT_FReadLn() // Retorna a linha corrente
		  	
		  	If nQtd == 1 //Cabecalho
		  	
		  		aCabec := Separa(cLine,';',.T.)
		  		
		  		cIniIns := "INSERT INTO PRIMAVIDA_VELHA ("
		  		For nI := 1 to len(aCabec)
		  			cIniIns += aCabec[nI] + ','
		  		Next
		  		
		  		cIniIns := Left(cIniIns,Len(cIniIns) - 1)
		  		cIniIns += ") VALUES (" 
		  		
		  	Else
		  	
		  		aLine := Separa(cLine,';',.T.)
		  		
		  		If len(aLine) > 0
		  		
		  			cFimIns := ''
		  			
			  		For nI := 1 to len(aLine)
			  			cFimIns += "'" + Replace(aLine[nI],'#','') + "',"
			  		Next
			  		
			  		cFimIns := Left(cFimIns,Len(cFimIns) - 1)
			  		cFimIns += ')'
			  		
			  		If TcSqlExec(cIniIns + cFimIns) <> 0
			
						cErro := "- Erro na execu็ใo da instru็ใo:" + CRLF + Space(3) + cIniIns + cFimIns + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
						MsgStop(cErro,AllTrim(SM0->M0_NOMECOM))
						Exit
			  		EndIf
			  		
			  	EndIf
		
		  	EndIf
		  	
			FT_FSKIP()
		  	
		EndDo 
		
	EndIf
	
	// Fecha o Arquivo
	FCLOSE(nHandle)
	FT_FUSE() 
	
	MsgAlert('Carga finalizada!',AllTrim(SM0->M0_NOMECOM))
	
Else
	MsgAlert('Opera็ใo cancelada',AllTrim(SM0->M0_NOMECOM))
EndIf

Return

******************************************************************************************************************
