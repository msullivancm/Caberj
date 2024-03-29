#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#DEFINE   c_ent      CHR(13)+CHR(10)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABRSIP  � Autor � Vitor Sbano        � Data �  07/02/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Relat�rio Resumo SIP                                       ���
���          �                                                            ���
���          �                                                            ���
���          �                                                            ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SIGAPLS - Relatorios - SIP                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABRSIP


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "RESUMO SIP"
Local cPict        := ""
Local titulo       := "CABERJ - SIP "
Local nLin         := 80

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private CbTxt      := ""
Private limite     := 220
Private tamanho    := "G"

Private nomeprog   := "CABRSIP" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo      := 15
Private aReturn    := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}

Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private TMPQRY       :=  ""
private aEmpresa := {}
cPerg := "CABRSIP1"

//Putsx1(cPerg,"01","Trimestre"        , "", "", "MV_CH1", "C",2,0,0,"G","","","","","MV_PAR01")
//Putsx1(cPerg,"02","Ano"              , "", "", "MV_CH2", "C",4,0,0,"G","","","","","MV_PAR02")

Putsx1(cPerg,"01","Trimestre"        , "", "", "MV_CH1", "N",1,0,0,"G","","","","","MV_PAR01")
Putsx1(cPerg,"02","Ano"              , "", "", "MV_CH2", "N",4,0,0,"G","","","","","MV_PAR02")
Putsx1(cPerg,"03","Quebrar por UF ?" , "", "", "MV_CH3", "N",1,0,0,"C","","","","","MV_PAR03","1-Sim"            ,"","","","2-N�o"            ,"","")
//
If !Pergunte(cPerg,.T.)
	Return
EndIf

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint("",NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,"")

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  07/02/13   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local n_col1 := 1
Local n_col2 := 11
Local cChavSet := ""
Local nCont    := 0

aEmp :=LoadEMP() // Carrega Empresa e filial
xPos := Ascan(aEmp,{|x| x[1] == cEmpAnt+cFilAnt}) // pesquisa Empresa e filial carregadas
cCodFil  := aEmp[xPos,2]// Recebe Codigo da filial.
cNomeFil := aEmp[xPos,3]// Recebe Nome da filial.
//	--EVENTOS SIP

//Putsx1(cPerg,"01","Trimestre"        , "", "", "MV_CH1", "N",1,0,0,"G","","","","","MV_PAR01")
//Putsx1(cPerg,"02","Ano"              , "", "", "MV_CH2", "N",4,0,0,"G","","","","","MV_PAR02")


_cPERIOD	:= strzero(MV_PAR02,4)+strzero(MV_PAR01,2)
//
If MV_PAR03 == 1		&& Quebrar por UF
	//
	
	c_query := ""
	c_query += "select distinct ITEM, DESCRICAO, UF, SUM(QTD_EVENTOS) QTD_EVENTOS, SUM(DESPESA) DESPESA , SUM(EXPOSTOS) EXPOSTOS FROM ( "+c_ent
	c_query += "SELECT BZZ_ITEM ITEM, "+c_ent
	c_query += "        BF0_DESCRI DESCRICAO,"+c_ent 
	c_query += "        BZZ_UF UF,"+c_ent 
	c_query += "        SUM(BZZ_EVENTO) QTD_EVENTOS,"+c_ent 
	c_query += "        SUM(CASE "+c_ent
	c_query += "              WHEN TRIM(BZZ_ITEM) IN ('A', 'A1', 'A2', 'B', 'C', 'D', 'E', 'H','I','I1','I3','I7','I10','I11') THEN "+c_ent
	c_query += "               BZZ_TOTAL "+c_ent
	c_query += "              ELSE "+c_ent
	c_query += "               0 "+c_ent
	c_query += "            END) AS DESPESA,          0 EXPOSTOS "+c_ent
	c_query += "   FROM "+RetSQLName("BZZ")+" BZZ,"+RetSQLName("BF0")+" BF0 WHERE BZZ_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_GRUGEN = '0001'"+c_ent
	c_query += "    AND BF0_CODIGO = BZZ_ITEM"+c_ent
	c_query += "    AND BZZ.D_E_L_E_T_ = ' ' "+c_ent
	c_query += "    AND BF0.D_E_L_E_T_ = ' ' "+c_ent 
	c_query += "    AND BZZ_UF <> 'FC' "+c_ent
	c_query += "    AND BZZ_PERIOD = '"+_cPERIOD+"' "+c_ent
	c_query += " GROUP BY BZZ_ITEM, BF0_DESCRI, BZZ_UF "+c_ent 
	c_query += " UNION ALL "+c_ent
	c_query += " SELECT BZZ_ITEM ITEM, "+c_ent
	c_query += "        BF0_DESCRI DESCRICAO, "+c_ent
	c_query += "        BZZ_UF UF,"+c_ent 
	c_query += "        SUM(BZZ_EVENTO) QTD_EVENTOS, "+c_ent
	c_query += "        0 DESPESA, "+c_ent
	c_query += "        SUM(BZZ_BENEFI) AS EXPOSTOS "+c_ent
	c_query += "   FROM "+RetSQLName("BZZ")+" BZZ,"+RetSQLName("BF0")+" BF0 WHERE BZZ_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_GRUGEN = '0001' "+c_ent
	c_query += "    AND BF0_CODIGO = BZZ_ITEM "+c_ent
	c_query += "    AND BZZ.D_E_L_E_T_ = ' ' "+c_ent
	c_query += "    AND BF0.D_E_L_E_T_ = ' ' "+c_ent 
	c_query += "    AND BZZ_UF = 'FC' "+c_ent
	c_query += "    AND BZZ_PERIOD = '"+_cPERIOD+"' "+c_ent
	c_query += " group by bzz_item, bf0_descri, BZZ_UF "+c_ent
	c_query += " ) QRY group by ITEM, DESCRICAO, UF ORDER BY  ITEM, UF"+c_ent
	//
Else					&& N�o quebrar
	//
	c_query := ""
	c_query += "select distinct ITEM, DESCRICAO, SUM(QTD_EVENTOS) QTD_EVENTOS, SUM(DESPESA) DESPESA , SUM(EXPOSTOS) EXPOSTOS FROM ( "+c_ent
	c_query += "SELECT BZZ_ITEM ITEM, "+c_ent
	c_query += "        BF0_DESCRI DESCRICAO,"+c_ent 
	c_query += "        SUM(BZZ_EVENTO) QTD_EVENTOS,"+c_ent 
	c_query += "        SUM(CASE "+c_ent
	c_query += "              WHEN TRIM(BZZ_ITEM) IN ('A', 'A1', 'A2', 'B', 'C', 'D', 'E', 'H','I','I1','I3','I7','I10','I11') THEN "+c_ent
	c_query += "               BZZ_TOTAL "+c_ent
	c_query += "              ELSE "+c_ent
	c_query += "               0 "+c_ent
	c_query += "            END) AS DESPESA,          0 EXPOSTOS "+c_ent
	c_query += "   FROM "+RetSQLName("BZZ")+" BZZ,"+RetSQLName("BF0")+" BF0 WHERE BZZ_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_GRUGEN = '0001'"+c_ent
	c_query += "    AND BF0_CODIGO = BZZ_ITEM"+c_ent
	c_query += "    AND BZZ.D_E_L_E_T_ = ' ' "+c_ent
	c_query += "    AND BF0.D_E_L_E_T_ = ' ' "+c_ent 
	c_query += "    AND BZZ_UF <> 'FC' "+c_ent
	c_query += "    AND BZZ_PERIOD = '"+_cPERIOD+"' "+c_ent
	c_query += " GROUP BY BZZ_ITEM, BF0_DESCRI"+c_ent 
	c_query += " UNION ALL "+c_ent
	c_query += " SELECT BZZ_ITEM ITEM, "+c_ent
	c_query += "        BF0_DESCRI DESCRICAO, "+c_ent
	c_query += "        SUM(BZZ_EVENTO) QTD_EVENTOS, "+c_ent
	c_query += "        0 DESPESA, "+c_ent
	c_query += "        SUM(BZZ_BENEFI) AS EXPOSTOS "+c_ent
	c_query += "   FROM "+RetSQLName("BZZ")+" BZZ,"+RetSQLName("BF0")+" BF0 WHERE BZZ_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_FILIAL = '  ' "+c_ent
	c_query += "    AND BF0_GRUGEN = '0001' "+c_ent
	c_query += "    AND BF0_CODIGO = BZZ_ITEM "+c_ent
	c_query += "    AND BZZ.D_E_L_E_T_ = ' ' "+c_ent
	c_query += "    AND BF0.D_E_L_E_T_ = ' ' "+c_ent 
	c_query += "    AND BZZ_UF = 'FC' "+c_ent
	c_query += "    AND BZZ_PERIOD = '"+_cPERIOD+"' "+c_ent
	c_query += " group by bzz_item, bf0_descri "+c_ent
	c_query += " ) QRY group by ITEM, DESCRICAO ORDER BY  ITEM"+c_ent
	//
Endif	
//
memowrite("C:\TEMP\CABRSIP.txt",c_query) 
//
If Select("TMPQRY")>0
	DbSelectArea("TMPQRY")
	TMPQRY->(DbCloseArea())
EndIf

TcQuery c_query New Alias "TMPQRY"

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������
//
titulo	:= titulo+" - Trimestre: "+substr(_cPERIOD,5,2)+"/"+substr(_cPERIOD,1,4)
If MV_PAR03 == 1	
	//                                                           45
	Cabec1       := " ITEM  ASSISTENCIAL                             UF                EVENTOS                       BENEFICIARIOS                    TOTAL DESPESA"
	Cabec2       := "                                                                 OCORRIDOS                       (EXPOSTOS)                         LIQUIDA"
	//
Else
	//
	Cabec1       := " ITEM     ASSISTENCIAL                                            EVENTOS                       BENEFICIARIOS                    TOTAL DESPESA"
	Cabec2       := "                                                                 OCORRIDOS                       (EXPOSTOS)                         LIQUIDA"
	//
Endif
//
SetRegua(RecCount())

While TMPQRY->(!EOF())
	
	//���������������������������������������������������������������������Ŀ
	//� Verifica o cancelamento pelo usuario...                             �
	//�����������������������������������������������������������������������
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//���������������������������������������������������������������������Ŀ
	//� Impressao do cabecalho do relatorio. . .                            �
	//�����������������������������������������������������������������������
	
	If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
		//
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif
	//	
	@nLin,n_col1+2     PSAY TMPQRY->ITEM
	@nLin,n_col1+10    PSAY TMPQRY->DESCRICAO
	If MV_PAR03 == 1
		@nLin,n_col1+47  PSAY TMPQRY->UF
	Endif
	@nLin,n_col1+60    PSAY transform(TMPQRY->QTD_EVENTOS,"@E 999,999,999")
	@nLin,n_col1+90    PSAY transform(TMPQRY->EXPOSTOS,"@E 999,999,999")
	@nLin,n_col1+125   PSAY transform(TMPQRY->DESPESA,"@E 999,999,999.99")
	nLin++
	@nLin,n_col1     PSAY __PrtThinLine()
	nLin++
	//			
	TMPQRY->(dbSkip())
EndDo

//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DTPR004   �Autor  �Flavio Bezerra      � Data �  08/06/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �   Carrega empresa em um vetor para consultas               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � DATAPREV                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static function LoadEMP()

Local nRecno := SM0->(Recno())
DbSelectarea("SM0")
DBGOTOP()
While SM0->(!Eof())
	
	Aadd(aEmpresa ,{SM0->M0_CODIGO+SM0->M0_CODFIL,SM0->M0_FILIAL,SM0->M0_NOME,SM0->M0_NOMECOM})
	
	DbSkip()
EndDo

DbGoto(nRecno)
Return aEmpresa
