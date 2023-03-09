#Include 'Protheus.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  PL175FIL  ºAutor  ³Fabio Bianchini      º Data ³  24/11/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para tratar o Filtro das PEGS no PLSA175,  restrigindo   º±±
±±           ³18 meses aos usuários que não tiverem                       º±± 
±±º          ³permissão para ver todas as competências                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj / Integral                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL175FIL()

Local cFiltro    := ParamIxb[1]
Local nDiasFil  := GetNewPar("MV_XDIAPEG",540)  //EQUIVALE A 18 MESES (em dias 540/30)
Local cAutoriz  := GetNewPar("MV_XUSUAUT",'') //casemiro|motta|altamiro|fabio.bianchini|roberto.meirelles|angelo.cassago|filipe.silva|anderson.rangel|denise.rocha|piumbim|hugo.paiva|sandrot|haroldo|carlamaria|
Local dDataTmp  := Date() - nDiasFil 
Local cMesfil   := Substr(Dtos(dDataTmp),5,2) 
Local cAnoFil   := Substr(Dtos(dDataTmp),1,4)
Local cUsrName  := LogUserName() //Retorna o nome de usuario logado.  Como serão poucos, optei pelo nome para facilitar

If !(cUsrName $ cAutoriz) //Tratamento para Restringir 18 meses a quem não for autorizado a ver tudo
    MsgInfo('Filtrando até ' + cValToChar(nDiasFil/30) + ' meses em relação a data atual.','Aviso')
    cFiltro += " AND BCI_ANO||BCI_MES >= '" + cAnoFil+cMesFil + "' " 
Endif

Return cFiltro