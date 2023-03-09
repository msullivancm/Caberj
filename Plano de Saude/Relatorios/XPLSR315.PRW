#INCLUDE "plsr315.ch"

#INCLUDE "PROTHEUS.CH"
#IFDEF TOP
	#INCLUDE "TOPCONN.CH"
#ENDIF
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � PLSR315 � Autor � Marco Paulo            � Data � 27.07.02 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Lista Atendimentos Cancelados                              ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � PLSR315()                                                  ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
��� 25/09/03 �      � Natie       � Quebra  de pagina / Padronizacao      ����
��� 09/03/04 �      � Brunoro     � Ajustes de funcoes para Oracle        ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Associa arquivo de definicoes                                            �
//����������������������������������������������������������������������������
#include "PLSMGER.CH"
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
User Function XPLSR315()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis padroes para todos os relatorios...                     �
//����������������������������������������������������������������������������
PRIVATE nQtdLin     := 58       								// Qtd de Linhas Por Pagina
PRIVATE nLimite     := 132       								// Limite de Colunas
PRIVATE cTamanho    := "M"       								// P=Pequeno;M=Medio;G=Grande -> P=80;M=132;G=220 (colunas)
PRIVATE cTitulo     := STR0001 	// Titulo do Relatorio //"Relatorios de Atendimentos Cancelados"
PRIVATE cDesc1      := STR0002 // Descritivo para o usuario //"Este relatorio ira emitir a listagem de"
PRIVATE cDesc2      := STR0003 				// Descritivo para o usuario //"Atendimentos Cancelados."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BHY" 									// Alias
PRIVATE cPerg       := "PLSR15" 								// Pergunta padrao (SX1) dos parametros
PRIVATE cRel        := "XPLSR315" 								// Nome do Relatorio
PRIVATE nli         := 01   									// Variavel padrao para controlar numero de linha
PRIVATE nQtdini     := nli  									// Variavel para controlar numero de linha inicial
PRIVATE m_pag       := 1    									// Variavel padrao para contar numero da pagina
PRIVATE lCompres    := .F. 										// nao mude e padrao
PRIVATE lDicion     := .F. 										// nao mude e padrao
PRIVATE lFiltro     := .T. 										// Habilitar o filtro ou nao
PRIVATE lCrystal    := .F. 										// nao mudar controle do crystal reports
PRIVATE aOrderns    := {STR0004,STR0005} // Ordens disponiveis...         //"Codigo do Medico + Data atendimento + Hora de atendimento"###"Nome do Medico  +  Data do Atendimento  +  Hora do Atendimento"
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 			// padrao nao mude
PRIVATE lAbortPrint := .F. 										// Controle para abortar (sempre como esta aqui)
PRIVATE cCabec1     := STR0006 				// Primeira linha do cabecalho ; //"ATENDIMENTOS CANCELADOS"
PRIVATE cCabec2     := STR0007 		// utilizado pela funcao cabec... //"Cod Med      Nome Medico       "
PRIVATE nColuna     := 00 										// Numero da coluna que sera impresso as colunas
//��������������������������������������������������������������������������Ŀ
//� Dados do parametro...                                                    �
//����������������������������������������������������������������������������
PRIVATE cIntDe
PRIVATE cIntAte
PRIVATE cDatDe
PRIVATE cDatAte
PRIVATE cMedDe
PRIVATE cMedAte
PRIVATE cMotCan
PRIVATE cEmpDe  
PRIVATE cEmpAte 
PRIVATE cBenDe  
PRIVATE cBenAte 

//��������������������������������������������������������������������������Ŀ
//� Variaveis de mascara (picture)                                           �
//����������������������������������������������������������������������������
PRIVATE pMoeda      := "@E 99,999,999.99"
PRIVATE pQtd        := "99"
//��������������������������������������������������������������������������Ŀ
//� Testa ambiente do relatorio somente top...                               �
//����������������������������������������������������������������������������
If ! PLSRelTop()
   Return
Endif    
//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint (padrao)                                                  �
//����������������������������������������������������������������������������
cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)
//��������������������������������������������������������������������������Ŀ
//� Verifica se foi cancelada a operacao (padrao)                                    �
//����������������������������������������������������������������������������
If nLastKey  == 27 // Verifica o cancelamento... 
   Return
Endif
//��������������������������������������������������������������������������Ŀ
//� Acessa parametros do relatorio...                                        �
//����������������������������������������������������������������������������
Pergunte(cPerg,.F.) // e padrao, busca os parametros informados...

cIntDe  := mv_par01
cIntAte := mv_par02
cDatDe  := mv_par03
cDatAte := mv_par04
cMedDe  := mv_par05
cMedAte := mv_par06
cMotCan := mv_par07
cEmpDe  := mv_par08
cEmpAte := mv_par09
cBenDe  := mv_par10
cBenAte := mv_par11
//��������������������������������������������������������������������������Ŀ
//� Configura impressora (padrao)                                            �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias) 
//��������������������������������������������������������������������������Ŀ
//� Emite relat�rio                                                          �
//����������������������������������������������������������������������������
MsAguarde({|| XR315Imp() }, cTitulo, "", .T.) // Exibe dialogo padrao...
//��������������������������������������������������������������������������Ŀ
//� Fim da rotina                                                            �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � XR315Imp  � Autor � Marco Paulo           � Data � 27.07.02 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime TDE...                                             ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function XR315Imp()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis...                                                      �
//����������������������������������������������������������������������������
LOCAL cSQL
LOCAL nOrdSel := aReturn[8] // Ordem selecionada...
LOCAL cString     := "" 	// Variavel que guarda o registro corrente do arquivo de detalhes
LOCAL cCabVar     := ""  	// Variavel que guarda o cabecalho atual do registro
LOCAL cTotal1     := 0   	// Variavel que conta eventos
LOCAL aRet        := {}
LOCAL nPos        := 0
LOCAL nFor        := 0    
Local cAAG        := " "//Motta


//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem...                                                        �
//����������������������������������������������������������������������������
MsProcTxt(PLSTR0001) // Nao mude e padrao...
//��������������������������������������������������������������������������Ŀ
//� Faz filtro no arquivo...                                                 �
//����������������������������������������������������������������������������

#IFDEF TOP
        //cSQL := "select BHY_CODIGO,BAU_NOME,BHY_DATA, BHY_HORA, BHY_NOME,BHY_CODPAC,"
        cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BHY_CODPAC,1,4),SubStr(BHY_CODPAC,5,4),SubStr(BHY_CODPAC,9,6),SubStr(BHY_CODPAC,15,2),'0041',BHY_DATA)) AAG,"
        cSQL += "     BHY_CODIGO,BAU_NOME,BHY_DATA, BHY_HORA, BHY_NOME,BHY_CODPAC,"
        cSQL += "BHY_TIPO,BHY_CODESP,BAQ_DESCRI,BHY_SIGLA,BHY_USUOPE,"
        cSQL += "BHY_ESTCR,BHY_NUMREG,BTJ_DESCRI,BG9_DESCRI from " 
        cSQL += RetSQLName("BHY") + "," + RetSQLName("BG9") + "," + RetSQLName("BTJ") + "," + RetSQLName("BAQ") + "," 
        cSQL += RetSQLName("BAU") + " WHERE "
        cSQL += "BHY_FILIAL = '"+xFilial("BHY")+"' "
        cSQL += "AND "+RetSQLName("BHY")+".D_E_L_E_T_ = ''  AND "
//        cSQL += "BHY_CODCAN = BTJ_CODIGO AND SUBSTRING(BHY_CODPAC,1,8) *= (BG9_CODINT + BG9_CODIGO) AND " brunoro
        cSQL += "BHY_CODCAN = BTJ_CODIGO AND SUBSTRING(BHY_CODPAC,1,8) = (BG9_CODINT + BG9_CODIGO) AND "
        cSQL += "BHY_CODESP = BAQ_CODESP AND BHY_CODIGO = BAU_CODIGO AND "
        If  ALLTrim(cMotCan) <> "" 
            cSQL += "BTJ_CODIGO = '" + cMotCan + "' AND "
        EndIf
        If ALLTrim(cEmpDe) <> ""
           cSQL += "SUBSTRING(BHY_CODPAC,5,4) >= '" +cEmpDe + "' AND SUBSTRING(BHY_CODPAC,5,4) <= '" + cEmpAte  + "'  AND "
        EndIf
        If ALLTrim(cBenDe) <> ""
           cSQL += "SUBSTRING(BHY_CODPAC,9,6) >= '" +cBenDe + "' AND SUBSTRING(BHY_CODPAC,9,6) <= '" + cBenAte  + "'  AND "
        EndIf
//        cSQL += "CONVERT(DATETIME,BHY_DATA,103) >= CONVERT(DATETIME,'" + SUBSTR(DTOS(cDatDe),1,8) + "',103) AND "   Brunoro
//        cSQL += "CONVERT(DATETIME,BHY_DATA,103) <= CONVERT(DATETIME,'" + SUBSTR(DTOS(cDatAte),1,8) + "',103) AND "  Brunoro
        cSQL += "BHY_DATA >= '"+DTOS(cDatDe)+"' AND BHY_DATA <= '"+DTOS(cDatAte)+ "' AND "


        cSQL += "BHY_CODIGO >= '"+cMedDe+"' AND BHY_CODIGO <= '"+cMedAte + "' " 
        //��������������������������������������������������������������������������Ŀ
        //� Se houver filtro executa parse para converter expressoes adv para SQL    �
        //����������������������������������������������������������������������������
        If ! Empty(aReturn[7])
           cSQL += " and " + PLSParSQL(aReturn[7])
        Endif   
        //��������������������������������������������������������������������������Ŀ
        //� Define order by de acordo com a ordem...                                 �
        //����������������������������������������������������������������������������
        If     nOrdSel == 1                        
               cSQL += " ORDER BY BHY_CODIGO,BHY_DATA,BHY_HORA "
        ElseIf nOrdSel == 2
               cSQL += " ORDER BY BAU_NOME,BHY_DATA, BHY_HORA "
        Endif       
        cSQL := PLSAvaSQL(cSQL)
        //TCQUERY cSQL NEW ALIAS "BHYTrb" // Brunoro - alterado para a funcap PLSQUERY
        PlsQuery(cSQL,"BHYTrb")					
#ENDIF        

DbSelectArea("BHYTrb")
//cFil := CriaTrab(Nil,.F.)
//Copy To &cFil VIA "TOPCONN"

BHYTrb->(DbGotop())
//��������������������������������������������������������������������������Ŀ
//� Inicio da impressao dos detalhes...                                      �
//����������������������������������������������������������������������������
           /*      10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
            1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
            99/99/9999 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx #.###.####.######-##-# XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX*/
cCabec2 := "DATA       HORA  PACIENTE                       CARTEIRINHA            CANCELAMENTO    EMPRESA                   OPERADOR"

While ! BHYTrb->(Eof())
      //��������������������������������������������������������������������Ŀ
      //� Exibe mensagem...                                                  �
      //����������������������������������������������������������������������
      MsProcTXT(STR0008+BHYTrb->BAU_NOME+"...") //"Imprimindo "
      //��������������������������������������������������������������������Ŀ
      //� Verifica se foi abortada a impressao...                            �
      //����������������������������������������������������������������������
      If Interrupcao(lAbortPrint)
         nLi ++
         @ nLi, nColuna pSay PLSTR0002
         Exit
      Endif
      //��������������������������������������������������������������������������Ŀ
      //� IMPRIME O CABECALHO DA PRIMEIRA PAGINA                                   �
      //����������������������������������������������������������������������������
      cCabec1 :=  "[ " +BHYTrb->BHY_CODIGO + "-"+ Rtrim(BHYTrb->BAU_NOME) + " ]"

      If nLi == nQtdini
         cCabvar := cCabec1
         nli := Cabec(cTitulo,cCabec1,cCabec2)
         nli ++
      Endif
      
      //��������������������������������������������������������������������Ŀ
      //� Testa nova pagina...                                               �
      //����������������������������������������������������������������������
      If nLi > nQtdLin  .OR. cCabvar <> cCabec1
         if cCabvar <> cCabec1
            nLi ++
            @ nLi,nColuna pSay ""
            nLi ++
            @ nLi,nColuna pSay STR0009 + str(cTotal1) //"Total de Cancelamento por Medico = "
            nLi ++
            @ nLi,nColuna pSay "" 
            nLi ++
            ctotal1 := 0   
         Endif  
         cCabvar := cCabec1
         R315Cabec()
      Endif             

//      cString := substr(BHYTrb->BHY_DATA,7,2) + "/" + substr(BHYTrb->BHY_DATA,5,2) + "/"; Brunoro
//                 + substr(BHYTrb->BHY_DATA,1,4) + " "  Brunoro   

      // Motta
      If Trim(BHYTrb->AAG) == "S"
	    cAAG            := "*" 
      Else 
		cAAG            := " " 
      Endif  
					
      cString := substr(Dtos(BHYTrb->BHY_DATA),7,2) + "/" + substr(Dtos(BHYTrb->BHY_DATA),5,2) + "/";
                 + substr(Dtos(BHYTrb->BHY_DATA),1,4) + " " ;
                 + substr(BHYTrb->BHY_HORA,1,5);
                 + " " + substr(BHYTrb->BHY_NOME,1,30) + " " + Transform(BHYTrb->BHY_CODPAC,"@R #.###.####.######-##-#" );
                 + " " + substr(BHYTrb->BTJ_DESCRI,1,15) + " " + substr(BHYTrb->BG9_DESCRI,1,25);
                 + " " + substr(BHYTrb->BHY_USUOPE,1,13);
                 + " " + cAAG
                 
      // imprime itens 
      @ nLi,nColuna pSay cString 
      nLi ++   
      ctotal1 := 1 + ctotal1                               

      nPos := aScan(aRet,{|x| x[1] == substr(BHYTrb->BTJ_DESCRI,1,20) })
      If nPos == 0
         aadd(aRet,{substr(BHYTrb->BTJ_DESCRI,1,20),1})
      Else
         aRet[nPos,2] := aRet[nPos,2] + 1
      Endif

//��������������������������������������������������������������������Ŀ
//� Acessa proximo registro...                                         �
//����������������������������������������������������������������������
BHYTrb->(DbSkip())
Enddo
//��������������������������������������������������������������������Ŀ
//� Imprime Cabecalho                                                  �
//����������������������������������������������������������������������
If nLi + 7 >= nQtdLin
	R315Cabec()
Endif	

nLi ++
@ nLi,nColuna pSay ""
nLi ++
@ nLi,nColuna pSay STR0009 + str(cTotal1) //"Total de Cancelamento por Medico = "
nLi ++
@ nLi,nColuna pSay "" 
nLi ++
ctotal1 := 0   
If LEN(aRet) <> 0 

	If nLi >= nQtdLin .or. ( nli + Len(aRet) ) >= nQtdLin 
		R315Cabec()
        nli ++
	Endif	
	
   nLi ++
   @ nLi,nColuna pSay ""
   nLi ++
   @ nLi,nColuna pSay STR0010  //"RESUMO DE CANCELAMENTOS"
   nLi ++                 
   @ nLi,nColuna pSay "" 
   nLi ++     

   FOR nFor := 1 TO LEN(aRet)
      @ nLi,nColuna pSay aRet[nfor,1] + " = " + str(aRet[nfor,2])
      nLi ++
   NEXT 
   
EndIf  
//��������������������������������������������������������������������Ŀ
//� Imprime rodape do relatorio...                                     �
//����������������������������������������������������������������������
Roda(0,space(10),cTamanho)
 
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������
BHYTrb->(DbCloseArea())
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1 // Abre spooll se foi selecionado imprensao em disco...
    Set Printer To
    Ourspool(cRel)
End
//��������������������������������������������������������������������������Ŀ
//� Fim do Relat�rio                                                         �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � R315Cabec � Autor � Marco Paulo          � Data � 27.07.02 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime TDE...                                             ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function R315Cabec()      

nLi ++
nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
nLi ++
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina...                                                         �
//����������������������������������������������������������������������������

Return