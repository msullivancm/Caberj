#include "rwmake.ch"  
#include "TOPCONN.CH"
/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪穆哪哪哪履哪哪哪哪哪目北
北矲un噮o    � CABR006  � Autor � LUZIO TAVARES          � Data � 14.05.2008 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪牧哪哪哪聊哪哪哪哪哪拇北
北矰escri噮o � Guia Medico                                                   |北
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪拇北
北砋so       � Especifico - GERC                                             潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁北
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/
User Function CABR006()

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Inicializa variaveis                                                               �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Private cbcont,cbtxt
Cusur := PlretOpe() // armazena na vari醰el o usu醨io do sistema
cString  := "SCP"
cDesc1   := "Emiss鉶 de Guia M閐ico..."
cDesc2   := ""
cDesc3   := "Usu醨io Ativo: ("+Alltrim(Cusur)+")"
limite   := 220
tamanho  := "G"
aReturn  := { "Zebrado", 1,"Setor: Credenciamento", 1, 2, 1, "",1 }
aLinha   := {}
nLastKey := 0                         
titulo   := "Guia M閐ico - CABR006"
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

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Verifica as perguntas selecionadas                           �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
AjustaSX1(cPerg)
Pergunte(cPerg,.F.)

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Chamada padrao de relatorios                                                       �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
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
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Processa relatorio                                                                 �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Processa({|| CABRIMP() }, "Processando Informa珲es...", "", .T.)
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Libera spool                                                                       �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Set Filter To
If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif
MS_FLUSH()             // Libera fila de relatorios em spool
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Fim do programa                                                                    �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Return

/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
北谀哪哪哪哪穆哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目北
北矲un噮o    � CABRIMP                                                       潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪拇北
北矰escri噮o � Processa relatorio                                            |北
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁北
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

Static Function CABRIMP()
Local nTotal:= 0 // recebe o n total de registros
Local nProc:=1 // incrementado por unidade de registro
Local Npercent := 0 // percentual na barra de evolucao
Local Tipo := Mv_Par01

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Monta query                                                                        �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁 

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

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Monta regua                                                                        �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
CONS->(DBEval( { | | nTotal++ }))
CONS-> ( DbGotop()) 
ProcRegua(nTotal)
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Imprime relatorio                                                                  �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
While ! CONS->(eof())
   //谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
   //� Imprime cabecalho                                                               �
   //滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
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
   @ li,110 pSay "Endere鏾:"
   @ li,154 pSay "Bairro:"
   @ li,190 pSay "Munic韕io:"
   li ++              
	   @ li,044 pSay CONS->bau_codigo // 06 - Codigo
	   @ li,054 pSay CONS->Medico // 40 - Nome do Credenciado
	   @ li,110 pSay CONS->Endereco // 40 - Endere鏾 do cliente
	   @ li,154 pSay CONS->Bairro // 30 - Bairro do cliente
	   @ li,190 pSay CONS->Municipio // 30 - Municipio do cliente
   li += 2
   @ li,000 pSay "UF:"
   @ li,006 pSay "C.E.P:"
   @ li,018 pSay "N篍nd:"
   @ li,031 pSay "Telefone:"
   @ li,054 pSay "Complemento do endere鏾:"
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
   //谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
   //� Movimenta regua - demonstrando o percentual de evolucao                         �
   //滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪�
    Npercent := (nProc/nTotal)*100  
    IncProc("Gerando" + Transform(Npercent,"@E 9,999.9") + " % do Relat髍io  " )  
    ProcessMessage()  
  	 nProc++    
  	 CONS->( DbSkip() )
End                 

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Fecha arquivo de trabalho                                                          �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
CONS->(dbCloseArea())

//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Imprime rodape                                                                     �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁
Roda(0,"","P")
//谀哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪目
//� Fim da funcao                                                                      �
//滥哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁

Return()
/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矨justaSX1 篈utor  � Luzio Tavares      � Data �  14/05/2008 罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     矯ria as perguntas no SX1.                                   罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       砅rotheus                                                    罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function AjustaSX1(cPerg)

Local aRegs		:= {}

Aadd(aRegs,{cPerg,"01","Rede Referenciada:      ","","","MV_CH1","N",01,0,0,"C","","Mv_Par01","Plena","","","","","Maximus","","","","","Executiva","","","","","","","","","","","","","","U31",""})

PlsVldPerg( aRegs )

Return(.T.)