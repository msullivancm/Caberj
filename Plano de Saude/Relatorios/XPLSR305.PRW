#INCLUDE "plsr305.ch"

#INCLUDE "PROTHEUS.CH"
#IFDEF TOP
   #INCLUDE "TOPCONN.CH"
#ENDIF   
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � PLSR305 � Autor � Marco Paulo            � Data � 29.07.02 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Lista Atendimento por Especialidade                        ����
�������������������������������������������������������������������������Ĵ���
���Sintaxe   � PLSR305()                                                  ����
�������������������������������������������������������������������������Ĵ���
��� Uso      � Advanced Protheus                                          ����
�������������������������������������������������������������������������Ĵ���
��� Alteracoes desde sua construcao inicial                               ����
�������������������������������������������������������������������������Ĵ���
��� Data     � BOPS � Programador � Breve Descricao                       ����
�������������������������������������������������������������������������Ĵ���
��� 24/09/03 �      � Natie       � Quebra  de pagina / Padronizacao      ����
���          �      �             �                                       ����
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
User Function XPLSR305()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis padroes para todos os relatorios...                     �
//����������������������������������������������������������������������������
PRIVATE nQtdLin     := 58       										// Qtd de Linhas Por Pagina
PRIVATE nLimite     := 132       										// Limite de Colunas
PRIVATE Titulo      := STR0001 	// Titulo do Relatorio //"Relatorios de Atendimentos por Especialidade"
PRIVATE cDesc1      := STR0002 		// Descritivo para o usuario //"Este relatorio ira emitir a listagem de"
PRIVATE cDesc2      := STR0003 		// Descritivo para o usuario //"Atendimentos Medicos por Especialidade."
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BBD" 											// Alias
PRIVATE cPerg       := "PLSR35" 										// Pergunta padrao (SX1) dos parametros
PRIVATE m_pag       := 1    											// Variavel padrao para contar numero da pagina
PRIVATE lCompres    := .F. 												// nao mude e padrao
PRIVATE lDicion     := .F. 												// nao mude e padrao
PRIVATE lFiltro     := .T. 												// Habilitar o filtro ou nao
PRIVATE lCrystal    := .F. 												// nao mudar controle do crystal reports
PRIVATE aOrderns    := {STR0004,STR0005} // Ordens disponiveis...         //"Codigo da Especialidade + Data atendimento + Hora de atendimento"###"Nome da Especialidade  +  Data do Atendimento  +  Hora do Atendimento"
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 } 					// padrao nao mude
PRIVATE lAbortPrint := .F. 												// Controle para abortar (sempre como esta aqui)
PRIVATE cCabec1     := "" 
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 03 												// Numero da coluna que sera impresso as colunas
//��������������������������������������������������������������������������Ŀ
//� Dados do parametro...                                                    �
//����������������������������������������������������������������������������
PRIVATE cIntDe
PRIVATE cIntAte
PRIVATE cDatDe
PRIVATE cDatAte
PRIVATE cMedDe
PRIVATE cMedAte
PRIVATE cEspDe
PRIVATE cEspAte
//��������������������������������������������������������������������������Ŀ
//� Variaveis de mascara (picture)                                           �
//����������������������������������������������������������������������������
PRIVATE pMoeda      := "@E 99,999,999.99"
PRIVATE pQtd        := "99"

//��������������������������������������������������������������Ŀ
//� Variaveis Utilizadas na funcao IMPR                          �
//����������������������������������������������������������������
PRIVATE cCabec
PRIVATE wnRel       := "XPLSR305"							// Nome do Relatorio
PRIVATE Colunas		:= 132 
PRIVATE nTamanho    := "M"       							// P=Pequeno;M=Medio;G=Grande -> P=80;M=132;G=220 (colunas)
PRIVATE li         	:= 00   								// Variavel padrao para controlar numero de linha
PRIVATE AT_PRG  	:= "XPLSR305"
PRIVATE wCabec0 	:= 1
PRIVATE wCabec1		:= "DATA       HORA  PACIENTE                                 CARTEIRINHA            TELEFONE   "
PRIVATE wCabec2		:= ""
PRIVATE wCabec3		:= ""
PRIVATE wCabec4		:= ""
PRIVATE wCabec5		:= ""
PRIVATE CONTFL		:=1 

//��������������������������������������������������������������������������Ŀ
//� Testa ambiente do relatorio somente top...                               �
//����������������������������������������������������������������������������
If ! PLSRelTop()
   Return
Endif    
//��������������������������������������������������������������������������Ŀ
//� Chama SetPrint (padrao)                                                  �
//����������������������������������������������������������������������������
wnRel  := SetPrint(cAlias,wnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,nTamanho,{},lFiltro,lCrystal)
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
cEspDe  := mv_par07
cEspAte := mv_par08 
nSomAAG := mv_par09//Motta
//��������������������������������������������������������������������������Ŀ
//� Configura impressora (padrao)                                            �
//����������������������������������������������������������������������������
SetDefault(aReturn,cAlias) 
//��������������������������������������������������������������������������Ŀ
//� Emite relat�rio                                                          �
//����������������������������������������������������������������������������
MsAguarde({|| XR305Imp() }, Titulo, "", .T.) // Exibe dialogo padrao...
//��������������������������������������������������������������������������Ŀ
//� Fim da rotina                                                            �
//����������������������������������������������������������������������������
Return
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Programa   � XR305Imp  � Autor � Marco Paulo           � Data � 29.07.02 ���
��������������������������������������������������������������������������Ĵ��
���Descricao  � Imprime TDE...                                             ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
Static Function XR305Imp()
//��������������������������������������������������������������������������Ŀ
//� Define variaveis...                                                      �
//����������������������������������������������������������������������������
LOCAL cSQL
LOCAL nOrdSel := aReturn[8] // Ordem selecionada...
LOCAL cString     := "" 	// Variavel que guarda o registro corrente do arquivo de detalhes
LOCAL cTotal1     := 0   	// Variavel que conta numero de eventos
LOCAL cTotal2     := 0   	// Variavel que conta numero de eventos
LOCAL cCodEsp	  := ""
LOCAL cCodMed	  := ""
LOCAL nLin		  := 0
LOCAL cAGG        := " "//Motta

//��������������������������������������������������������������������������Ŀ
//� Exibe mensagem...                                                        �
//����������������������������������������������������������������������������
MsProcTxt(PLSTR0001) // Nao mude e padrao...
//��������������������������������������������������������������������������Ŀ
//� Faz filtro no arquivo...                                                 �
//����������������������������������������������������������������������������

#IFDEF TOP
        // Motta
        cSQL := "SELECT  TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG," 
        cSQL += "       BBD_CODIGO,BAU_NOME,BBD_DATA, BBD_HORA, BBD_NOME,BBD_CODPAC,BBD_TELEFO,BBD_STATUS, "
        cSQL += "BBD_TIPO,BBD_CODESP,BAQ_DESCRI,BBD_NUMATE,BBD_SIGLA,"
        cSQL += "BBD_ESTCR,BBD_NUMREG from "
        cSQL += RetSQLName("BBD") + "," + RetSQLName("BAQ") + "," 
        cSQL += RetSQLName("BAU") + " WHERE "
        cSQL += "BBD_FILIAL = '"+xFilial("BBD")+"' "
        cSQL += "AND "+RetSQLName("BBD")+".D_E_L_E_T_ = ' '  AND "
        cSQL += "BBD_CODESP = BAQ_CODESP AND BBD_CODIGO = BAU_CODIGO AND BBD_STATUS = '4' AND "
        cSQL += "BBD_DATA >= '" + DTOS(cDatDe)  + "' AND " 
        cSQL += "BBD_DATA <= '" + DTOS(cDatAte) + "' AND "
        cSQL += "BBD_CODIGO >= '"+cMedDe+"' AND BBD_CODIGO <= '"+cMedAte + "' AND " 
        cSQL += "BBD_CODESP >= '"+cEspDe+"' AND BBD_CODESP <= '"+cEspAte + "' " 
        //��������������������������������������������������������������������������Ŀ
        //� Se houver filtro executa parse para converter expressoes adv para SQL    �
        //����������������������������������������������������������������������������
        If ! Empty(aReturn[7])
           cSQL += " and " + PLSParSQL(aReturn[7])
        Endif  
        // Motta
        If nSomAAG == 2 
          cSQL += " AND TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),SubStr(BBD_CODPAC,9,6),SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA))='S' " 
        Endif
        // 
        //��������������������������������������������������������������������������Ŀ
        //� Define order by de acordo com a ordem...                                 �
        //����������������������������������������������������������������������������
        If     nOrdSel == 1                        
               cSQL += " ORDER BY BBD_CODESP,BBD_CODIGO,BBD_DATA,BBD_HORA "
        ElseIf nOrdSel == 2
               cSQL += " ORDER BY BAQ_DESCRI,BAU_NOME,BBD_DATA, BBD_HORA "
        Endif       
		cSQL := ChangeQuery(cSQL)
        PLSQuery(cSQL,"BBDTrb")
#ENDIF        

DbSelectArea("BBDTrb")
BBDTrb->(DbGotop())
//��������������������������������������������������������������������������Ŀ
//� Inicio da impressao dos detalhes...                                      �
//����������������������������������������������������������������������������
While ! BBDTrb->( Eof() )
	cCodEsp	:= BBDTrb->BBD_CODESP
	//��������������������������������������������������������������������Ŀ
    //� Exibe mensagem...                                                  �
    //����������������������������������������������������������������������
    MsProcTXT(STR0006+BBDTrb->BAQ_DESCRI+"...") //"Imprimindo "
    //��������������������������������������������������������������������Ŀ
    //� Verifica se foi abortada a impressao...                            �
    //����������������������������������������������������������������������
    If Interrupcao(lAbortPrint)
		Impr(STR0007,"C")  //"Abortado pelo Operador"
    	Exit
    Endif                       
    //��������������������������������������������������������������������������Ŀ
    //� IMPRIME O CABECALHO DA PRIMEIRA PAGINA                                   �
    //����������������������������������������������������������������������������
    Impr("[ "+BBDTrb->(BBD_CODESP) + " " + BBDTrb->BAQ_DESCRI + " ]" ,"C")
    Impr("","C") 
	While ! BBDTrb->( Eof() )  .and. cCodEsp = BBDTrb->BBD_CODESP
		cCodEsp	:= BBDTrb->BBD_CODESP		
		cCodMed	:= BBDTrb->BAU_NOME 
		Impr(BBDTrb->BBD_CODIGO + " " + BBDTrb->BAU_NOME ,"C")
		Impr("","C")
		While ! BBDTrb->( Eof() )  .and. cCodEsp+ cCodMed	= BBDTrb->(BBD_CODESP+BAU_NOME )
		
			If Trim(BBDTrb->AAG) == "S"
				cAAG            := "*" 
			Else 
				cAAG            := " " 
			Endif  
					
			cString := 	dToc(BBDTrb->BBD_DATA) + " " + substr(BBDTrb->BBD_HORA,1,5);
						+ " " + substr(BBDTrb->BBD_NOME,1,40) + " " + Transform(BBDTrb->BBD_CODPAC,"@R #.###.####.######-##-#" );
						+ " " + BBDTrb->BBD_TELEFO + " " + cAAG
      
      		Impr(cString ,"C")
	      	ctotal1 := ctotal1 + 1   
			ctotal2 := ctotal2 + 1 
      
		    //��������������������������������������������������������������������Ŀ
			//� Acessa proximo registro...                                         �
			//����������������������������������������������������������������������
			BBDTrb->(DbSkip())
		Enddo
		If li + 3 >= nQtdLin
			li := 0 
		Endif	
		Impr(__PrtThinLine() ,"C")
		Impr(STR0008 + str(cTotal1), "C")  //"Total por Medico        = "
		Impr("","C")
		Impr("","C")		
		cTotal1	:= 0 
	Enddo            
	If li + 4 >= nQtdLin
		li := 0 
	Endif	
	Impr("","C") 
	Impr(__PrtThinLine() ,"C")	
	Impr(STR0009 + str(cTotal2), "C")  //"Total por Especialidade = "
	Impr(__PrtThinLine() ,"C")	
	nLin	:= Li
	Impr("","P")
	cTotal2	:= 0 
Enddo      
li := nLin
Impr("","F")
//��������������������������������������������������������������������Ŀ
//� Fecha arquivo...                                                   �
//����������������������������������������������������������������������
BBDTrb->(DbCloseArea())
//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1 // Abre spooll se foi selecionado imprensao em disco...
    Set Printer To
    Ourspool(wnRel)
End
//��������������������������������������������������������������������������Ŀ
//� Fim do Relat�rio                                                         �
//����������������������������������������������������������������������������
Return
