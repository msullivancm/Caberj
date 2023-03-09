#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  PLSFI498  ºAutor  ³Fabio Bianchini      º Data ³  24/11/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para tratar o Filtro das PEGS no PLSA498, corrgindo o    º±±
±±º          ³padrão e restrigindo 18 meses aos usuários que não tiverem  º±±
±±º          ³permissão para ver todas as competências                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj / Integral                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSFI498()
LOCAL cFiltroOld := ParamIxb[1]
LOCAL cFiltro    := ""
Local cRdaDe     := ParamIxb[2]
Local cRdaAte    := ParamIxb[3]
Local cCodlocDe  := ParamIxb[4]
Local cCodlocAte := ParamIxb[5]
Local cMesDe     := ParamIxb[6]
Local cMesAte    := ParamIxb[7]
Local cAnoDe     := ParamIxb[8]
Local cAnoAte    := ParamIxb[9]
Local cTipGui    := ParamIxb[10] 
Local cSituac    := ParamIxb[11] 
Local cPegDe     := MV_PAR09
Local cPegAte    := MV_PAR10
Local nDias      := 0
Local nDiasFil  := GetNewPar("MV_XDIAPEG",720)  //EQUIVALE A 24 MESES (em dias 720/30)
Local cAutoriz  := GetNewPar("MV_XUSUAUT",'') //casemiro|motta|altamiro|fabio.bianchini|roberto.meirelles|angelo.cassago|filipe.silva|anderson.rangel|denise.rocha|piumbim|hugo.paiva|sandrot|haroldo|carlamaria|
Local dDataTmp  := Date() - nDiasFil 
Local cMesfil   := Substr(Dtos(dDataTmp),5,2) 
Local cAnoFil   := Substr(Dtos(dDataTmp),1,4)
Local cUsrName  := LogUserName() //Retorna o nome de usuario logado.  Como serão poucos, optei pelo nome para facilitar

Local cAnoAnt   := cValToChar(Val(Substr(Dtos(dDataBase),1,4)) - 1)
Local cAnoAtual := Substr(Dtos(dDataBase),1,4)

cFiltro := "@BCI_FILIAL = '"+ xFilial("BCI")+ "' AND BCI_CODOPE = '" + PLSINTPAD() + "' AND BCI_TIPGUI IN (" + cTipGui +")"    

If !Empty(cRdaDe)
    cFiltro += " AND BCI_CODRDA >= '" + cRdaDe + "' "
Endif    

If !Empty(cRdaAte)
    cFiltro += " AND BCI_CODRDA <= '" + cRdaAte + "' "
Endif    

If !Empty(cCodlocDe) 
    cFiltro += " AND BCI_CODLDP >= '" + cCodlocDe + "' "
Endif

If !Empty(cCodlocAte) 
    cFiltro += " AND BCI_CODLDP <= '" + cCodlocAte + "' "
Endif

IF !Empty(cPegDe)
    cFiltro += " AND BCI_CODPEG >= '" + cPegDe + "' "
Endif

IF !Empty(cPegAte)
    cFiltro += " AND BCI_CODPEG <= '" + cPegAte + "' "
Endif
/*
If !Empty(cAnoDe+cMesDe) .and. !Empty(cAnoAte+cMesAte)  
    
    nDias := STOD(cAnoAte+cMesAte+cValToChar(LastDay(STOD(cAnoAte+cMesAte+'01')))) - STOD(cAnoDe+cMesDe+'01')
    //Se quantidade de dias for menor do que o limite, deixo vir o filtro original
    If nDias <= nDiasFil
        cFiltro := cFiltroOld
        Return(cFiltro)   
    Endif
    //Se usuario for permitido ver tudo, deixo vir o filtro original
    If cUsrName $ cAutoriz //Tratamento para Restringir 24 meses a quem não for autorizado a ver tudo
        //If !Empty(cAnoDe+cMesDe)
            //cFiltro += " AND BCI_ANO||BCI_MES >= '" + cAnoDe+cMesDe + "' " 
            cFiltro := cFiltroOld
            Return(cFiltro) 
        //Endif
    Else
        If !Empty(cAnoDe+cMesDe) .and. !Empty(cAnoFil+cMesFil) 
            If (cAnoDe+cMesDe) > (cAnoFil+cMesFil)
                //cFiltro += " AND BCI_ANO||BCI_MES >= '" + cAnoDe+cMesDe + "' " 
                cFiltro += " AND BCI_ANO >= '" + cAnoDe + "' " + " BCI_MES >= '" + cMesDe + "' "     
            Else
                MsgInfo('Filtrando até ' + cValToChar(nDiasFil/30) + ' meses em relação a data atual.','Aviso')
                //cFiltro += " AND BCI_ANO||BCI_MES >= '" + cAnoFil+cMesFil + "' " 
                cFiltro += " AND BCI_ANO >= '" + cAnoFil + "' " + " BCI_MES >= '" + cMesFil + "' "     
            Endif
        Else
            MsgInfo('Filtrando até ' + cValToChar(nDiasFil/30) + ' meses em relação a data atual.','Aviso')
            //cFiltro += " AND BCI_ANO||BCI_MES >= '" + cAnoFil+cMesFil + "' " 
            cFiltro += " AND BCI_ANO >= '" + cAnoFil + "' " + " BCI_MES >= '" + cMesFil + "' "     
        Endif

        If !Empty(cSituac)
            cFiltro += " AND BCI_SITUAC = '" + cSituac + "' "
        Endif
    Endif

Endif
*/
//Se usuario for permitido ver tudo, deixo vir o filtro original
//If cUsrName $ cAutoriz //Tratamento para Restringir 24 meses a quem não for autorizado a ver tudo
  //  cFiltro := cFiltroOld
//Else
    cFiltro += " AND BCI_ANO >= '" + cAnoAnt + "' AND BCI_ANO <= '" + cAnoAtual + "' " 
    MsgInfo('Filtrando do Mês/Ano 01/' + cAnoAnt + ' até o Mês/Ano ' + cMesAte + '/' + cAnoAtual ,'Aviso')
//Endif

IF !Empty(cMesAte)
    cFiltro += " AND BCI_MES <= '" + cMesAte + "' "
Endif

If !Empty(cSituac)
    cFiltro += " AND BCI_SITUAC = '" + cSituac + "' "
Endif

Return(cFiltro)     