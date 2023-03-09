#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#DEFINE c_ent CHR(13)+CHR(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR042   บAutor  ณRenato Peixoto      บ Data ณ  29/06/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de MATERs ativos no sistema de acordo com o      บฑฑ
ฑฑบ          ณ mes/ano informados via parametro. (Para seguro prestamista)บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                               

User Function CABR042()
                 
Local cTitulo     := "Relat๓rio MATERs (Tit. e dependentes)"

Private cAno       := "" 
Private cMes       := ""
Private nCont      := 0
Private cPerg      := "CABR42" 
Private cDtLimInc  := DTOS(STOD("20110512")) //Data limite para permitir inclusao de dependentes por titulares maiores que 65 anos
Private nDiasTroPl := GETMV("MV_XTROPLA")//Qtd de dias limite entre um plano MATER bloqueado e uma nova inclusใo MATER para que possa ser considerado como troca de plano no relat๓rio seguro prestamista
Private cPlaMATER  := GETMV("MV_XMATER") //C๓digos dos planos MATER cadastrados na CABERJ

CriaSX1()

If !APMSGYESNO("Esta relat๓rio irแ emitir a rela็ใo dos titulares MATERs e seus dependentes. Deseja continuar?","Relat๓rio de MATERs (Titulares e Dependentes).")
	Return
EndIf

If !Pergunte(cPerg,.T.)
	Return
EndIf

cMes := MV_PAR01
cAno := MV_PAR02

Processa({|| lret := RelMater() }, cTitulo, "", .T.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRelMater  บAutor  ณRenato Peixoto       บ Data ณ  01/07/11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que irแ processar o relatorio dos MATERs e seus      บฑฑ
ฑฑบ          ณdependentes.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function RelMater()

Local cQuery    := ""
Local cAliasQry := GetNextAlias()
Local cEmpMater := "0001"
Local cEmpColab := "0003"
Local cTipoBM1  := "101" 
Local i         := 0

Private nValTit   := 0
Private nValDep   := 0   
Private aRelExcel := {}
Private cCodInt   := PLSINTPAD()

//nova query otimizada para trazer todos os beneficiแrios segundo a regra do seguro prestamista
cQuery := "SELECT BA1_CODINT, BA1_CODPLA, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, DECODE(BA1_TIPUSU,'T','TITULAR','DEPENDENTE') BA1_TIPUSU, BA1_GRAUPA, BRP_DESCRI, "+c_ent
cQuery += "BA1_NOMUSR NOME, BA1_CPFUSR CPF, Trim(ba1_datnas) DATANASC, idade_s(ba1_datnas) IDADE, Trim(ba1_datinc) DATA_INCLUSAO, Trim(ba1_datblo) DATA_BLOQUEIO, "+c_ent
cQuery += "DECODE(RETORNA_VL_MENSALIDADE('01', BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, "+c_ent
cQuery += 		"	'"+cAno+"','"+cMes+"'),0,RETORNA_VALOR_FAIXA ( BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, '"+DTOS(LastDay(STOD(cAno+cMes+"01")))+"' ), "+c_ent
cQuery +=       "   RETORNA_VL_MENSALIDADE('01', BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, '"+cAno+"','"+cMes+"')) MENSALIDADE "+c_ent
cQuery += "FROM "+RetSqlName("BA1")+" DEP_VALIDO, "+RetSqlName("BRP")+" BRP "+c_ent 
cQuery += "WHERE DEP_VALIDO.BA1_FILIAL = '"+XFILIAL("BA1")+"' AND BRP_FILIAL = '"+XFILIAL("BRP")+" ' "+c_ent
cQuery += "AND DEP_VALIDO.d_e_l_e_t_ = ' ' AND BRP.d_e_l_e_t_ = ' ' "+c_ent
cQuery += "AND DEP_VALIDO.BA1_GRAUPA = BRP_CODIGO "+c_ent
cQuery += "AND DEP_VALIDO.BA1_DATINC <= '"+DTOS(LastDay(STOD(cAno+cMes+"01")))+"' "+c_ent
cQuery += "AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) " +c_ent
cQuery += "AND BA1_CODEMP IN ('"+cEmpMater+"','"+cEmpColab+"') "+c_ent
cQuery += "AND BA1_CODPLA NOT IN ('0018','    ') "+c_ent
cQuery += "AND BA1_TIPUSU  = 'D' "+c_ent
cQuery += "AND (BA1_GRAUPA IN('02','03','04','05','06','25','07','08') OR (BA1_GRAUPA IN('12','13','23','24') AND IDADE_S(BA1_DATNAS) < 25 ) ) "+c_ent //alterado em 29/03/12 para trazer filhos independentemente da idade, devido ao problema no cadastro de filhos especiais que vieram do saude
cQuery += "AND BA1_DATBLO <> BA1_DATINC "+c_ent 
//cQuery += "AND BA1_MATRIC = '000021' " //filtro para testar
cQuery += "AND "+c_ent
cQuery += "( "+c_ent
cQuery += "  ( "+c_ent
cQuery += "    EXISTS "+c_ent
cQuery += "    ( "+c_ent
cQuery += "      SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC "+c_ent
cQuery += "      FROM "+RetSqlName("BA1")+" TIT_MAIS_IGUAL_65 "+c_ent
cQuery += "      WHERE TIT_MAIS_IGUAL_65.D_E_L_E_T_ = ' ' "+c_ent
cQuery += "      AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cQuery += "      AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) "+c_ent
cQuery += "      AND BA1_TIPUSU = 'T' "+c_ent
cQuery += "      AND IDADE_S(BA1_DATNAS) >= 65 "+c_ent
cQuery += "      and ret_dt_incl_continua(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO,'"+cPlaMATER+"',"+AllTrim(STR(nDiasTroPl))+") <= TO_DATE('"+cDtLimInc+"','YYYYMMDD') "+c_ent
cQuery += "      AND TIT_MAIS_IGUAL_65.BA1_CODINT||TIT_MAIS_IGUAL_65.BA1_CODEMP||TIT_MAIS_IGUAL_65.BA1_MATRIC = DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC "+c_ent
cQuery += "    ) "+c_ent
cQuery += " and ret_dt_incl_continua(DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC||DEP_VALIDO.BA1_TIPREG||DEP_VALIDO.BA1_DIGITO,'"+cPlaMATER+"',"+AllTrim(STR(nDiasTroPl))+") <= TO_DATE('"+cDtLimInc+"','YYYYMMDD') "+c_ent
//cQuery += "    AND DEP_VALIDO.BA1_DATINC <= '"+cDtLimInc+"' "+c_ent
cQuery += "  ) "+c_ent
cQuery += "  OR "+c_ent
cQuery += "  EXISTS "+c_ent
cQuery += "  ( "+c_ent
cQuery += "    SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC "+c_ent
cQuery += "    FROM "+RetSqlName("BA1")+" TIT_MENOR_65 "+c_ent
cQuery += "    WHERE TIT_MENOR_65.D_E_L_E_T_ = ' '  "+c_ent
cQuery += "    AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cQuery += "    AND BA1_TIPUSU = 'T' "+c_ent
cQuery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) "+c_ent
cQuery += "    AND IDADE_S(BA1_DATNAS) < 65 "+c_ent
cQuery += "    AND TIT_MENOR_65.BA1_CODINT||TIT_MENOR_65.BA1_CODEMP||TIT_MENOR_65.BA1_MATRIC = DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC "+c_ent
cQuery += "  ) "+c_ent
cQuery += ") "+c_ent
cQuery += "UNION "+c_ent
cQuery += "SELECT BA1_CODINT, BA1_CODPLA, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, DECODE(BA1_TIPUSU,'T','TITULAR','DEPENDENTE') BA1_TIPUSU,  BA1_GRAUPA, 'TITULAR', "+c_ent
cQuery += "BA1_NOMUSR NOME, BA1_CPFUSR CPF, Trim(ba1_datnas) DATANASC, idade_s(ba1_datnas) IDADE, trim(ba1_datinc) DATA_INCLUSAO, trim(ba1_datblo) DATA_BLOQUEIO, "+c_ent
cQuery += "DECODE(RETORNA_VL_MENSALIDADE('01', BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, "+c_ent
cQuery += 		"	'"+cAno+"','"+cMes+"'),0,RETORNA_VALOR_FAIXA ( BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG, '"+DTOS(LastDay(STOD(cAno+cMes+"01")))+"' ), "+c_ent
cQuery +=       "   RETORNA_VL_MENSALIDADE('01', BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, '"+cAno+"','"+cMes+"')) MENSALIDADE "+c_ent
cQuery += "FROM "+RetSqlName("BA1")+" BA1 "+c_ent
cQuery += "WHERE D_E_L_E_T_ = '  ' "+c_ent
cQuery += "AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cQuery += "AND BA1_TIPUSU = 'T' " +c_ent
//cQuery += "AND BA1_MATRIC = '000021' " //filtro para testar
cQuery += "AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC in (SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC "+c_ent
cQuery += "                                           FROM "+RetSqlName("BA1")+" DEP_VALIDO  "+c_ent
cQuery += "                                           WHERE BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cQuery += "                                           AND D_E_L_E_T_ = ' ' "+c_ent
cQuery += "                                           AND DEP_VALIDO.BA1_DATINC <= '"+DTOS(LastDay(STOD(cAno+cMes+"01")))+"' "+c_ent
cQuery += "                                           AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) " +c_ent
cQuery += "                                           AND BA1_CODEMP IN ('"+cEmpMater+"','"+cEmpColab+"') " +c_ent
cQuery += "                                           AND BA1_CODPLA NOT IN ('0018','    ') " +c_ent
cQuery += "                                           AND BA1_TIPUSU  = 'D' "+c_ent
cQuery += "                                           AND (BA1_GRAUPA IN('02','03','04','05','06','25','07','08') OR (BA1_GRAUPA IN('12','13','23','24') AND IDADE_S(BA1_DATNAS) < 25 ) )  "+c_ent //alterado em 29/03/12 para trazer filhos independentemente da idade, devido ao problema no cadastro de filhos especiais que vieram do saude
cQuery += "                                           AND BA1_DATBLO <> BA1_DATINC  "+c_ent
cQuery += "                                           AND "+c_ent
cQuery += "                                           ( "+c_ent
cQuery += "                                             ( "+c_ent
cQuery += "                                              EXISTS "+c_ent
cQuery += "                                                  ( "+c_ent
cQuery += "                                                   SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC "+c_ent
cQuery += "                                                   FROM "+RetSqlName("BA1")+" TIT_MAIS_IGUAL_65 "+c_ent
cQuery += "                                                   WHERE TIT_MAIS_IGUAL_65.D_E_L_E_T_ = ' ' "+c_ent
cQuery += "                                                   AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent
cQuery += "                                                   AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) "+c_ent
cQuery += "                                                   AND BA1_TIPUSU = 'T'  "+c_ent
cQuery += "                                                   AND IDADE_S(BA1_DATNAS) >= 65 "+c_ent
cQuery += "                                                   and ret_dt_incl_continua(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO,'"+cPlaMATER+"',"+AllTrim(STR(nDiasTroPl))+") <= TO_DATE('"+cDtLimInc+"','YYYYMMDD') "+c_ent
cQuery += "                                                   AND TIT_MAIS_IGUAL_65.BA1_CODINT||TIT_MAIS_IGUAL_65.BA1_CODEMP||TIT_MAIS_IGUAL_65.BA1_MATRIC = DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC " +c_ent
cQuery += "                                                  ) "+c_ent
cQuery += "                                             and ret_dt_incl_continua(DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC||DEP_VALIDO.BA1_TIPREG||DEP_VALIDO.BA1_DIGITO,'"+cPlaMATER+"',"+AllTrim(STR(nDiasTroPl))+") <= TO_DATE('"+cDtLimInc+"','YYYYMMDD') " +c_ent
//cQuery += "                                               AND DEP_VALIDO.BA1_DATINC <= '"+cDtLimInc+"' "+c_ent
cQuery += "                                             ) "+c_ent
cQuery += "                                             OR "+c_ent
cQuery += "                                             EXISTS "+c_ent
cQuery += "                                             ( "+c_ent
cQuery += "                                              SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC "+c_ent
cQuery += "                                              FROM "+RetSqlName("BA1")+" TIT_MENOR_65 "+c_ent
cQuery += "                                              WHERE TIT_MENOR_65.D_E_L_E_T_ = ' '  "+c_ent
cQuery += "                                              AND BA1_FILIAL = '"+XFILIAL("BA1")+"' "+c_ent  
cQuery += "                                              AND BA1_TIPUSU = 'T' "+c_ent
cQuery += "                                              AND ( BA1_DATBLO = ' ' OR BA1_DATBLO >= to_char(first_day(to_date('"+cAno+cMes+"','yyyymm')),'yyyymmdd') ) "+c_ent
cQuery += "                                              AND IDADE_S(BA1_DATNAS) < 65 "+c_ent
cQuery += "                                              AND TIT_MENOR_65.BA1_CODINT||TIT_MENOR_65.BA1_CODEMP||TIT_MENOR_65.BA1_MATRIC = DEP_VALIDO.BA1_CODINT||DEP_VALIDO.BA1_CODEMP||DEP_VALIDO.BA1_MATRIC "+c_ent
cQuery += "                                             ) "+c_ent
cQuery += "                                           ) " +c_ent
cQuery += "                                          ) "+c_ent
cQuery += "ORDER BY  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "+c_ent

ProcRegua(0)

For i := 1 to 5
    
 IncProc('Selecionando MATERs e dependentes...')
 
Next

If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

(cAliasQry)->(DbGoTop())                                 
COUNT TO nCont //verifico a quantidade de registros trazidos pela query
(cAliasQry)->(DbGoTop())

ProcRegua(nCont)	

If MV_PAR03 = 1
	aAdd(aRelExcel, {"OPERADORA", "PLANO", "EMPRESA", "MATRICULA", "TIPO REGISTRO", "DIGITO", "TITULAR/DEPENDENTE", "GRAU DEPENDENCIA", "DESCRICAO GRAU DEPENDENCIA", "NOME", "CPF", "DATA NASCIMENTO", "IDADE", "MENSALIDADE", "DATA INCLUSAO", "DATA BLOQUEIO", "PREMIO", "OBSERVAวรO" })
EndIf
 
While !((cAliasQry)->(Eof()))
	
	IncProc("Gerando relat๓rio MATERs. Aguarde...")
	
	aAdd(aRelExcel, { (cAliasQry)->BA1_CODINT, (cAliasQry)->BA1_CODPLA, (cAliasQry)->BA1_CODEMP, (cAliasQry)->BA1_MATRIC, (cAliasQry)->BA1_TIPREG, ;
	(cAliasQry)->BA1_DIGITO, (cAliasQry)->BA1_TIPUSU, (cAliasQry)->BA1_GRAUPA, (cAliasQry)->BRP_DESCRI, (cAliasQry)->NOME, (cAliasQry)->CPF,;
	SubStr((cAliasQry)->DATANASC,7,2)+"/"+SubStr((cAliasQry)->DATANASC,5,2)+"/"+SubStr((cAliasQry)->DATANASC,1,4)/*STOD((cAliasQry)->DATANASC)*/,;
	(cAliasQry)->IDADE, (cAliasQry)->MENSALIDADE, STOD((cAliasQry)->DATA_INCLUSAO), STOD((cAliasQry)->DATA_BLOQUEIO), ((cAliasQry)->MENSALIDADE*6)*0.0021285,;
	IIF((cAliasQry)->DATA_INCLUSAO > cDtLimInc .AND. (cAliasQry)->IDADE >= 65 .AND. (cAliasQry)->BA1_TIPUSU = "TITULAR" , "TRANSFERสNCIA DE PLANO","")  })
	
	If (cAliasQry)->BA1_TIPUSU = "T"
		nValTit += (cAliasQry)->MENSALIDADE
	Else
		nValDep += (cAliasQry)->MENSALIDADE
	EndIf
	
	(cAliasQry)->(DbSkip())
	
EndDo

If MV_PAR03 = 1
	aAdd(aRelExcel, { "VALOR TOTAL DOS TITULARES:   " , nValTit, , , , , , , , , })
	aAdd(aRelExcel, { "VALOR TOTAL DOS DEPENDENTES: " , nValDep, , , , , , , , , })
EndIf

If Len(aRelExcel) > 0
	If MV_PAR03 = 1
		DlgToExcel({{"ARRAY","Relat๓rio MATERs (Titulares e seus Dependentes.","",aRelExcel}}) 
	Else
		RelTela()
	EndIf
Else
	APMSGINFO("Nใo existe nenhum usuแrio Mater com Dependente no perํodo informado. Por favor, verifique os parโmetros.","Nใo hแ dados a serem exibidos.")
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELTELA   บ Autor ณ Renato Peixoto     บ Data ณ  24/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relat๓rio que vai exibir em tela os titulares e dependentesบฑฑ
ฑฑบ          ณ que serใo enviados เ Flanci  para Seguro Prestamista.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RELTELA()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Rel Seg Prestamista"
Local cPict         := ""
Local titulo        := "Rel Seg Prestamista"
Local nLin          := 80
                      //0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1        := "Plano                      Matricula Completa     Nome Beneficiario                             Tit/Dep        Grau Dep         Idade    Mensalidade      Dt Incl     Dt Bloq       Premio        OBS"
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "RELSEGPREST" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "RELSEGPREST" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString     := "BA1"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRunReport บ Autor ณ Renato Peixoto     บ Data ณ  17/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Fun็ใo que vai fazer a logica de impressao.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local i := 0


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(Len(aRelExcel))

For i := 1 To Len(aRelExcel)

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Verifica o cancelamento pelo usuario...                             ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   IncRegua()
   
   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Impressao do cabecalho do relatorio. . .                            ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
   /*aAdd(aRelExcel, { (cAliasQry)->BA1_CODINT, (cAliasQry)->BA1_CODPLA, (cAliasQry)->BA1_CODEMP, (cAliasQry)->BA1_MATRIC, (cAliasQry)->BA1_TIPREG, ;
	(cAliasQry)->BA1_DIGITO, (cAliasQry)->BA1_TIPUSU, (cAliasQry)->BA1_GRAUPA, (cAliasQry)->BRP_DESCRI, (cAliasQry)->NOME, (cAliasQry)->CPF,;
	SubStr((cAliasQry)->DATANASC,7,2)+"/"+SubStr((cAliasQry)->DATANASC,5,2)+"/"+SubStr((cAliasQry)->DATANASC,1,4),;
	(cAliasQry)->IDADE, (cAliasQry)->MENSALIDADE, STOD((cAliasQry)->DATA_INCLUSAO), STOD((cAliasQry)->DATA_BLOQUEIO), ((cAliasQry)->MENSALIDADE*6)*0.0021285,;
	IIF((cAliasQry)->DATA_INCLUSAO > cDtLimInc .AND. (cAliasQry)->IDADE >= 65 .AND. (cAliasQry)->BA1_TIPUSU = "TITULAR" , "TRANSFERสNCIA DE PLANO","")  })
	*/
   //Plano   Matricula Completa    Nome Beneficiario                             Tit/Dep        Grau Dep     Idade    Mensalidade      Dt Incl     Dt Bloq       Premio        OBS
   @nLin,00  PSAY aRelExcel[i][2]+" - "+POSICIONE("BI3",1,XFILIAL("BI3")+cCodInt+aRelExcel[i][2],"BI3_DESCRI")//codigo do plano
   @nLin,28  PSAY aRelExcel[i][1]+aRelExcel[i][3]+aRelExcel[i][4]+aRelExcel[i][5]+aRelExcel[i][6]//chave matricula completa
   @nLin,51  PSAY aRelExcel[i][10]//nome beneficiario
   @nLin,97  PSAY aRelExcel[i][7]//Titular/Dependente
   @nLin,112 PSAY aRelExcel[i][8]+" - "+aRelExcel[i][9]//grau dependencia
   @nLin,130 PSAY aRelExcel[i][13]//idade
   @nLin,137 PSAY aRelExcel[i][14] Picture "@E 999,999.99"//mensalidade
   @nLin,154 PSAY aRelExcel[i][15] //data inclusao
   @nLin,166 PSAY aRelExcel[i][16]//data bloqueio
   @nLin,176 PSAY aRelExcel[i][17] Picture "@E 999,999.99"//Premio
   @nLin,195 PSAY aRelExcel[i][18]//OBS
   
   nLin := nLin + 1 // Avanca a linha de impressao

Next i

nLin += 5

@nLin,00 PSAY "VALOR TOTAL DOS TITULARES:   "+Transform(nValTit,"999,999.99")
nLin++
@nLin,00 PSAY "VALOR TOTAL DOS DEPENDENTES: "+Transform(nValDep,"999,999.99")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ CriaSX1  ณ Autor ณ Renato Peixoto        ณ Data ณ 29/06/10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Cria/Atualiza perguntas.                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ CriaSX1()                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Mes Pgto:")     ,"","","mv_ch1","C",02,0,0     ,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual serแ o m๊s de Pgto no formato mm"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Ano Pgto:")     ,"","","mv_ch2","C",04,0,0     ,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual serแ o ano do Pgto no formato aaaa"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Exibi็ใo Relat๓rio:"),"","","mv_ch3","C",01,0,0,"C","","   ","","","mv_par03","Excel","","","","Tela","","","","","","","","","","","",{},{},{})

Return
         


