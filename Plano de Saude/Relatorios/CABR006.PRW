#include "rwmake.ch"  
#include "TOPCONN.CH"
/*/
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Fun��o    � CABR006  � Autor � LUZIO TAVARES          � Data � 14.05.2008 ���
����������������������������������������������������������������������������Ĵ��
���Descri��o � Guia Medico                                                   |��
����������������������������������������������������������������������������Ĵ��
���Uso       � Especifico - GERC                                             ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
/*/
User Function CABR006()

//������������������������������������������������������������������������������������Ŀ
//� Inicializa variaveis                                                               �
//��������������������������������������������������������������������������������������
Private cbcont,cbtxt
Cusur := PlretOpe() // armazena na vari�vel o usu�rio do sistema
cString  := "SCP"
cDesc1   := "Emiss�o de Guia M�dico..."
cDesc2   := ""
cDesc3   := "Usu�rio Ativo: ("+Alltrim(Cusur)+")"
limite   := 220
tamanho  := "G"
aReturn  := { "Zebrado", 1,"Setor: Credenciamento", 1, 2, 1, "",1 }
aLinha   := {}
nLastKey := 0                         
titulo   := "Guia M�dico - CABR006"
cabec1   := ""
cabec2   := ""
cbcont   := 0
cbtxt    := Space(12)
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1                                    // numero da pagina
nomeprog := "("+Alltrim(Cusur)+")"
wnrel    := "CABR006"
cPerg    := "CABR06"
pag      := 1
li       := 80
cRdaCod  :=""  
/*
cCred    :=0
cDeb     :=0 
cCredT   :=0
cDebT    :=0  
cCredL   :=0
cDebL    :=0
cBase    :=0
cLiq     :=0  
cTipcon  :=0 
cValor   :=0
*/

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)

//������������������������������������������������������������������������������������Ŀ
//� Chamada padrao de relatorios                                                       �
//��������������������������������������������������������������������������������������
wnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,tamanho,"",.T.)
If  nLastKey == 27
	Set Filter To
	Return
End
SetDefault(aReturn,cString)
If  nLastKey == 27
	Set Filter To
	Return
End
//������������������������������������������������������������������������������������Ŀ
//� Processa relatorio                                                                 �
//��������������������������������������������������������������������������������������
Processa({|| CABRIMP() }, "Processando Informa��es...", "", .T.)
//������������������������������������������������������������������������������������Ŀ
//� Libera spool                                                                       �
//��������������������������������������������������������������������������������������
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool
//������������������������������������������������������������������������������������Ŀ
//� Fim do programa                                                                    �
//��������������������������������������������������������������������������������������
Return

/*/
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Fun��o    � CABRIMP                                                       ���
����������������������������������������������������������������������������Ĵ��
���Descri��o � Processa relatorio                                            |��
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
/*/

Static Function CABRIMP()
Local nTotal:= 0 // recebe o n total de registros
Local nProc:=1 // incrementado por unidade de registro
Local Npercent := 0 // percentual na barra de evolucao
Local Tipo := Mv_Par01

//������������������������������������������������������������������������������������Ŀ
//� Monta query                                                                        �
//�������������������������������������������������������������������������������������� 

cSQL := " SELECT BAQ_DESCRI Especialidade, bau_codigo, decode(BAU_NOMGUI,1,BAU_NOME ,2, BAU_NREDUZ,3,BAU_NFANTA) Medico, bb8_datblo,"+;
       	" decode(BB8_GUIMED,1,BB8_END) Endereco,decode(BB8_GUIMED,1,BB8_BAIRRO) Bairro,decode(BB8_GUIMED,1,BB8_MUN) Municipio,"+;
       	" decode(BB8_GUIMED,1,BB8_EST) UF, decode(BB8_GUIMED,1,BB8_CEP) CEP,decode(BB8_GUIMED,1,BB8_NR_END) Numero,"+;
       	" decode(BB8_GUIMED,1,BB8_TEL) Telefone, decode(BB8_GUIMED,1,BB8_COMEND) Complemento, decode(BB8_GUIMED,0,' ') Guia,BAU_TIPPRE,baw_codint,baw_codant,baw_digcod"+;
       	" FROM BAX010,BB8010,BAW010,BAU010,BAQ010,BID010"+;
       	" WHERE BAU_FILIAL = ' '"+;
       	" AND   BB8_FILIAL = ' '"+;
       	" AND   BAX_FILIAL = ' '"+;
       	" AND   BAW_FILIAL = ' '"+;
       	" AND   BAQ_FILIAL = ' '"+;
       	" AND   BID_FILIAL = ' '"+;
       	" AND   BAW010.D_E_L_E_T_ = ' '"+;
       	" AND   BAX010.D_E_L_E_T_ = ' '"+;
       	" AND   BB8010.D_E_L_E_T_ = ' '"+; 
       	" AND   BAU010.D_E_L_E_T_ = ' '"+;
       	" AND   BAQ010.D_E_L_E_T_ = ' '"+;
       	" AND   BID010.D_E_L_E_T_ = ' '"+;
       	" AND   (BB8_CODMUN = BID_CODMUN)"+;
       	" AND   (BAQ_CODESP = BAX_CODESP)"+;
       	" AND   BAU_CODIGO = BB8_CODIGO"+;
       	" AND   BB8_CODIGO||BB8_CODLOC = BAX_CODIGO||BAX_CODLOC"+;
       	" AND   BAU_CODIGO = BAW_CODIGO"+;
       	" AND   BAW_CODINT = '"+PLSIntPad()+"'"+;
       	" AND   (BB8_GUIMED = '1' AND BAX_GUIMED = '1')"+;
       	" AND   BAU_DATBLO = ' '"+;
       	" AND   BB8_DATBLO = ' '"+;      //       	" AND   BAU_TIPPRE in ("+Tipo+")"+; // parametro
       	" ORDER BY BAQ_DESCRI,BAU_NOME"
PLSQuery(cSQL,"CONS")

//������������������������������������������������������������������������������������Ŀ
//� Monta regua                                                                        �
//��������������������������������������������������������������������������������������
CONS->(DBEval( { | | nTotal++ }))
CONS-> ( DbGotop()) 
ProcRegua(nTotal)
//������������������������������������������������������������������������������������Ŀ
//� Imprime relatorio                                                                  �
//��������������������������������������������������������������������������������������
While ! CONS->(eof())
   //���������������������������������������������������������������������������������Ŀ
   //� Imprime cabecalho                                                               �
   //�����������������������������������������������������������������������������������
   If  li >= 58
       li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
   EndIf                                                        
   If cCodEsp <> CONS->Especialidade
	   @ li,000 pSay "Descricao da especialidade:"
	   @ li,000 pSay CONS->Especialidade // 40 - Descricao da especialidade
	   li += 2
	EndIf   
   @ li,044 pSay "Codigo:"
   @ li,054 pSay "Nome:"
   @ li,110 pSay "Endere�o:"
   @ li,154 pSay "Bairro:"
   @ li,190 pSay "Munic�pio:"
   li ++              
	   @ li,044 pSay CONS->bau_codigo // 06 - Codigo
	   @ li,054 pSay CONS->Medico // 40 - Nome do Credenciado
	   @ li,110 pSay CONS->Endereco // 40 - Endere�o do cliente
	   @ li,154 pSay CONS->Bairro // 30 - Bairro do cliente
	   @ li,190 pSay CONS->Municipio // 30 - Municipio do cliente
   li += 2
   @ li,000 pSay "UF:"
   @ li,006 pSay "C.E.P:"
   @ li,018 pSay "N�End:"
   @ li,031 pSay "Telefone:"
   @ li,054 pSay "Complemento do endere�o:"
   @ li,110 pSay "Rede de Atendimento:"
   @ li,154 pSay "Operadora.:"
   @ li,168 pSay "Cod. Sist. Ant.:"
   @ li,190 pSay "Digito:"
   li ++              
	   @ li,000 pSay CONS->UF // 02 - Unidade Federal do cliente
	   @ li,006 pSay CONS->CEP // 08 - CEP do cliente
	   @ li,018 pSay CONS->Numero // 06 - Numero do endereco do cliente
	   @ li,031 pSay CONS->Telefone // 20 - Telefone do cliente
	   @ li,054 pSay CONS->Complemento // 30 - Complemento do endereco
	   @ li,110 pSay CONS->BAU_TIPPRE // 03 - Classe da Rede Atendim.
	   @ li,154 pSay CONS->baw_codint // 04 - Operadora
	   @ li,168 pSay CONS->baw_codant // 16 - Codigo do sistema antigo
	   @ li,190 pSay CONS->baw_digcod // 01 - Digito do Cod Sist antigo
   li ++              
   //���������������������������������������������������������������������������������Ŀ
   //� Movimenta regua - demonstrando o percentual de evolucao                         �
   //�����������������������������������������������������������������������������������
    Npercent := (nProc/nTotal)*100  
    IncProc("Gerando" + Transform(Npercent,"@E 9,999.9") + " % do Relat�rio  " )  
    ProcessMessage()  
  	 nProc++    
  	 CONS->( DbSkip() )
End                 

//������������������������������������������������������������������������������������Ŀ
//� Fecha arquivo de trabalho                                                          �
//��������������������������������������������������������������������������������������
CONS->(dbCloseArea())

//������������������������������������������������������������������������������������Ŀ
//� Imprime rodape                                                                     �
//��������������������������������������������������������������������������������������
Roda(0,"","P")
//������������������������������������������������������������������������������������Ŀ
//� Fim da funcao                                                                      �
//��������������������������������������������������������������������������������������

Return()
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  � Luzio Tavares      � Data �  14/05/2008 ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria as perguntas no SX1.                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �Protheus                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Rede Referenciada:      ","","","MV_CH1","N",01,0,0,"C","","Mv_Par01","Plena","","","","","Maximus","","","","","Executiva","","","","","","","","","","","","","","U31",""})

PlsVldPerg( aRegs )

Return(.T.)