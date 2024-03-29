#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABR116  � Autor � Altamiro Affonso   � Data �  10/11/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio Controle de processo por tema (sintetico)        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CABR271()

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "sintetico de processos por temas e status          "
Local cDesc3         := "                   "
Local cPict          := ""
Local titulo         := " Posi��o Sint�tica de processos por Temas e Status "
Local nLin           := 220															
Local Cabec1         := "  Tipo                        Temas                                                                                                                                                          Status                Qtda  "
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21         22
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR271"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private m_pag        := 01
Private wnrel        := "CABR271"
Private cString      := "PBW"
Private cPerg        := "CABR271   "

private ctema        := " "
private ctipo        := " "
private cstatus      := " "

Private nQdatipo     := 0 
Private nQdatema     := 0 
Private nQdastatu    := 0  
Private nQdatot      := 0 
/*dbSelectArea("PBW")
dbSetOrder(1)
*/
//ValidPerg(cPerg)
Pergunte(cPerg,.T.)
/*If Pergunte(cPerg,.T.) = .F.
	Return
Endif                       
*/   
Private dDatInc  := dtos(mv_par01)
Private dDatFim  := dtos(mv_par02)
*/
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
///   

cQuery  := " select pbw_tpacao TpAcao , pbw_tema Tema , pbw_status Status, count(*) Qtda" 
cQuery  += "   from " + RetSqlName('PBW') + " PBW "
cQuery  += "  where pbw_filial =  '"+xFilial('PBW')+ "' and d_E_L_E_T_ = ' ' "
cQuery  += "    and pbw_tema <> ' ' "
cQuery  += "    and pbw_dtrecb >= '"+dDatInc+"' and  pbw_dtrecb <= '"+dDatFim+"'"
cQuery  += "  group by pbw_tpacao , pbw_tema , pbw_status "

/*
Private dDatInc  := mv_par01
Private dDatFim  := mv_par02
*/

//////

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())    
 Endif
 TCQuery (cQuery) Alias "TMP" New 
 dbSelectArea("TMP")

 tmp->(dbGoTop())

    While !EOF()                                                                
  If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
	 nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
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
    If ctipo <> tmp->TpAcao
        @ nLin,001 PSay  tmp->TpAcao 
          nLin ++
          ctipo := tmp->TpAcao
          nQdatipo     := nQdatipo + tmp->Qtda
    EndIf       
    
    If ctema <> tmp->Tema
	    @ nLin,031 PSay  tmp->Tema
	      nLin ++
	      ctema :=  tmp->Tema
	      nQdatema := nQdatema + Qtda 
    EndIf 	      

 //   If cstatus <> tmp->Status	      
	    @ nLin,190 PSay  tmp->Status 
	      cstatus :=  tmp->Status
	      nQdatot := nQdatot + tmp->Qtda
        @ nLin,212 PSay  tmp->Qtda Picture "@E 99,999"
          nLin ++     // Avanca a linha de impressao
 //   EndIf       
	dbSkip()   // Avanca o ponteiro do registro no arquivo
  EndDo    
     nLin ++     // Avanca a linha de impressao
     nLin ++     // Avanca a linha de impressao
   @ nLin,200 PSay  'Total ' 
   @ nLin,212 PSay  nQdatot Picture "@E 99,999"
          

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

PutSx1(cPerg,"01","Data Inicial Recebimento ","","","mv_ch01","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
PutSx1(cPerg,"02","Data Final   Recebimento ","","","mv_ch02","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )

Return(.T.)


