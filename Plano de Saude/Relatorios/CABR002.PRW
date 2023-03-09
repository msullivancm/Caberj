#include "PROTHEUS.CH"
#include "PLSMGER.CH"
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    ЁCABR002  Ё Autor ЁLuzio Tavares           Ё Data Ё 21.02.08 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Lista Totais de Usuarios por Grupo/Empresa e por tipo      Ё╠╠╠
╠╠Ё            dos usuarios de repasse                                    Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё CABR002                                                    Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё CABERJ                                                     Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
User Function CABR002()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis padroes para todos os relatorios...                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin     := 58
PRIVATE nLimite     := 132     
PRIVATE cTamanho    := "M"     
PRIVATE cTitulo     := "Usuarios Repassados para outras Operadoras de Saude"
PRIVATE cDesc1      := "Este relatorio ira emitir totais de usuarios "
PRIVATE cDesc2      := "repassados por Grupo/Empresa e por Tipo para"
PRIVATE cDesc3      := "outras operadoras de saude"
PRIVATE cAlias      := "BA1"
PRIVATE cPerg       := "CABR002"//"CABR002   "  //CAR002
PRIVATE cRel        := "CABR002"
PRIVATE nli         := 60   
PRIVATE m_pag       := 1    
PRIVATE lCompres    := .F. 
PRIVATE lDicion     := .F. 
PRIVATE lFiltro     := .T. 
PRIVATE lCrystal    := .F. 
////PRIVATE aOrderns    := {"Contrato + Matricula","Contrato + Nome","Matricula do sistema antigo"} 
//PRIVATE aOrderns    := {"Grupo/Empresa + Contrato + Sub-Contrato","Contrato + Sub-Contrato"} 
PRIVATE aOrderns    := {} 
//PRIVATE aReturn     := { "", 1,"", 2, 2, 1, "",1 } 
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Periodo:" 
PRIVATE cCabec2     := "Grupo Descricao                                                             Tot.c/ bloq.  Antes  Excl.  Incl.   Tit.   Dep. Efetivo"
//PRIVATE cCabec2     := "Grupo Contrato         Sub-Contrato  Descricao                              Tot.c/ bloq.  Antes  Excl.  Incl.   Tit.   Dep. Efetivo"
//PRIVATE cCabec2     := "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio"
PRIVATE nColuna     := 00 
PRIVATE aLinha      := {}
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Dados do parametro...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTipPes     // (PF;PJ;Ambos)
PRIVATE nAnaSin     // (Imprime Beneficiarios)
PRIVATE cOpeDe      // Codigo da Operadora de Saude de
PRIVATE cOpeAte     // Codigo da Operadora de Saude Ate
PRIVATE cOpeDes     // Codigo da Operadora de Destino
PRIVATE cOpeOri     // Codigo da Operadora de Destino
PRIVATE cDatDe      // Data Referencia Inicial
PRIVATE cDatAte     // Data Referencia Final
PRIVATE cGrupoDe    // Codigo do Grupo/Empresa de
PRIVATE cGrupoAte   // Codigo do Grupo/Empresa ate
PRIVATE cContrDe    // Codigo do Contrato de
PRIVATE cContrAte   // Codigo do Contrato ate
PRIVATE cSbConDe    // Codigo do Sub-contrato de
PRIVATE cSbConAte   // Codigo do Sub-contrato ate
PRIVATE cTotal      // Imprime totalizador (sim/nao)
PRIVATE cIniCab     // Inibe cabecalho do grupo/empresa (sim/nao)
PRIVATE nResumo     // Imprime Resumo
PRIVATE nImpBlq     // Imprime Resumo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Testa ambiente do relatorio somente top...                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If ! PLSRelTop()
   Return
Endif    

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ajusta perguntas                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ValidPerg(cPerg)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Acessa parametros do relatorio...                                        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)

/*teste
cOpeDe     := mv_par01
cOpeAte    := mv_par02
cOpeDes    := mv_par03
nTipPes    := mv_par04
cDatDe     := mv_par05 
cDatAte    := mv_par06 
cGrupoDe   := mv_par07 
cGrupoAte  := mv_par08 
cContrDe   := mv_par09
cContrAte  := mv_par10 
cSbConDe   := mv_par11
cSbConAte  := mv_par12
cTotal     := mv_par13 
nResumo    := mv_par14
nAnaSin    := mv_par15
nImpBlq    := mv_par16 // Imprime relacao dos usuarios por motivos de bloqueios
dDtDesDe   := mv_par17
dDtDesAte  := mv_par18
cOpeOri    := mv_par19

If mv_par15 = 1
	nQtdLin     := 50
	nLimite     := 220
	cTamanho    := "G"
EndIf

cCabec1     := "Periodo Movimentacao De: "+Dtoc(cDatDe)+" a "+Dtoc(cDatAte)+"       Operadora Destino: "+Iif(Empty(cOpeDes),'Todas',cOpeDes)
*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint (padrao)                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cRel  := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

nTipo := IIF(aReturn[4]==1,15,18)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao (padrao)                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLastKey  == 27 
   Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Emite relat╒rio                                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Processa({||CABR002Imp()}, cTitulo)//Leonardo Portella - 28/03/12
//MsAguarde({|| CABR002Imp() }, cTitulo, "", .T.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da rotina                                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CABR002Imp  Ё Autor Ё Luzio Tavares      Ё Data Ё 21.02.08 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Imprime detalhe do relatorio...                            Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function CABR002Imp()

Local n_I 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local n 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local J 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local K 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

LOCAL cSQL
//LOCAL nOrdSel       := aReturn[8] 
LOCAL lIniCab       := .T.
LOCAL aUsuario      := {}
LOCAL aUsuBlq       := {}
PRIVATE cOperad  
PRIVATE cGrupEmp
PRIVATE cDescGru
PRIVATE cTipo
PRIVATE cContrat
PRIVATE cSubCon  
PRIVATE cMatric
PRIVATE pQuant     := "@E 999999"
PRIVATE nQtdTit    := 0
PRIVATE nQtdDep    := 0
PRIVATE nQtdUsu    := 0
PRIVATE nQtdTotGer := 0
PRIVATE nQtdTotTit := 0
PRIVATE nQtdTotDep := 0
PRIVATE nQtdTotUsu := 0
PRIVATE nQtdAnt    := 0
PRIVATE nQtdInc    := 0
PRIVATE nQtdExc    := 0                              
PRIVATE nQtdTotAnt := 0
PRIVATE nQtdTotInc := 0
PRIVATE nQtdTotExc := 0
PRIVATE nQtdTotTot := 0
PRIVATE nTotTitDes := 0
PRIVATE nTotDepDes := 0
PRIVATE nTotUsuDes := 0
PRIVATE ntotAntDes := 0
PRIVATE nTotIncDes := 0
PRIVATE nTotExcDes := 0
PRIVATE nTotTotDes := 0
PRIVATE nTotTit := 0
PRIVATE nTotDep := 0
PRIVATE nTotUsu := 0
PRIVATE nTotAnt := 0
PRIVATE nTotInc := 0
PRIVATE nTotExc := 0
PRIVATE nTotTot := 0 
PRIVATE aSubTot     := {}
PRIVATE aTotGer     := {}
PRIVATE aLinTit     := {}
PRIVATE aLinDep     := {}
PRIVATE aLinAgr     := {}
PRIVATE aLinTotTit  := {}
PRIVATE aLinTotDep  := {}
PRIVATE aLinTotAgr  := {}
PRIVATE aValFai     := {0,0,0,0,0,0,0}
PRIVATE aValTxt     := {}      
PRIVATE aValTotFai  := {0,0,0,0,0,0,0}
PRIVATE aValTotTxt  := {}      
PRIVATE nFaixa      := 0
PRIVATE nScan       := 0
PRIVATE pQtdTot     := "@E 999999999"
PRIVATE nVlrTit     := 0
PRIVATE nVlrdep     := 0
PRIVATE nVlrAgr     := 0
PRIVATE nVlrTotTit  := 0
PRIVATE nVlrTotdep  := 0
PRIVATE nVlrTotAgr  := 0
PRIVATE nVlrSubTot  := 0
PRIVATE cVlrSubTot
PRIVATE nVlrTotGer  := 0
PRIVATE cVlrTotGer  
PRIVATE nIdade 

//teste incio
           
cOpeDe     := mv_par01
cOpeAte    := mv_par02
cOpeDes    := mv_par03
nTipPes    := mv_par04
cDatDe     := mv_par05 
cDatAte    := mv_par06 
cGrupoDe   := mv_par07 
cGrupoAte  := mv_par08 
cContrDe   := mv_par09
cContrAte  := mv_par10 
cSbConDe   := mv_par11
cSbConAte  := mv_par12
cTotal     := mv_par13 
nResumo    := mv_par14
nAnaSin    := mv_par15
nImpBlq    := mv_par16 // Imprime relacao dos usuarios por motivos de bloqueios
dDtDesDe   := mv_par17
dDtDesAte  := mv_par18
cOpeOri    := mv_par19

If mv_par15 = 1
	nQtdLin     := 50
	nLimite     := 220
	cTamanho    := "G"
EndIf

cCabec1     := "Periodo Movimentacao De: "+Dtoc(cDatDe)+" a "+Dtoc(cDatAte)+"       Operadora Destino: "+Iif(Empty(cOpeDes),'Todas',cOpeDes)

//teste fim

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Exibe mensagem...                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//Leonardo Portella - 28/03/12 - Inicio

ProcRegua(0)

For n_I := 1 to 5
	IncProc(PLSTR0001)
Next

//MsProcTxt(PLSTR0001) 

//Leonardo Portella - 28/03/12 - Fim

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Faz filtro no arquivo de Usuarios...                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cSQL := "SELECT "
cSql += " (SELECT NVL(MAX(R_E_C_N_O_),0) FROM "+RetSQLName("BCA")+" BCA "
cSql += " WHERE BCA.D_E_L_E_T_ <> '*'  AND "
cSql += " BCA.BCA_FILIAL = '"+xFilial("BCA")+"' AND "
cSql += " BCA.BCA_TIPO = '0' AND "
cSQL += " BCA.BCA_FILIAL = BA1.BA1_FILIAL AND "
cSQL += " BCA.BCA_MATRIC = BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC AND "
cSQL += " BCA.BCA_TIPREG = BA1.BA1_TIPREG) AS BCARECNO, "
cSql += " BA1_CODINT,BA1_CODEMP,BA1_CONEMP,BA1_SUBCON,BA1_MOTBLO,BA1_VERCON,BA1_VERSUB,BA1_MATRIC, BA1_DIGITO, "
cSQL += " BA1_TIPREG,BA1_NOMUSR,BA1_DATNAS,BA1_SEXO,BA1_ESTCIV,BA1_TIPUSU,BA1_GRAUPA,BA1_DATINC,BA1_DATREP, "
cSQL += " BA1_MATANT,BA1_DATBLO,BA1_OPEDES,BA1_ESTADO "
cSQL += " FROM "+RetSQLName("BA1")+" BA1 "
cSQL += " WHERE BA1.D_E_L_E_T_ <> '*' "
cSQL += " AND BA1.BA1_FILIAL = '"+xFilial("BA1")+"' "
cSQL += " AND BA1_CODINT BETWEEN '"+cOpeDe+"' AND '"+cOpeAte+"' "
cSQL += " AND BA1_OPEORI = '"+cOpeOri+"' "
cSQL += " AND BA1.BA1_DATBLO BETWEEN '"+DtoS(dDtDesDe)+"' AND '"+DtoS(dDtDesAte)+"' "

If !empty(cOpeDes)
	cSQL += " AND BA1_OPEDES = '"+cOpeDes+"' "
Else
	cSQL += " AND BA1_OPEDES <> '"+PlsIntPad()+"' "
EndIf
cSQL += " AND BA1_CODEMP BETWEEN '"+cGrupoDe+"' AND '"+cGrupoAte+"' "
//cSQL += "BA1_DATINC <= '"+Dtos(cDatBas)+"' "
//cSQL += " AND ( BA1_DATREP BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"' OR BA1_DATBLO BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"') "
cSQL += " AND (((BA1_DATREP BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"' ) OR (BA1_DATINC BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"' and BA1_DATREP = ' ')) OR BA1_DATBLO BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"') "

If nTipPes == 2 // Pessoa Juridica
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"' " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' " 
  cSQL += " AND BA1_CONEMP <> '  ' "   
  cSQL += " AND BA1_SUBCON <> '  ' "     
Elseif nTipPes == 1 // Pessoa Fisica
  cSQL += " AND BA1_CONEMP = '  ' "   
  cSQL += " AND BA1_SUBCON = '  ' "   
Elseif nTipPes == 3 // Ambas
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"' " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' " 
Endif                                                  

/*
cSQL := "SELECT * FROM "
cSQL += "(SELECT BA1_CODINT,BA1_CODEMP,BA1_CONEMP,BA1_SUBCON,BA1_MOTBLO,BA1_VERCON,BA1_VERSUB,BA1_MATRIC,"
cSQL += "BA1_TIPREG,BA1_NOMUSR,BA1_DATNAS,BA1_SEXO,BA1_ESTCIV,BA1_TIPUSU,BA1_GRAUPA,BA1_DATINC,BA1_DATREP,"
cSQL += "BA1_MATANT,BA1_DATBLO,BA1_OPEDES, BA1_ESTADO, BCA_NIVBLQ "
cSQL += "FROM "+RetSQLName("BA1")+" BA1, "+RetSQLName("BCA")+" BCA "
cSQL += "WHERE BA1.D_E_L_E_T_ <> '*' AND "
cSQL += "BCA.D_E_L_E_T_ <> '*'  AND "
cSQL += "BA1.BA1_FILIAL = '"+xFilial("BA1")+"' AND "
cSQL += "BCA.BCA_FILIAL = '"+xFilial("BCA")+"' AND "
cSQL += "BA1_CODINT BETWEEN '"+cOpeDe+"' AND '"+cOpeAte+"' AND "
If !empty(cOpeDes)
	cSQL += "BA1_OPEDES = '"+cOpeDes+"' AND "
Else
	cSQL += "BA1_OPEDES <> '"+PlsIntPad()+"' AND "
EndIf
cSQL += "BA1_CODEMP BETWEEN '"+cGrupoDe+"' AND '"+cGrupoAte+"' AND "
//cSQL += "BA1_DATINC <= '"+Dtos(cDatBas)+"' "
cSQL += "BA1_DATREP BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"' "
If nTipPes == 2 // Pessoa Juridica
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"'   " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"'   " 
  cSQL += " AND BA1_CONEMP <> '  ' "   
  cSQL += " AND BA1_SUBCON <> '  ' "     
Elseif nTipPes == 1 // Pessoa Fisica
  cSQL += " AND BA1_CONEMP = '  ' "   
  cSQL += " AND BA1_SUBCON = '  ' "   
Elseif nTipPes == 3 // Ambas
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"' " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' " 
Endif                                                  
cSQL += " AND BA1.BA1_FILIAL = BCA.BCA_FILIAL "
cSQL += " AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC  = BCA.BCA_MATRIC "
cSQL += " AND BA1.BA1_TIPREG = BCA.BCA_TIPREG "


// VERIFICA BENEFICIARIOS EXCLUIDOS NO PERIODO, MESMO COM DATA DE REPASSE ANTES DO PERIODO
cSQL += " UNION "
cSQL += "SELECT BA1_CODINT,BA1_CODEMP,BA1_CONEMP,BA1_SUBCON,BA1_MOTBLO,BA1_VERCON,BA1_VERSUB,BA1_MATRIC,"
cSQL += "BA1_TIPREG,BA1_NOMUSR,BA1_DATNAS,BA1_SEXO,BA1_ESTCIV,BA1_TIPUSU,BA1_GRAUPA,BA1_DATINC,BA1_DATREP,"
cSQL += "BA1_MATANT,BA1_DATBLO,BA1_OPEDES,BA1_ESTADO,BCA_NIVBLQ "
cSQL += "FROM "+RetSQLName("BA1")+" BA1, "+RetSQLName("BCA")+" BCA "
cSQL += "WHERE BA1.D_E_L_E_T_ <> '*' AND "
cSQL += "BCA.D_E_L_E_T_ <> '*'  AND "
cSQL += "BA1_FILIAL = '"+xFilial("BA1")+"' AND "
cSQL += "BCA.BCA_FILIAL = '"+xFilial("BCA")+"' AND "
cSQL += "BA1_CODINT BETWEEN '"+cOpeDe+"' AND '"+cOpeAte+"' AND "
If !empty(cOpeDes)
	cSQL += "BA1_OPEDES = '"+cOpeDes+"' AND "
Else
	cSQL += "BA1_OPEDES <> '"+PlsIntPad()+"' AND "
EndIf
cSQL += "BA1_CODEMP BETWEEN '"+cGrupoDe+"' AND '"+cGrupoAte+"' AND "
//cSQL += "BA1_DATINC <= '"+Dtos(cDatBas)+"' "
cSQL += "BA1_DATBLO BETWEEN '"+Dtos(cDatDe)+"' AND '"+Dtos(cDatAte)+"' "
If nTipPes == 2 // Pessoa Juridica
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"'   " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"'   " 
  cSQL += " AND BA1_CONEMP <> '  ' "   
  cSQL += " AND BA1_SUBCON <> '  ' "     
Elseif nTipPes == 1 // Pessoa Fisica
  cSQL += " AND BA1_CONEMP = '  ' "   
  cSQL += " AND BA1_SUBCON = '  ' "   
Elseif nTipPes == 3 // Ambas
  cSQL += " AND BA1_CONEMP BETWEEN '"+cContrDe+"' AND '"+cContrAte+"' " 
  cSQL += " AND BA1_SUBCON BETWEEN '"+cSbConDe+"' AND '"+cSbConAte+"' " 
Endif                                                  
cSQL += " AND BA1.BA1_FILIAL = BCA.BCA_FILIAL "
cSQL += " AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC = BCA.BCA_MATRIC "
cSQL += " AND BA1.BA1_TIPREG = BCA.BCA_TIPREG "
*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Se houver filtro executa parse para converter expressoes adv para SQL    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If ! Empty(aReturn[7])
   cSQL += " AND (" + PLSParSQL(aReturn[7])+" ) "
Endif   
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё De acordo com a ordem....                                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//cSQL += " ) " 
//If nOrdSel == 1 //codigo
      cSQL += "ORDER BY BA1_CODINT,BA1_OPEDES,BA1_CODEMP,BA1_MATRIC,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB"  
//Elseif nOrdSel == 2  //nome
//      cSQL += "ORDER BY BA1_CODINT,BA1_OPEDES,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_VERSUB"  
//Endif                          

//memowrit("C:\CABR002.SQL",cSQL)

If Select("BA1TRB") > 0
   CABR001->(DbCloseArea())
EndIf

PLSQuery(cSQL,"BA1TRB")
                 
//Leonardo Portella - 28/03/12 - Inicio

n_Count := 0
COUNT TO n_Count
ProcRegua(n_Count)
c_Tot	:= AllTrim(Transform(n_Count,'@E 999,999,999'))
n_Count := 1

//Leonardo Portella - 28/03/12 - Fim

BA1TRB->(DbGotop())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicio da impressao dos detalhes...                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While ! BA1TRB->(Eof())
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se foi abortada a impressao...                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If Interrupcao(lAbortPrint)
		nLi ++
		@nLi,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime cabecalho...                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nLi > nQtdLin
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
		If nAnaSin = 1
			@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
		EndIf
		++nLi
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Atribuo valor as variaveis de controle...                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cOperad  := BA1TRB->BA1_CODINT
	cOpeDes  := BA1TRB->BA1_OPEDES
	
	BA0->(DbSetOrder(1))// BA0_CODINT
	BA0->(DbSeek(xFilial("BA0")+BA1TRB->(BA1_OPEDES)))
	If nResumo = 1   // Imprime Grupo/Empresa = Sim
		@ ++nLi, 00 pSay cOpeDes+" - "+BA0->BA0_NOMINT
		nLi ++
	EndIf
	
	While ! BA1TRB->(Eof()) .And. BA1TRB->(BA1_CODINT+BA1_OPEDES) == cOperad+cOpeDes
	
		//Leonardo Portella - 28/03/12
		IncProc("Usr.(" + AllTrim(Transform(n_Count,'@E 999,999,999')) + "/" + c_Tot + "): "+BA1TRB->BA1_CODINT+"."+BA1TRB->BA1_CODEMP+"."+BA1TRB->BA1_CONEMP+"."+BA1TRB->BA1_SUBCON+"...")
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciono e Imprime grupo/empresa...                               Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//		BG9->(DbSetOrder(1))// BG9_CODINT + BG9_CODIGO + BG9_TIPO
//		BG9->(DbSeek(xFilial("BG9")+BA1TRB->(BA1_CODINT+BA1_CODEMP)))
        Posicione("BG9",1,xFilial("BG9")+BA1TRB->(BA1_CODINT+BA1_CODEMP),"BG9_DESCRI")

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Atribuo valor as variaveis de controle...                                Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cGrupEmp := BA1TRB->BA1_CODEMP
        cDescGru := Substr(BG9->BG9_DESCRI,1,40)
		IIF(BG9->BG9_TIPO=="2","Pessoa Juridica","Pessoa Fisica")
		
		While ! BA1TRB->(Eof()) .And. BA1TRB->(BA1_CODINT+BA1_OPEDES+BA1_CODEMP) == cOperad+cOpeDes+cGrupEmp
			cContrat := BA1TRB->(BA1_CONEMP+BA1_VERCON)
			cSubCon  := BA1TRB->(BA1_SUBCON+BA1_VERSUB)
			cTipo    := BG9->BG9_TIPO
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Posiciono no Contrato, se for pessoa juridica...                   Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If ! Empty(cContrat)   // Pessoa Juridica
				BT5->(DbSetOrder(1))// BT5_CODINT + BT5_CODIGO + BT5_NUMCON + BT5_VERSAO
				BT5->(DbSeek(xFilial("BT5")+BA1TRB->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)))
				BQC->(DbSetOrder(1))// BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
				BQC->(DbSeek(xFilial("BQC")+BA1TRB->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
			Endif
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Exibe mensagem...                                                  Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			//Leonardo Portella - 28/03/12                                                                                      
			IncProc("Usr.(" + AllTrim(Transform(++n_Count,'@E 999,999,999')) + "/" + c_Tot + "): "+BA1TRB->BA1_CODINT+"."+BA1TRB->BA1_CODEMP+"."+BA1TRB->BA1_CONEMP+"."+BA1TRB->BA1_SUBCON+"...")
			//MsProcTXT("Usuario: "+BA1TRB->BA1_CODINT+"."+BA1TRB->BA1_CODEMP+"."+BA1TRB->BA1_CONEMP+"."+BA1TRB->BA1_SUBCON+"...")
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Atribuo valor as variaveis de controle...                                Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			//					// Total de Inclusoes
			//					If Dtos(BA1TRB->BA1_DATINC) >= Dtos(cDatDe) .And. Dtos(BA1TRB->BA1_DATINC) <= Dtos(cDatAte)
			//						nQtdInc ++
			//					Endif
			// Total de Repasses
			If Dtos(BA1TRB->BA1_DATREP) >= Dtos(cDatDe) .And. Dtos(BA1TRB->BA1_DATREP) <= Dtos(cDatAte)
				nQtdInc ++
				//						nQtdRep ++
			Endif
			// Total de Exclusoes
			If Dtos(BA1TRB->BA1_DATBLO) >= Dtos(cDatDe) .And. Dtos(BA1TRB->BA1_DATBLO) <= Dtos(cDatAte)
				nQtdExc ++
			Endif
			// Total de Usuarios Antes
			If  Dtos(BA1TRB->BA1_DATINC) < Dtos(cDatDe) .And. Empty(BA1TRB->BA1_DATBLO) .Or.;
				(Dtos(BA1TRB->BA1_DATINC) < Dtos(cDatDe) .And. Dtos(BA1TRB->BA1_DATBLO) >= Dtos(cDatDe))
				nQtdAnt ++
			Endif
			// Total de Usuarios Efetivos
			If  Dtos(BA1TRB->BA1_DATINC) <= Dtos(cDatAte) .And. Empty(BA1TRB->BA1_DATBLO) .Or.;
				(Dtos(BA1TRB->BA1_DATINC) <= Dtos(cDatAte) .And. Dtos(BA1TRB->BA1_DATBLO) > Dtos(cDatAte))
				If BA1TRB->BA1_TIPUSU == "T"
					nQtdTit ++
				Elseif BA1TRB->BA1_TIPUSU $ "D,A"
					nQtdDep ++
				Endif
				nQtdUsu ++
			Endif
			
			nQtdTotGer ++

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Imprime usuario, se for relatorio analitico...                     Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			nIdade := Calc_Idade(dDataBase,BA1TRB->BA1_DATNAS)

			If nImpBlq == 1 // Imprime os usuarios bloqueados separados pelo motivo
				aadd(aUsuBlq,{BA1TRB->BA1_MOTBLO,;        //				BA1TRB->BA1_CODDES,;
				BA1TRB->BA1_DATBLO,;
				BA1TRB->BA1_CODINT,;
				BA1TRB->BA1_CODEMP,;
				BA1TRB->BA1_MATRIC,;
				BA1TRB->BA1_TIPREG,;
				BA1TRB->BA1_MATANT,;
				Substr(BA1TRB->BA1_NOMUSR,1,40),;
				Substr(Posicione("BIH",1,xFilial("BIH")+BA1TRB->BA1_TIPUSU,"BIH_DESCRI"),1,15),;
				Substr(Posicione("BRP",1,xFilial("BRP")+BA1TRB->BA1_GRAUPA,"BRP_DESCRI"),1,15),;
				BA1TRB->BA1_DATREP,;
				BA1TRB->BA1_DATBLO})
			EndIf	
			
			If nAnaSin == 1 // Imprime os usuarios do contrato
				aadd(aUsuario,{BA1TRB->BA1_CODINT,;
				BA1TRB->BA1_CODEMP,;
				BA1TRB->BA1_MATRIC,;
				BA1TRB->BA1_TIPREG,;
				BA1TRB->BA1_MATANT,;
				Substr(BA1TRB->BA1_NOMUSR,1,40),;
				BA1TRB->BA1_DATNAS,;
				Iif(!Empty(BA1TRB->BA1_SEXO),Substr(X3COMBO("BA1_SEXO",BA1TRB->BA1_SEXO),1,3),Space(03)),;
				Substr(Posicione("SX5",1,xFilial("SX5")+"33"+BA1TRB->BA1_ESTCIV,"X5_DESCRI"),1,15),;
				Substr(Posicione("BIH",1,xFilial("BIH")+BA1TRB->BA1_TIPUSU,"BIH_DESCRI"),1,15),;
				Substr(Posicione("BRP",1,xFilial("BRP")+BA1TRB->BA1_GRAUPA,"BRP_DESCRI"),1,15),;
				BA1TRB->BA1_DATINC,;
				BA1TRB->BA1_DATREP,;
				BA1TRB->BA1_DATBLO,;
				BA1TRB->BA1_MOTBLO,;
				BA1TRB->BA1_ESTADO,;
				nIdade,;
				BA1TRB->BCARECNO,;
				BA1TRB->BA1_DIGITO})
			EndIf
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Atribuo valores aos totalizadores...                                     Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If cTotal == 1 // Imprime Resumo
				nFaixa := RetFai(nIdade)
				nScan  := aScan(aSubTot,{|x|x[1]==Alltrim(BA1TRB->BA1_TIPUSU) .AND. x[2]==Alltrim(BA1TRB->BA1_SEXO) .And. x[3]==nFaixa })
				If nScan == 0
					aadd(aSubTot,{Alltrim(BA1TRB->BA1_TIPUSU),Alltrim(BA1TRB->BA1_SEXO),nFaixa,1})
				Else
					aSubTot[nScan,4] := aSubTot[nScan,4] + 1
				Endif
				nScan  := aScan(aTotGer,{|x|x[1]==Alltrim(BA1TRB->BA1_TIPUSU) .AND. x[2]==Alltrim(BA1TRB->BA1_SEXO) .And. x[3]==nFaixa })
				If nScan == 0
					aadd(aTotGer,{Alltrim(BA1TRB->BA1_TIPUSU),Alltrim(BA1TRB->BA1_SEXO),nFaixa,1})
				Else
					aTotGer[nScan,4] := aTotGer[nScan,4] + 1
				Endif
			Endif
			BA1TRB->(DbSkip())
		EndDo
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё verifica proxima pagina...                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nLi > nQtdLin
			nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
			If nAnaSin = 1
				@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
			EndIf
			++nLi
		Endif
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprimo Grupo-Empresa...                                                 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nResumo = 1 .or. nAnaSin = 1
			If !Empty(cContrat)  // Pessoa Juridica
				@ ++nLi, nColuna pSay cGrupEmp+Space(02)+Substr(BG9->BG9_DESCRI,1,40)+;
				Space(16)+space(16)+Transform(nQtdTotGer,pQuant)+Space(2)+;
				Transform(nQtdAnt,pQuant)+Space(01)+;
				Transform(nQtdExc,pQuant)+Space(01)+Transform(nQtdInc,pQuant)+Space(01)+;
				Transform(nQtdTit,pQuant)+Space(01)+Transform(nQtdDep,pQuant)+Space(02)+;
				Transform(nQtdUsu,pQuant)
			Endif
			If Empty(cContrat) // Pessoa Fisica
				@ ++nLi, nColuna pSay cGrupEmp+Space(2)+Substr(BG9->BG9_DESCRI,1,40)+" - "+;
				IIF(BG9->BG9_TIPO=="2","Pessoa Juridica","Pessoa Fisica")+;
				Space(16)+Transform(nTotTotDes,pQuant)+Space(02)+Transform(nTotAntDes,pQuant)+Space(01)+;
				Transform(nTotExcDes,pQuant)+Space(01)+Transform(nTotIncDes,pQuant)+Space(01)+;
				Transform(nTotTitDes,pQuant)+Space(01)+Transform(nTotDepDes,pQuant)+Space(02)+;
				Transform(nTotUsuDes,pQuant)
			Endif
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime usuario, se for relatorio analitico...                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nAnaSin == 1 .and. len(aUsuario) > 0 //.and. nResumo = 1  // Analitico
			/*
			"          10        20        30        40        50        60        70        80        90        100       110       120       130"
			"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
			"Mat. Antiga            Nome                                      Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio"
			 1234.1234.123456-12-9  1234567890123456789012345678901234567890  11/11/11 Mas  Solteiro       dependente     
			*/
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё verifica proxima pagina...                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			For n=1 to Len(aUsuario)

				If nLi > nQtdLin
					nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
					@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
					++nLi
				Endif
//				@ ++nLi, nColuna pSay Iif(nOrdSel <> 3, (aUsuario[n,1]+"."+aUsuario[n,2]+"."+aUsuario[n,3]+"-"+aUsuario[n,4]),aUsuario[n,5])
				@ ++nLi, nColuna pSay aUsuario[n,1]+"."+aUsuario[n,2]+"."+aUsuario[n,3]+"-"+aUsuario[n,4]+"-"+aUsuario[n,19]
				@ nLi, 023 pSay Substr(aUsuario[n,6],1,40)
				@ nLi, 064 pSay Dtoc(aUsuario[n,7])
				@ nLi, 073 pSay aUsuario[n,8]
				@ nLi, 078 pSay aUsuario[n,9]
				@ nLi, 092 pSay aUsuario[n,10]
				@ nLi, 108 pSay aUsuario[n,11]
				@ nLi, 124 pSay Dtoc(aUsuario[n,12])
				@ nLi, 136 pSay Dtoc(aUsuario[n,13])
				@ nLi, 148 pSay Dtoc(aUsuario[n,14])
			   If aUsuario[n,18] > 0
			      	@ nLi, 159 pSay Posicione("BG3",1,xFilial("BG3")+aUsuario[n,15],"BG3_DESBLO")
		      EndIf
			Next
			aUsuario := {}
			++nLi
		Endif
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Zero totalizadores...                                                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nQtdTotTit += nQtdTit
		nQtdTotDep += nQtdDep
		nQtdTotUsu += nQtdUsu
		nQtdTotAnt += nQtdAnt
		nQtdTotInc += nQtdInc
		nQtdTotExc += nQtdExc
		nQtdTotTot += nQtdTotGer
		nTotTit    += nQtdTit
		nTotDep    += nQtdDep
		nTotUsu    += nQtdUsu
		nTotAnt    += nQtdAnt
		nTotInc    += nQtdInc
		nTotExc    += nQtdExc
		nTotTot    += nQtdTotGer
		nTotTitDes += nQtdTit
		nTotDepDes += nQtdDep
		nTotUsuDes += nQtdUsu
		nTotAntDes += nQtdAnt
		nTotIncDes += nQtdInc
		nTotExcDes += nQtdExc
		nTotTotDes += nQtdTotGer
		nQtdTit    := 0
		nQtdDep    := 0
		nQtdUsu    := 0
		nQtdAnt    := 0
		nQtdInc    := 0
		nQtdExc    := 0
		nQtdTotGer := 0
		/*
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Total do Grupo/Empresa ...                                 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If ! Empty(cContrat) .And. nResumo == 1 // Pessoa Juridica
		@ ++nLi,nColuna pSay Replicate("-",nLimite)
		@ ++nLi, nColuna pSay "Total:"+Space(72)+Transform(nQtdTotTot,pQuant)+Space(02)+Transform(nQtdTotAnt,pQuant)+Space(01)+;
		Transform(nQtdTotExc,pQuant)+Space(01)+Transform(nQtdTotInc,pQuant)+Space(01)+;
		Transform(nQtdTotTit,pQuant)+Space(01)+Transform(nQtdTotDep,pQuant)+Space(02)+;
		Transform(nQtdTotUsu,pQuant)
		Endif
		If Empty(cContrat) // Pessoa Fisica
		@ ++nLi, nColuna pSay cGrupEmp+Space(2)+Substr(BG9->BG9_DESCRI,1,40)+" - "+;
		IIF(BG9->BG9_TIPO=="2","Pessoa Juridica","Pessoa Fisica")+;
		Space(16)+Transform(nQtdTotTot,pQuant)+Space(02)+Transform(nQtdTotAnt,pQuant)+Space(01)+;
		Transform(nQtdTotExc,pQuant)+Space(01)+Transform(nQtdTotInc,pQuant)+Space(01)+;
		Transform(nQtdTotTit,pQuant)+Space(01)+Transform(nQtdTotDep,pQuant)+Space(02)+;
		Transform(nQtdTotUsu,pQuant)
		Endif
		If cIniCab == 1
		nLi ++
		@ ++nLi,nColuna pSay Replicate("=",nLimite)
		Endif
		*/
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Zero totawlizadores...                                                    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nQtdTotTit  := 0
		nQtdTotDep  := 0
		nQtdTotUsu  := 0
		nQtdTotAnt  := 0
		nQtdTotInc  := 0
		nQtdTotExc  := 0
		nQtdTotTot  := 0
	EndDo
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime Total de Beneficiarios na da Operadora de Destino ...      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If ! Empty(cContrat) //.And. cTotal == 1 // Pessoa Juridica
		@ nLi, nColuna pSay Iif(nResumo=1,"Total:"+Space(72),cOpeDes+" - "+BA0->BA0_NOMINT+Space(16))+Transform(nTotTotDes,pQuant)+Space(02)+Transform(nTotAntDes,pQuant)+Space(01)+;
		Transform(nTotExcDes,pQuant)+Space(01)+Transform(nTotIncDes,pQuant)+Space(01)+;
		Transform(nTotTitDes,pQuant)+Space(01)+Transform(nTotDepDes,pQuant)+Space(02)+;
		Transform(nTotUsuDes,pQuant)
		++nLi
//		++nLi
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Zero totalizadores...                                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nTotTitDes  := 0
	nTotDepDes  := 0
	nTotUsuDes  := 0
	nTotAntDes  := 0
	nTotIncDes  := 0
	nTotExcDes  := 0
	nTotTotDes  := 0
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Atribuo valores do Sub-total...                                          Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If cTotal == 1 // Imprime Resumo
		//Titular
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinTit,fPegaVal(aSubTot,"T",Str(K),J))
				nVlrTit := nVlrTit + Val(fPegaVal(aSubTot,"T",Str(K),J))
				aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"T",Str(K),J))
			Next K
		Next J
		aadd(aLinTit,Transform(nVlrTit,pQtdTot))
		
		//Depedente
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinDep,fPegaVal(aSubTot,"D",Str(K),J))
				nVlrDep := nVlrDep + Val(fPegaVal(aSubTot,"D",Str(K),J))
				aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"D",Str(K),J))
			Next K
		Next J
		aadd(aLinDep,Transform(nVlrDep,pQtdTot))
		
		//Agregado
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinAgr,fPegaVal(aSubTot,"A",Str(K),J))
				nVlrAgr := nVlrAgr + Val(fPegaVal(aSubTot,"A",Str(K),J))
				aValFai[J] := aValFai[J] + Val(fPegaVal(aSubTot,"A",Str(K),J))
			Next K
		Next J
		aadd(aLinAgr,Transform(nVlrAgr,pQtdTot))
		
		For J := 1 to 7
			aadd(aValTxt,Transform(aValFai[J],pQtdTot))
		Next
		
		nVlrSubTot := nVlrTit+nVlrDep+nVlrAgr
		cVlrSubTot := Transform(nVlrSubTot,pQtdTot)
		
		aadd(aValTxt,cVlrSubTot)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Sub-Total por grupo/empresa...                             Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		ProcSubTot()
		
		aSubTot    := {}
		aLinTit    := {}
		aLinDep    := {}
		aLinAgr    := {}
		aValFai    := {0,0,0,0,0,0,0}
		aValTxt    := {}
		nVlrTit    := 0
		nVlrDep    := 0
		nVlrAgr    := 0
		nVlrSubTot := 0
	Endif
Enddo

If nTotTot > 0
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime Total Geral de Beneficiarios Repassados...                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If ! Empty(cContrat) //.And. cTotal == 1 // Pessoa Juridica
		@ ++nLi,nColuna pSay Replicate("-",nLimite)
		@ ++nLi, nColuna pSay "Total:"+Space(72)+Transform(nTotTot,pQuant)+Space(02)+Transform(nTotAnt,pQuant)+Space(01)+;
		Transform(nTotExc,pQuant)+Space(01)+Transform(nTotInc,pQuant)+Space(01)+;
		Transform(nTotTit,pQuant)+Space(01)+Transform(nTotDep,pQuant)+Space(02)+;
		Transform(nTotUsu,pQuant)
	Endif
	If Empty(cContrat) // Pessoa Fisica
		@ ++nLi, nColuna pSay cGrupEmp+Space(2)+Substr(BG9->BG9_DESCRI,1,40)+" - "+;
		IIF(BG9->BG9_TIPO=="2","Pessoa Juridica","Pessoa Fisica")+;
		Space(16)+Transform(nTotTot,pQuant)+Space(02)+Transform(nTotAnt,pQuant)+Space(01)+;
		Transform(nTotExc,pQuant)+Space(01)+Transform(nTotInc,pQuant)+Space(01)+;
		Transform(nTotTit,pQuant)+Space(01)+Transform(nTotDep,pQuant)+Space(02)+;
		Transform(nTotUsu,pQuant)
	Endif
	If cTotal == 1 // Imprime Resumo
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Atribuo valores do Total Geral...                                        Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		//Titular
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinTotTit,fPegaVal(aTotGer,"T",Str(K),J))
				nVlrTotTit := nVlrTotTit + Val(fPegaVal(aTotGer,"T",Str(K),J))
				aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"T",Str(K),J))
			Next K
		Next J
		aadd(aLinTotTit,Transform(nVlrTotTit,pQtdTot))
		
		//Depedente
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinTotDep,fPegaVal(aTotGer,"D",Str(K),J))
				nVlrTotDep := nVlrTotDep + Val(fPegaVal(aTotGer,"D",Str(K),J))
				aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"D",Str(K),J))
			Next K
		Next J
		aadd(aLinTotDep,Transform(nVlrTotDep,pQtdTot))
		
		//Agregado
		For J := 1 to 7
			For K := 1 to 2
				aadd(aLinTotAgr,fPegaVal(aTotGer,"A",Str(K),J))
				nVlrTotAgr := nVlrTotAgr + Val(fPegaVal(aTotGer,"A",Str(K),J))
				aValTotFai[J] := aValTotFai[J] + Val(fPegaVal(aTotGer,"A",Str(K),J))
			Next K
		Next J
		aadd(aLinTotAgr,Transform(nVlrTotAgr,pQtdTot))
		
		For J := 1 to 7
			aadd(aValTotTxt,Transform(aValTotFai[J],pQtdTot))
		Next
		
		nVlrTotGer := nVlrTotTit+nVlrTotDep+nVlrTotAgr
		cVlrTotGer := Transform(nVlrTotGer,pQtdTot)
		
		aadd(aValTotTxt,cVlrTotGer)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime Total Geral ...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		ProcTotGer()
	Endif
	
	//	If cIniCab == 1
	//		nLi ++
	//		@ ++nLi,nColuna pSay Replicate("=",nLimite)
	//	Endif
EndIf

If nImpBlq == 1 // Imprime os usuarios bloqueados separados pelo motivo
//	ImpBloq()
EndIf	

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape do relatorio...                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//Roda(0,space(10),cTamanho)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha arquivo...                                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA1TRB->(DbCloseArea())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1 
    Set Printer To
//    Commit
    Ourspool(cRel)
End
//MS_FLUSH()             // Libera fila de relatorios em spool
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim do Relat╒rio                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё ValidPerg Ё Autor Ё Luzio Tavares        Ё Data Ё 08.02.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
/*/

Static Function ValidPerg()

LOCAL aRegs	:= {}

//Leonardo Portella - 28/03/12 - Inicio - Correcao dos F3, pois nenhum estava funcionando no relatorio e estava fazendo com que o usuario parametrizasse errado.
aHelp := {"Informe a Operadora Saude Inicial"}
PutSX1(cPerg , "01" , "Operadora Saude De ?","","","mv_ch1","C",4,0,0,"G",""	,"B89PLS"	,"","","mv_par01","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Operadora Saude Final"}
PutSX1(cPerg , "02" , "Operadora Saude Ate ?","","","mv_ch2","C",4,0,0,"G",""	,"B89PLS"	,"","","mv_par02","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Operadora Destino"}
PutSX1(cPerg , "03" , "Operadora Destino ?","","","mv_ch3","C",4,0,0,"G",""	,"B89PLS"	,"","","mv_par03","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Tipo de Contrato"}
PutSX1(cPerg , "04" , "Tipo de Contrato ?","","","mv_ch4","N",1,0,0,"C",""	,""	,"","","mv_par04","Fisica","","","","Juridica","","","Todas","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Data Repasse Inicial"}
PutSX1(cPerg , "05" , "Data Repasse De ?","","","mv_ch5","D",8,0,0,"G",""	,""	,"","","mv_par05","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Data Repasse Final"}
PutSX1(cPerg , "06" , "Data Repasse Ate ?","","","mv_ch6","D",8,0,0,"G",""	,""	,"","","mv_par06","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Grupo/Empresa De Inicial"}
PutSX1(cPerg , "07" , "Grupo/Empresa De ?","","","mv_ch7","C",4,0,0,"G",""	,"B7APLS"	,"","","mv_par07","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Grupo/Empresa De Final"}
PutSX1(cPerg , "08" , "Grupo/Empresa De ?","","","mv_ch8","C",4,0,0,"G",""	,"B7APLS"	,"","","mv_par08","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Contrato Inicial"}
PutSX1(cPerg , "09" , "Contrato De ?","","","mv_ch9","C",12,0,0,"G",""	,"B7BPLS"	,"","","mv_par09","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Contrato Final"}
PutSX1(cPerg , "10" , "Contrato Ate ?","","","mv_cha","C",12,0,0,"G",""	,"B7BPLS"	,"","","mv_par10","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Subcontrato Inicial"}
PutSX1(cPerg , "11" , "Subcontrato De ?","","","mv_chb","C",9,0,0,"G",""	,"B7CPLS"	,"","","mv_par11","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe o Subcontrato Final"}
PutSX1(cPerg , "12" , "Subcontrato Ate ?","","","mv_chc","C",9,0,0,"G",""	,"B7CPLS"	,"","","mv_par12","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe se Imprime Resumo"}
PutSX1(cPerg , "13" , "Imprime Resumo ?","","","mv_chd","N",1,0,0,"C",""	,""	,"","","mv_par13","Sim","","","","Nao","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe se Imprime Grupo/Empr."}
PutSX1(cPerg , "14" , "Imprime Grupo/Empr. ?","","","mv_che","N",1,0,0,"C",""	,""	,"","","mv_par14","Sim","","","","Nao","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe se Imprime Beneficiarios"}
PutSX1(cPerg , "15" , "Imprime Beneficiarios ?","","","mv_chf","N",1,0,0,"C",""	,""	,"","","mv_par15","Sim","","","","Nao","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe se Imprime Benef. Bloqueados"}
PutSX1(cPerg , "16" , "Imprime Benef. Bloqueados ?","","","mv_chg","N",1,0,0,"C",""	,""	,"","","mv_par16","Sim","","","","Nao","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Data Desligamento Inicial"}
PutSX1(cPerg , "17" , "Data Desligamento De ?","","","mv_chh","D",8,0,0,"G",""	,""	,"","","mv_par17","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Data Desligamento Final"}
PutSX1(cPerg , "18" , "Data Desligamento Ate ?","","","mv_chi","D",8,0,0,"G","",""	,"","","mv_par18","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {"Informe a Operadora Origem"}
PutSX1(cPerg , "19" , "Operadora Origem ?","","","mv_chj","C",4,0,0,"G",""	,"B89PLS"	,"","","mv_par19","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

/*
aadd(aRegs,{cPerg,"01","Operadora Saude De ?        ","","","mv_ch1","C", 4,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"02","Operadora Saude Ate ?       ","","","mv_ch2","C", 4,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"03","Operadora Destino ?         ","","","mv_ch3","C", 4,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
aadd(aRegs,{cPerg,"04","Tipo de Contrato ?          ","","","mv_ch4","N", 1,0,0,"C","","mv_par04","Fisica","","","","","Juridica","","","","","Todas","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Data Repasse De ?           ","","","mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"06","Data Repasse Ate ?          ","","","mv_ch6","D", 8,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Grupo/Empresa De ?          ","","","mv_ch7","C", 4,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"08","Grupo/Empresa Ate ?         ","","","mv_ch8","C", 4,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS"})
aadd(aRegs,{cPerg,"09","Contrato De ?               ","","","mv_ch9","C",12,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"10","Contrato Ate ?              ","","","mv_cha","C",12,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","","B7BPLS"})
aadd(aRegs,{cPerg,"11","Subcontrato De ?            ","","","mv_chb","C", 9,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"12","Subcontrato Ate ?           ","","","mv_chc","C", 9,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","","B7CPLS"})
aadd(aRegs,{cPerg,"13","Imprime Resumo ?            ","","","mv_chd","N", 1,0,0,"C","","mv_par13","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"14","Imprime Grupo/Empr. ?       ","","","mv_che","N", 1,0,0,"C","","mv_par14","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"15","Imprime Beneficiarios ?     ","","","mv_chf","N", 1,0,0,"C","","mv_par15","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Imprime Benef. Bloqueados ? ","","","mv_chg","N", 1,0,0,"C","","mv_par16","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"17","Data Desligamento De ?      ","","","mv_chh","D", 8,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"18","Data Desligamento Ate       ","","","mv_chi","D", 8,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"19","Operadora Origem ?          ","","","mv_chj","C", 4,0,0,"G","","mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS"})
		                                                                                                                                                                   
PlsVldPerg( aRegs )
*/

//Leonardo Portella - 28/03/12 - Fim
    
Return    

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё RetFai    Ё Autor Ё Luzio Tavares        Ё Data Ё 28.02.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Retorna a faixa etaria do usuario                          Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function RetFai(nIdade)

BL9->(DbGoTop())
While ! BL9->(Eof())
   If nIdade <= BL9->BL9_IDADEF
     nFaixa := Val(BL9->BL9_SEQUEN)
     Exit
   Endif
   BL9->(DbSkip())
Enddo

Return(nFaixa)
          
/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё fPegaVal  Ё Autor Ё Luzio Tavares        Ё Data Ё 29.02.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Retorna valor de cada faixa                                Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function fPegaVal(aSubTot,cTipUsu,cSexo,nFaixa)

Local nScan
nScan := aScan(aSubTot,{|x|x[1]==Alltrim(cTipUsu) .AND. x[2]==Alltrim(cSexo) .And. x[3]==nFaixa})
If nScan == 0
   Return(Transform(0,pQuant))
Else
   Return(Transform(aSubTot[nScan,4],pQuant))   
Endif

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁProcSubTotЁ Autor Ё Luzio Tavares         Ё Data Ё26.02.2008Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁProcessa Sub-Total                                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
Static Function ProcSubTot()       

LOCAL	aL		:=	LayOutSubT()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime cabecalho...                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	If nAnaSin = 1
		@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
	EndIf	
	++nLi
Endif

FmtLin({},aL[01],,,@nLi)
FmtLin({cOperad,cGrupEmp,cDescGru},aL[02],,,@nLi)
FmtLin({},aL[03],,,@nLi)
FmtLin({},aL[04],,,@nLi)
FmtLin({},aL[05],,,@nLi)
FmtLin({},aL[06],,,@nLi)
FmtLin({},aL[07],,,@nLi)
FmtLin({},aL[08],,,@nLi)
FmtLin({},aL[09],,,@nLi)
FmtLin(aLinTit,aL[10],,,@nLi)      
FmtLin({},aL[11],,,@nLi)
FmtLin(aLinDep,aL[12],,,@nLi)      
FmtLin({},aL[13],,,@nLi)
FmtLin(aLinAgr,aL[14],,,@nLi)      
FmtLin({},aL[15],,,@nLi)
FmtLin(aValTxt,aL[16],,,@nLi)
FmtLin({},aL[17],,,@nLi)

Return()

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁProcTotGerЁ Autor Ё Luzio Tavares         Ё Data Ё26.02.2008Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁProcessa Total Geral                                        Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
Static Function ProcTotGer()

LOCAL	aL		:=	LayOutTotG()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime cabecalho...                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLi > nQtdLin
	nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
	If nAnaSin = 1
		@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
	EndIf	
	++nLi
Endif
          
FmtLin({},aL[01],,,@nLi)
FmtLin({cOpeDe,cGrupoDe,"",cGrupoAte},aL[02],,,@nLi)
FmtLin({},aL[03],,,@nLi)
FmtLin({},aL[04],,,@nLi)
FmtLin({},aL[05],,,@nLi)
FmtLin({},aL[06],,,@nLi)
FmtLin({},aL[07],,,@nLi)
FmtLin({},aL[08],,,@nLi)
FmtLin({},aL[09],,,@nLi)
FmtLin(aLinTotTit,aL[10],,,@nLi)      
FmtLin({},aL[11],,,@nLi)
FmtLin(aLinTotDep,aL[12],,,@nLi)      
FmtLin({},aL[13],,,@nLi)
FmtLin(aLinTotAgr,aL[14],,,@nLi)      
FmtLin({},aL[15],,,@nLi)
FmtLin(aValTotTxt,aL[16],,,@nLi)
FmtLin({},aL[17],,,@nLi)

Return()

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁLayOutSubTЁ Autor Ё Luzio Tavares         Ё Data Ё26.02.0208Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁMonta Lay-Out do sub-total                                  Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
Static Function LayOutSubT()

Local aL := Array(17)

aL[01]:="+=========================================================================================================================+"
aL[02]:="| Resumo do Grupo/Empresa: ####-#### - ############################################                                       |"
aL[03]:="+=========================================================================================================================+"
aL[04]:="|                                             Faixas Etarias - Padrao ANS                                                 |"
aL[05]:="+=========================================================================================================================+"
aL[06]:="| Idade     |   0  - 17   |   18 - 29   |   30 - 39   |   40 - 49   |   50 - 59   |   60 - 69   |  70 - 999   |  TOTAIS   |"
aL[07]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[08]:="| Sexo      |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |           |"
aL[09]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[10]:="| Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[11]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[12]:="| Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[13]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[14]:="| Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[15]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[16]:="| TOTAIS    |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  | ######### |"
aL[17]:="+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"
Return(aL)

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁLayOutTotGЁ Autor Ё Luzio Tavares         Ё Data Ё26.02.2008Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁMonta Lay-Out do total geral                                Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
Static Function LayOutTotG()

Local aL := Array(17)

aL[01]:="+=========================================================================================================================+"
aL[02]:="| Resumo Geral do Relatorio  --->>  Grupo/Empresa: ####-#### a ####-####                                                  |"
aL[03]:="+=========================================================================================================================+"
aL[04]:="|                                             Faixas Etarias - Padrao ANS                                                 |"
aL[05]:="+=========================================================================================================================+"
aL[06]:="| Idade     |   0  - 17   |   18 - 29   |   30 - 39   |   40 - 49   |   50 - 59   |   60 - 69   |  70 - 999   |  TOTAIS   |"
aL[07]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[08]:="| Sexo      |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |  M   |  F   |           |"
aL[09]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[10]:="| Titular   |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[11]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[12]:="| Dependente|######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[13]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[14]:="| Agregado  |######|######|######|######|######|######|######|######|######|######|######|######|######|######| ######### |"
aL[15]:="+-----------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+-----------+"
aL[16]:="| TOTAIS    |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  |  #########  | ######### |"
aL[17]:="+-----------+-------------+-------------+-------------+-------------+-------------+-------------+-------------+-----------+"
Return(aL)

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁImpBloq   Ё Autor Ё Luzio Tavares         Ё Data Ё26.02.2008Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁImprime os usuarios bloqueados por motivo                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
*/
Static Function ImpBloq()

Local nCtd := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

For nCtd := 1 TO Len(aUsuBlq)

//	IncRegua()
	
	If nLi > nQtdLin
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cRel,cTamanho,nTipo)
		If nAnaSin = 1
			@ ++nLi,00 pSay "Matricula            Nome                                     Dt.Nasc. Sexo Est.Civil      Tipo Usuario   Parent.         Dt.Inicio  Dt.Repasse  Dt.Deslig."
		EndIf	
		++nLi
	Endif

	aSubTot := {}
	
	While BA1TRB->(! Eof() .And. BA3_TIPOUS == cTipo)
		
		cBloqueio := BA1TRB->(TRB_NIVBLQ+TRB_MOTBLO)
		nTotal := 0
		lTitulo := .T.
		
		While BA1TRB->(! Eof() .And. BA3_TIPOUS+TRB_NIVBLQ+TRB_MOTBLO == cTipo+cBloqueio)
			
			If lTitulo
				@ nli,00 PSay Padr(A660DescBloq("TRB") , 30)
				lTitulo := .F.
			EndIf
			
			nAuxQtdMes := QtdMes(mv_par04,  Right(BA1TRB->ANOMES,2)+"/"+Left(BA1TRB->ANOMES,4) )
			nCol := 32+((nAuxQtdMes-1)*16)
			
			@ nli,nCol 		PSay Str(BA1TRB->TOTUSU,10)
			
			nTotal += BA1TRB->TOTUSU
			
			//incrementa sub-total
			nPos := ASCAN(aSubTot, {|aVal| aVal[1] == BA1TRB->ANOMES})
			
			If nPos == 0
				aAdd(aSubTot, { BA1TRB->ANOMES, 0})
				aSubTot[Len(aSubTot)][2] += BA1TRB->TOTUSU
			Else
				aSubTot[nPos][2] += BA1TRB->TOTUSU
			EndIf
			
			BA1TRB->(DbSkip())
			
		End
		nCol := 32+(nQtdMes*16)
		@ nli,nCol Psay Str(nTotal,10)
		nli++
		
	End
	
	@ nli,00 PSAY Repl("-",220)
	nli++
	
	@ nli,00 PSay " **SUB TOTAL**"
	
	cMesIni := mv_par04
	nTotal  := 0
	
	For nCtd := 1 TO nQtdMes
		
		If Val(Left(cMesIni,2)) + 1 > 12
			cAno    := StrZero(Val(Right(cMesIni,4))+1,4)
			nMesIni := 1
		Else
			cAno    := StrZero(Val(Right(cMesIni,4)),4)
			nMesIni := Val(Left(cMesIni,2)) + 1
		EndIf
		
		cMesIni := StrZero(nMesIni,2)+cAno
		
		dDatFim := CTOD( "01/"+StrZero(nMesIni,2)+"/"+Right(cAno,2) )
		
		nPos := ASCAN(aSubTot, {|aVal| aVal[1] == Left(DTOS(dDatFim-1),6)})
		
		If nPos > 0
			
			nAuxQtdMes := QtdMes(mv_par04, Right(aSubTot[nPos][1],2)+"/"+Left(aSubTot[nPos][1],4))
			nCol := 32+(nAuxQtdMes-1)*16
			
			@ nli,nCol 		PSay Str(aSubTot[nPos][2],10)
			nTotal += aSubTot[nPos][2]
			
			//incrementa array do Total Geral
			nPosTot := ASCAN(aTotGer, {|aVal| aVal[1] == aSubTot[nPos][1]})
			
			If nPosTot == 0
				aAdd(aTotGer, { aSubTot[nPos][1], 0, 0})
				aTotGer[Len(aTotGer)][2] += aSubTot[nPos][2]
			Else
				aTotGer[nPosTot][2] += aSubTot[nPos][2]
			EndIf
			
		EndIf
		
	Next
	nCol := 32+(nQtdMes*16)
	@ nli, nCol Psay Str(nTotal,10)
	nli++
	
	@ nli,00 PSAY Repl("-",220)
	nli += 2
	
End