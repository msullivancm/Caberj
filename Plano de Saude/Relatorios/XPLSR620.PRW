
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � PLSR620 � Autor � Guilherme Brunoro      � Data � 05.02.03 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Lista Atendimento Medico                                   ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � PLSR620()       	                                          ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
���23/09/03  �Padrao|Natie        | Padronizacao Versao                   ����
���          �      �Natie        � Acerto no  Tratam.cons.Canceladas     ����
���05/03/04  �Padrao|Brunoro      | Troca da funcao CONVERT na query por  ����
���          �      |             | comando advpl para calcular o tempo   ����
���          �      |             | de consulta, para funcionar no ORACLE ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Associa arquivo de definicoes                                            �
//����������������������������������������������������������������������������
#INCLUDE "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
User Function XPLSR620()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis padroes para todos os relatorios...                     �
//����������������������������������������������������������������������������
PRIVATE nQtdLin     := 58
//PRIVATE nLimite     := 132
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"       // P=Pequeno;M=Medio;G=Grande -> P=80;M=132;G=220 (colunas)
PRIVATE cTitulo     := "Relatorio de Atendimento Medico" 
PRIVATE cDesc1      := "Este relatorio ira emitir a listagem de" 
PRIVATE cDesc2      := "Atendimentos Medicos." 
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD" 
PRIVATE cPerg       := "PLR620" 
PRIVATE cRel        := "XPLSR620" 
PRIVATE nli         := 01   
PRIVATE nQtdini     := nli  
PRIVATE m_pag       := 1    
PRIVATE lCompres    := .F. 
PRIVATE lDicion     := .F. 
PRIVATE lFiltro     := .T. 
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {"Codigo do Medico+Data do Atendimento+Hora do atendimento"}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F. 
PRIVATE cCabec1     := "MEDICO (ESPECIALIDADE)" 
//Motta
//PRIVATE cCabec2     := "NUM. ATEND.  SALA DATA     HORA   CONTRATO     SUB-CONT. DESCRICAO                      MATRICULA           PACIENTE                            TELEFONE  INIC. FINAL   TEMPO  ENC TIPO     OPERADOR      CANCELAMENTO"
PRIVATE cCabec2     := "NUM. ATEND.  SALA DATA     HORA   CONTRATO     SUB-CONT. DESCRICAO                      MATRICULA           PACIENTE                            TELEFONE  INIC. FINAL   TEMPO  ENC TIPO   OPERADOR      CANCELAMENTO      X"
//
PRIVATE nColuna     := 00 
//��������������������������������������������������������������������������Ŀ
//� Dados do parametro...                                                    �
//����������������������������������������������������������������������������
PRIVATE cDatDe
PRIVATE cDatAte
PRIVATE cMedDe
PRIVATE cMedAte
//��������������������������������������������������������������������������Ŀ
//� Variaveis de mascara (picture)                                           �
//����������������������������������������������������������������������������
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
//� Verifica se foi cancelada a operacao (padrao)                            �
//����������������������������������������������������������������������������
If nLastKey  == 27 
   Return
Endif
//��������������������������������������������������������������������������Ŀ
//� Acessa parametros do relatorio...                                        �
//����������������������������������������������������������������������������
Pergunte(cPerg,.F.) 

cDatDe  := mv_par01
cDatAte := mv_par02
cMedDe  := mv_par03
cMedAte := mv_par04  
nSomAAG := mv_par05
//��������������������������������������������������������������������������Ŀ
//� Configura impressora (padrao)                                            �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias) 
//��������������������������������������������������������������������������Ŀ
//� Emite relat�rio                                                          �
//����������������������������������������������������������������������������
MsAguarde({|| XR620Imp() }, cTitulo, "", .T.) 
//��������������������������������������������������������������������������Ŀ
//� Fim da rotina                                                            �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � XR620Imp  � Autor � Guilherme Brunoro     � Data � 29.01.03 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime...                                                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function XR620Imp()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis...                                                      �
//����������������������������������������������������������������������������
LOCAL cSQL
LOCAL nOrdSel  := aReturn[8] 
LOCAL cCodCre    
LOCAL cCodUsu
LOCAL cTempo             
LOCAL cTipo
LOCAL cCodCanc := ""
LOCAL nUsuCre  := 0
LOCAL nTotUsu  := 0
LOCAL nTotEnc  := 0
LOCAL nTotCon  := 0
LOCAL nTotRev  := 0
LOCAL nTotPro  := 0                                               
LOCAL nTotAte  := 0                                               
LOCAL nTotCac  := 0                                               
LOCAL nTemIni  := 0
LOCAL nTemFin  := 0
LOCAL nTempo   := 0
LOCAL nHora    := 0
LOCAL nMinuto  := 0      

Local cAAG     := " "
//��������������������������������������������������������������������������Ŀ
//� Cadastro da Rede de Atendimento...                                       �
//����������������������������������������������������������������������������
LOCAL cBBDName := RetSQLName("BBD")
LOCAL cBTHName := RetSQLName("BTH")
//��������������������������������������������������������������������������Ŀ
//� Define variaveis de trabalho...                                          �
//����������������������������������������������������������������������������
//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem...                                                        �
//����������������������������������������������������������������������������
MsProcTxt(PLSTR0001) 
//��������������������������������������������������������������������������Ŀ
//� Faz filtro no arquivo...                                                 �
//����������������������������������������������������������������������������   

//Motta
cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG,"
cSQL += "       BBD_NUMATE,BBD_CODINT,BBD_NUMATE,BBD_DATA,BBD_HORA,BBD_CODIGO,BBD_CODESP,BBD_NOME,BBD_CODPAC,"
cSQL += "BBD_TELEFO,BBD_NSALA,BBD_ENCAIX,BBD_TIPO,BBD_USUOPE,BBD_STATUS,BBD_CODLOC "
cSQL += "FROM "+cBBDName+" "
cSQL += "WHERE "
cSQL += " D_E_L_E_T_ = ' ' AND "
cSQL += " BBD_FILIAL = '   "  + xFilial("BBD")+"' "     
cSQL += " AND BBD_DATA >= '"  + Dtos(cDatDe)+"' AND BBD_DATA <= '"+Dtos(cDatAte)+"' "
cSQL += " AND BBD_CODIGO >= '"+ cMedDe+"' AND BBD_CODIGO     <= '" +cMedAte      +"' " 
//��������������������������������������������������������������������������Ŀ
//� Se houver filtro executa parse para converter expressoes adv para SQL    �
//����������������������������������������������������������������������������
If ! Empty(aReturn[7])
   cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
Endif      
// Motta
If nSomAAG == 2 
	cSQL += " AND TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA))='S' " 
Endif
//��������������������������������������������������������������������������Ŀ
//� De acordo com a ordem....                                                �
//����������������������������������������������������������������������������
If     nOrdSel == 1                        
       cSQL += " ORDER BY BBD_CODIGO,BBD_DATA,BBD_HORA "
Endif       

PLSQuery(cSQL,"BBDTrb")
BBDTrb->(DbGotop())
//��������������������������������������������������������������������Ŀ
//� Imprime Cabecalho...                                               �
//����������������������������������������������������������������������
R620Cabec()
//��������������������������������������������������������������������������Ŀ
//� Inicio da impressao dos detalhes...                                      �
//����������������������������������������������������������������������������
While ! BBDTrb->(Eof())
      //��������������������������������������������������������������������Ŀ
      //� Exibe mensagem...                                                  �
      //����������������������������������������������������������������������
      MsProcTXT("Imprimindo "+BBDTrb->BBD_CODIGO+"...")
      //��������������������������������������������������������������������Ŀ
      //� Verifica se foi abortada a impressao...                            �
      //����������������������������������������������������������������������
      If Interrupcao(lAbortPrint)
         nLi ++
         @ nLi, nColuna pSay PLSTR0002
         Exit
      Endif                       
      //��������������������������������������������������������������������Ŀ
      //� verifica proxima pagina...                                         �
      //����������������������������������������������������������������������
      If nLi > nQtdLin
         R620Cabec()
      Endif 
      cCodCre := BBDTrb->BBD_CODIGO
      //��������������������������������������������������������������������Ŀ
      //� Posiciono no prestador...                                          �
      //����������������������������������������������������������������������
      BAU->(DbSetOrder(01))
      If ! BAU->(DbSeek(xFilial("BAU")+BBDTrb->BBD_CODIGO))
         MsgStop("Prestador nao encontrado: "+BBDTrb->BBD_CODIGO)
      Endif
      //��������������������������������������������������������������������Ŀ
      //� Posiciono na especialidade...                                      �
      //����������������������������������������������������������������������
      BAQ->(DbSetOrder(01))
      If ! BAQ->(DbSeek(xFilial("BAQ")+BBDTrb->(BBD_CODINT+BBD_CODESP)))
         MsgStop("Especialidade nao encontrada: "+BBDTrb->BBD_CODESP)
      Endif
      //��������������������������������������������������������������������Ŀ
      //� Imprime Grupo...                                                   �
      //����������������������������������������������������������������������
      @ ++nLi, nColuna pSay IIF(BAU->BAU_SEXO="0","Dr. ","Dra. ")+Alltrim(BAU->BAU_NOME)+" ("+AllTrim(BAQ->BAQ_DESCRI)+")"
      nLi ++

      While cCodCre == BBDTrb->BBD_CODIGO
            //��������������������������������������������������������������������������Ŀ
            //� Verifico Agendas Canceladas...                                           �
            //����������������������������������������������������������������������������
			cCodCanc := ""
			If BBDTrb->BBD_STATUS  == "7" 

				//��������������������������������������������������������������������������Ŀ
				//� Posiciono no Arquivo de Agendas Canceladas...                            �
				//����������������������������������������������������������������������������
				BHY->(DbSetOrder(1))							//-- BHY_FILIAL + BHY_CODPAC + BHY_CODESP + DTOS(BHY_DATA)+BHY_HORA
				If ! BHY->(DbSeek(xFilial("BHY")+BBDTrb->(BBD_CODIGO+BBD_CODINT+BBD_CODLOC+DTOS(BBD_DATA)+BBD_HORA)))
					BBDTrb->(DbSkip())
					Loop
				Else
					nTotCac ++
                     //��������������������������������������������������������������������������Ŀ
                     //� Posiciono no Arquivo de Motivo de Agendas Canceladas...                  �
                     //����������������������������������������������������������������������������
                     cCodCanc	:= LEFT(fDesc("BTJ",BHY->BHY_CODCAN , "BTJ_DESCRI" ),18)
				Endif
            Endif
            //��������������������������������������������������������������������Ŀ
            //� Posiciono no arquivo BTH ( Atendimento x Consultas)...             �
            //����������������������������������������������������������������������
            cSQL := "SELECT BTH_HORINI,BTH_HORFIN "
            cSQL += "FROM "+cBTHName+" "
            cSQL += "WHERE "
            cSQL += " BTH_FILIAL = '"+xFilial("BTH")+"' "     
            cSQL += " AND "+cBTHName+".D_E_L_E_T_ = ' '  "
            cSQL += " AND BTH_CODATE = '"+BBDTrb->BBD_NUMATE+"'"

			PLSQuery(cSQL,"BTHTrb")
			BTHTrb->(DbGotop())
            //��������������������������������������������������������������������Ŀ
            //� Monta matricula...                                                 �
            //����������������������������������������������������������������������
            cCodUsu := Substr(BBDTrb->BBD_CODPAC,1,4)+"."+Substr(BBDTrb->BBD_CODPAC,5,4)+"."+;
                        Substr(BBDTrb->BBD_CODPAC,9,6)+"."+Substr(BBDTrb->BBD_CODPAC,15,2)
            //��������������������������������������������������������������������Ŀ
            //� Posiciono no USUARIO...                                            �
            //����������������������������������������������������������������������
            BA1->(DbSetOrder(02))									//BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG
            BA1->(DbSeek(xFilial("BA1")+Substr(BBDTrb->BBD_CODPAC,1,16)))
            //��������������������������������������������������������������������������Ŀ
            //� Posiciono no Sub-Contrato...                                             �
            //����������������������������������������������������������������������������
            BQC->(DbSetOrder(1))									// BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
            BQC->(DbSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
            //��������������������������������������������������������������������Ŀ
            //� Calculo o tempo gasto na consulta...                               �
            //����������������������������������������������������������������������
            If Empty(BTHTrb->BTH_HORINI) .Or. Empty(BTHTrb->BTH_HORFIN)
               cTempo  := Space(05)
            Else
		       nTemFin := Val(Substr(BTHTrb->BTH_HORFIN,1,2))*60 + Val(Substr(BTHTrb->BTH_HORFIN,4,2))
		       nTemIni := Val(Substr(BTHTrb->BTH_HORINI,1,2))*60 + Val(Substr(BTHTrb->BTH_HORINI,4,2))		    
		       nTempo  := nTemFin - nTemIni
               If nTempo > 60
                  nHora   := Int(nTempo/60)
                  nMinuto := Mod(nTempo,60)
			      cTempo  := Strzero(nHora,2)+":"+Strzero(nMinuto,2)
               Else
                  cTempo := "00:"+Strzero(nTempo,2)
               Endif
            Endif
            //Motta
            //cTipo   := Substr(X3combo("BBD_TIPO",BBDTrb->BBD_TIPO),1,8)
            cTipo   := Substr(X3combo("BBD_TIPO",BBDTrb->BBD_TIPO),1,6)
            //
            If Len(cTipo) < 8 
               //Motta
               //cTipo := cTipo+Space(8-Len(cTipo)) 
               cTipo := cTipo+Space(6-Len(cTipo)) 
            Endif 
            // Motta
            If Trim(BBDTrb->AAG) == "S"
				cAAG            := "*" 
			Else 
				cAAG            := " " 
			Endif 
			//
            //��������������������������������������������������������������������Ŀ
            //� verifica proxima pagina...                                         �
            //����������������������������������������������������������������������
            If nLi > nQtdLin
               R620Cabec()
            Endif 
            //��������������������������������������������������������������������Ŀ
            //� Imprime...                                                         �
            //����������������������������������������������������������������������
            @ ++nLi, nColuna pSay BBDTrb->BBD_NUMATE           +Space(01)+BBDTrb->BBD_NSALA +Space(03)+;
                                   Dtoc(BBDTrb->BBD_DATA)      +Space(01)+BBDTrb->BBD_HORA  +;
                                   Space(02)+BA1->BA1_CONEMP   +Space(01)+BA1->BA1_SUBCON   +Space(01)+;
                                   Substr(BQC->BQC_DESCRI,1,30)+Space(01)+cCodUsu+;
                                   Space(01)+Substr(BBDTrb->BBD_NOME,1,35)+Space(01)+;
                                   Substr(BBDTrb->BBD_TELEFO,1,9) +Space(01)+BTHTrb->BTH_HORINI+Space(01)+;
                                   BTHTrb->BTH_HORFIN+Space(03)   +cTempo   + Space(02)+;
                                   X3combo("BBD_ENCAIX",BBDTrb->BBD_ENCAIX) + Space(01)+cTipo+Space(01)+;
                                   Substr(BBDTrb->BBD_USUOPE,1,13)+Space(01)+ ;
                                   cCodCanc + Space(18-Len(cCodCanc)) + Space(01) + cAAG
            //��������������������������������������������������������������������Ŀ
            //� Soma pacientes...                                                  �
            //����������������������������������������������������������������������               
            nUsuCre ++
            nTotUsu ++
            If BBDTrb->BBD_ENCAIX == "1"
               nTotEnc ++
            Endif
            If BBDTrb->BBD_TIPO =="1"
               nTotCon ++
            Elseif BBDTrb->BBD_TIPO =="2"
               nTotRev ++
            Elseif BBDTrb->BBD_TIPO =="3"   
               nTotPro ++            
            Endif
            If ! Empty(BBDTrb->BBD_NUMATE)
               nTotAte ++  
            Endif
            //��������������������������������������������������������������������Ŀ
            //� Fecha arquivo...                                                   �
            //����������������������������������������������������������������������
            BTHTrb->(DbCloseArea())
            //��������������������������������������������������������������������Ŀ
            //� Proximo registro...                                                �
            //����������������������������������������������������������������������
            BBDTrb->(DbSkip())
      Enddo
      //��������������������������������������������������������������������Ŀ
      //� Imprime Sub-Total...                                               �
      //����������������������������������������������������������������������
      @ ++nLi, nColuna pSay Replicate("-",nLimite)
      @ ++nLi, nColuna pSay "Total de pacientes: "+Alltrim(Str(nUsuCre))
      nLi++
      nUsuCre := 0
Enddo
//��������������������������������������������������������������������Ŀ
//� verifica proxima pagina...                                         �
//����������������������������������������������������������������������
If nLi > nQtdLin
   R620Cabec()
Endif 
//��������������������������������������������������������������������Ŀ
//� Imprime Total Geral...                                             �
//����������������������������������������������������������������������
@ ++nLi, nColuna pSay "Resumo Geral do Relatorio"
@ ++nLi, nColuna pSay "----------------------------"
@ ++nLi, nColuna pSay "Consultas             : "+Alltrim(Str(nTotCon))
@ ++nLi, nColuna pSay "Encaixes              : "+Alltrim(Str(nTotEnc))
@ ++nLi, nColuna pSay "Revisoes              : "+Alltrim(Str(nTotRev))
@ ++nLi, nColuna pSay "Procedimentos         : "+Alltrim(Str(nTotPro))
@ ++nLi, nColuna pSay "Pacientes Agendados   : "+Alltrim(Str(nTotUsu))
@ ++nLi, nColuna pSay "Pacientes Atendidos   : "+Alltrim(Str(nTotAte))
@ ++nLi, nColuna pSay "Cancelamento de Agenda: "+Alltrim(Str(nTotCac))
@ ++nLi, nColuna pSay "----------------------------"
//��������������������������������������������������������������������Ŀ
//� Imprime rodape do relatorio...                                     �
//����������������������������������������������������������������������
Roda(0,space(10),cTamanho)
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������
BBDTrb->(DbCloseArea())
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
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
���Programa   � R620Cabec � Autor � Brunoro              � Data � 29.01.03 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime TDE...                                             ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function R620Cabec()
//��������������������������������������������������������������������������Ŀ
//� Imprime cabecalho...                                                     �
//����������������������������������������������������������������������������
nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
//��������������������������������������������������������������������������Ŀ
//� Fim da Rotina...                                                         �
//����������������������������������������������������������������������������

Return