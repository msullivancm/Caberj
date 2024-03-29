#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABR225  � Autor � Altamiro Affonso   � Data �  10/11/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio CONFERENCIA DE vendedores por empresa            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CABR225

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de CONFERENCIA DE vendedor por empresa  "
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Conferencia de vendedor por empresa "
Local nLin           := 80 															
Local Cabec1         := "Empresa                                Contrato            SubContrato    Vend1     Vend2      qtda "
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13         14
//                       XXXX.XXXX.XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXX  XXXXXXXXX   XX  999.999.999,99 999.999.999,99  xx/xx/xxxx   XXXX      XX
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR255"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR255"
Private cString      := "SE2"
Private cPerg        := "CAB255    "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "
dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
                                
Private cEmp         := mv_par01 
//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

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
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  31/08/07   ���
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
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

SetRegua(RecCount())    
 
 cQuery := " select ba1_codemp ||' - '|| substr(bg9_descri,1,20) EMP  , ba1_conemp conemp , ba1_subcon subcon , ba1_codven codven , ba1_codve2 codve2  ,count(*) QTDA "
 cQuery += "  from " + RetSqlName("BA1")+" BA1, " + RetSqlName("BG9")+" BG9 "
 cQuery += " where ba1_filial = '"+xFilial("BA1")+"'  and bg9.d_E_L_E_T_ = ' ' "
 cQuery += "   and bg9_filial = '"+xFilial("BG9")+"'  and bg9.d_E_L_E_T_ = ' '	" 
 cQuery += "  and ba1_codemp = '"+cEmp+"'"
 cQuery += " and bg9_codigo = ba1_codemp "
 cQuery += " group by ba1_codemp ||' - '|| substr(bg9_descri,1,20) , ba1_conemp , ba1_subcon , ba1_codven , ba1_codve2 "
 cQuery += " order by ba1_codemp ||' - '|| substr(bg9_descri,1,20) , ba1_subcon , ba1_codven , ba1_codve2 "


 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
    Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())       
    
    While !EOF()                                                                
	  If nLin > 65 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
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

 cQuery := " select ba1_codemp ||' - '|| substr(bg9_descri,1,20) EMP  , ba1_conemp conemp , ba1_subcon subcon , ba1_codven codven , ba1_codve2 codve2  ,count(*) QTDA "

	 @ nLin,001 PSay  tmp->EMP
	 @ nLin,040 PSay  tmp->conemp
	 @ nLin,060 PSay  tmp->e1_subcon
	 @ nLin,075 PSay  tmp->codven  
	 @ nLin,085 PSay  tmp->codve2            
	 @ nLin,099 PSay  tmp->qtda            
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
    @ nLin,000 PSay replicate("_",220)  


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


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValidPerg � Autor � Jose Carlos Noronha� Data � 01/08/07    ���
�������������������������������������������������������������������������͹��
���Descricao � Parametros para selecao dos titulos do PLS                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ValidPerg()

cPerg := PADR(cPerg,6)    

PutSx1(cPerg,"01","Codigo da Empresa "  ,"","","mv_ch01","C",04,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )  

Return(.T.)


