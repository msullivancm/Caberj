#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

#DEFINE cEnt chr(10)+chr(13)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELSLA   �Autor  � HUGO PAIVA PEDROSA   � Data � 08/11/2017  ���
�������������������������������������������������������������������������͹��
���Desc.     � Impress�o de cadastro de produtos em TReport simples.      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AcademiaERP                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
user function RELSLA()
    //������������������������������������������Ŀ
    //�Declaracao de variaveis                   �
    //��������������������������������������������
    Private oReport  := Nil
    Private oSection := Nil
    Private  nRegs	 := 0
    Private oBreak
 
    //������������������������������������������Ŀ
    //�Definicoes/preparacao para impressao      �
    //��������������������������������������������
    ReportDef()
    oReport:PrintDialog()
    
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELSLA   �Autor  � HUGO PAIVA PEDROSA   � Data � 08/11/2017  ���
�������������������������������������������������������������������������͹��
���Desc.     � Defini��o da estrutura do relat�rio.                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()
    
    // cPerg - n�o estava declado. 
    oReport := TReport():New("RELSLA","SLA CALLCENTER",/*cPerg*/,{|oReport| PrintReport(oReport)},"SLA CALLCENTER")
    //oReport:SetLandscape(.T.)
    
    oSection := TRSection():New( oReport , "Titulares e Dependentes", {"QRY"} )
    // campos da pcs n�o encontrados no dicion�rio pela fun��o PesqPict
    TRCell():New(oSection ,'DEMANDA'			,"QRY",'DEMANDA'			,/*PesqPict("PCG", "PCG_CDDEMA" )*//*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'DESC_DEMANDA'		,"QRY",'DESC_DEMANDA'		,PesqPict("SX5", "X5_DESCRI" )/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'PORTA_ENTRADA'		,"QRY",'DESC_PORTA_ENTRADA'	,/*PesqPict("PCG", "PGC_CDPORT" )*//*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'DESC_PORTA_ENTRADA'	,"QRY",'DESC_PORTA_ENTRADA'	,PesqPict("PCA", "PCA_DESCRI" )/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'CANAL'				,"QRY",'CANAL'				,/*PesqPict("PCG", "PCG_CDCANA")*//*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'DESC_CANAL'			,"QRY",'DESC_CANAL'			,PesqPict("PCB", "PCB_DESCRI" )/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'TIPO_SERVICO' 		,"QRY",'TIPO_SERVICO'		,/*PesqPict("PCG", "PCG_CDSERV" )*//*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'DESC_TIPO_SERVICO' 	,"QRY",'DESC_TIPO_SERVICO'	,PesqPict("PBL", "PBL_YDSSRV" )/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'SLA' 				,"QRY",'SLA'				,/*PesqPict("PCG", "PCG_QTDSLA" )*//*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELSLA   �Autor  � HUGO PAIVA PEDROSA   � Data � 08/11/2017  ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintReport(oReport)
    
    Local cQuery     := ""
    
    cQuery += "SELECT PCG.PCG_CDDEMA DEMANDA,SX5.X5_DESCRI DESC_DEMANDA,PCG.PCG_CDPORT PORTA_ENTRADA,   		" + cEnt
    cQuery += "PCA.PCA_DESCRI DESC_PORTA_ENTRADA, PCG.PCG_CDCANA CANAL, PCB.PCB_DESCRI DESC_CANAL,  		    " + cEnt 
    cQuery += "PCG.PCG_CDSERV TIPO_SERVICO, PBL.PBL_YDSSRV DESC_TIPO_SERVICO,PCG.PCG_QTDSLA SLA     		    " + cEnt
    cQuery += " FROM 																							" + cEnt
    cQuery += " "+RetSqlName("PCG")+" PCG,  SX5010 SX5,    "+RetSqlName("PCA")+" PCA,    "+RetSqlName("PCB")+" PCB,    "+RetSqlName("PBL")+" PBL " + cEnt
    cQuery += " WHERE 																							" + cEnt
    cQuery += " PCG.D_E_L_E_T_ = ' ' AND SX5.D_E_L_E_T_ = ' ' AND PCA.D_E_L_E_T_ = ' ' AND PCB.D_E_L_E_T_ = ' ' " + cEnt
    cQuery += " AND PBL.D_E_L_E_T_ = ' '  AND SX5.X5_TABELA  = 'ZT'  AND PCG.PCG_CDDEMA = SX5.X5_CHAVE 			" + cEnt
    cQuery += " AND PCG.PCG_CDPORT = PCA.PCA_COD  AND PCG.PCG_CDCANA = PCB.PCB_COD  							" + cEnt
    cQuery += " AND PCG.PCG_CDSERV = PBL.PBL_YCDSRV																" + cEnt
        
    cQuery := ChangeQuery(cQuery)
    
    TcQuery cQuery New Alias "QRY"
    QRY->(dbGoTop())
    QRY->(dbEval({||nRegs++},,{|| QRY->(!Eof())}))
    QRY->(dbGoTop())
    
    oReport:SetMeter(nRegs) // Regua de Progresso
    
    //inicializo a primeira se��o
    oSection:Init()
    
    //realiza a impress�o da se��o
    Do While QRY->(!Eof())
        
        oReport:IncMeter() // incrementa regua de processamento
               
        //imprime linha da se��o 1
        oSection:Printline()
        
        QRY->(dbskip())
    
    EndDo
        
    If Select("QRY") > 0
        Dbselectarea("QRY")
        QRY->(DbClosearea())
    EndIf
    
    //finalizo a segunda se��o para que seja reiniciada para o proximo registro
    oSection:Finish()
    
Return Nil