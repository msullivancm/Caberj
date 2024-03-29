#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FuncITEM     �Autor  � Mauro Guerra    � Data �  30/07/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcoes genericas destinadas a contabilizacao do PLS.       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ITEMPLS(cArquivo)

Local cRet := ""
Local aArea := (cArquivo)->(GetArea())

IF ((cArquivo)->&(cArquivo+'_CODPLA')=='0010' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0014') .and. (cArquivo)->&(cArquivo+'_CODEMP')=='0007'
       cRet := '0010A'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0011' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0015') .and. (cArquivo)->&(cArquivo+'_CODEMP')=='0007'
       cRet := '0011A'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0012' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0016') .and. (cArquivo)->&(cArquivo+'_CODEMP')=='0007'
	   cRet := '0012A'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0013' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0017') .and. (cArquivo)->&(cArquivo+'_CODEMP')=='0007'
       cRet := '0013A'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA'))=='0022'
	   cRet := '0021'
ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0010' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0014') .and. (cArquivo)->&(cArquivo+'_CODEMP')<>'0007'
       cRet := '0010'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0011' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0015') .and. (cArquivo)->&(cArquivo+'_CODEMP')<>'0007'
       cRet := '0011'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0012' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0016') .and. (cArquivo)->&(cArquivo+'_CODEMP')<>'0007'
	   cRet := '0012'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA')=='0013' .or. (cArquivo)->&(cArquivo+'_CODPLA')=='0017') .and. (cArquivo)->&(cArquivo+'_CODEMP')<>'0007'
       cRet := '0013'
	ELSEIF ((cArquivo)->&(cArquivo+'_CODPLA'))=='0042'
	   cRet := '0001'
ELSE
	cRet := (cArquivo)->&(cArquivo+'_CODPLA')
ENDIF	

RestArea(aArea)

Return cRet