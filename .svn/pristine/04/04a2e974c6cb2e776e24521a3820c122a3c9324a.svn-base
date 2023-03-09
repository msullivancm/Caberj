/*************************************************************************************************************
* Programa....: BuscaFunc    																			      *
* Tipo........: COPIA DADOS DE FUNCIONÁRIO                                                                    *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 14/02/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.:                                                                                               *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Copia dados do funcionário se for o mesmo CPF.                                                *
 *************************************************************************************************************/
#include "rwmake.ch"
 
user function BuscaFunc(cChave)

Local aArea := sra->(GetArea())
Local lRet  := .t.

If INCLUI                           
   sra->(DbOrderNickname("RA_CIC"))
   If sra->(DbSeek(xFilial("SRA")+cChave))
      nOpc := Aviso("CPF JA CADASTRADO","Deseja Copiar os dados do Funcionario:"+SRA->RA_NOME,{"SIM","Nao"})
      If nOpc = 1
         CopiaFun()
      EndIF
   EndIF
   sra->(RestArea(aArea))
EndIF
   
Return(lRet)

/***********************************************************************************************************
* FUNCAO: CopiaFun                                                                                          *
 ***********************************************************************************************************/
Static Function CopiaFun
Local nx //BSO
aCampoNao := {} // campos que nao serao copiados
aDepara   := {} // campos que serao copiados
aAdd(aCampoNao,{'RA_FILIAL'})
aAdd(aCampoNao,{'RA_CC'})
aAdd(aCampoNao,{'RA_MAT'})
aAdd(aCampoNao,{'RA_ADMISSA'})
aAdd(aCampoNao,{'RA_OPCAO'})
aAdd(aCampoNao,{'RA_SITFOLH'})
aAdd(aCampoNao,{'RA_SALARIO'})
aAdd(aCampoNao,{'RA_INSETIV'})
aAdd(aCampoNao,{'RA_GRATDIR'})
aAdd(aCampoNao,{'RA_EXTRACL'})
aAdd(aCampoNao,{'RA_ANTEAUM'})
aAdd(aCampoNao,{'RA_VCTOEXP'})
aAdd(aCampoNao,{'RA_VCTEXP2'})
aAdd(aCampoNao,{'RA_CRACHA'})
aAdd(aCampoNao,{'RA_AFASFGT'})
aAdd(aCampoNao,{'RA_RESCRAI'})
aAdd(aCampoNao,{'RA_USERLGI'})
aAdd(aCampoNao,{'RA_USERLGA'})

aAdd(aCampoNao,{'RA_MSBLQL'})

aAdd(aCampoNao,{'RA_DEMISSA'})
aAdd(aCampoNao,{'RA_TNOTRAB'})
aAdd(aCampoNao,{'RA_CODRET'})
//aAdd(aCampoNao,{'RA_XACESSO'})
aAdd(aCampoNao,{'RA_ASMEDIC'})
aAdd(aCampoNao,{'RA_DPASSME'})
aAdd(aCampoNao,{'RA_VALEREF'})
aAdd(aCampoNao,{'RA_SEGUROV'})
aAdd(aCampoNao,{'RA_CRACHA'})
aAdd(aCampoNao,{'RA_REGRA'})
aAdd(aCampoNao,{'RA_EXAMEDI'})
//aAdd(aCampoNao,{'RA_XGESTPO'})

IF FUNNAME() = 'GPEA265'
	aAdd(aCampoNao,{'RA_ASMEDIC'})
	aAdd(aCampoNao,{'RA_DPASSME'})
	aAdd(aCampoNao,{'RA_ADTPOSE'})
	aAdd(aCampoNao,{'RA_CESTAB'})
	aAdd(aCampoNao,{'RA_VALEREF'})
	aAdd(aCampoNao,{'RA_SEGUROV'})
	aAdd(aCampoNao,{'RA_ASSIST_'})
	aAdd(aCampoNao,{'RA_CONFED_'})
	aAdd(aCampoNao,{'RA_SINDICA'})
	aAdd(aCampoNao,{'RA_HRSMES'})
	aAdd(aCampoNao,{'RA_HRSEMAN'})
    aAdd(aCampoNao,{'RA_PGCTSIN'})
ENDIF    

DbSelectArea('SX3')
DbSetOrder(1)
DbSeek('SRA')
While X3_ARQUIVO = 'SRA'
   If Ascan(aCamponao,{|x| x[1] = ALLTRIM(X3_CAMPO)}) > 0 .or. X3_CONTEXT = "V"
      DbSkip()
      Loop
   EndIf                                                       
   // Inserir aqui os campos com valores fixos...
   if     alltrim(X3_CAMPO ) == "RA_TIPENDE"                       
          aAdd(aDePara, {"2",'M->'+X3_CAMPO} )   
   elseif alltrim(X3_CAMPO ) == "RA_CPAISOR"     
          aAdd(aDePara, {"01058",'M->'+X3_CAMPO} )       
   elseif alltrim(X3_CAMPO ) == "RA_PAISOR"     
          aAdd(aDePara, {"BRASIL",'M->'+X3_CAMPO} )                 
   elseif alltrim(X3_CAMPO ) == "RA_NACIONA"     
          aAdd(aDePara, {"10",'M->'+X3_CAMPO} )                 
   else
          aAdd(aDePara, {X3_ARQUIVO+'->'+X3_CAMPO,'M->'+X3_CAMPO} )
   endif
   DbSkip()
EndDo

dbSelectArea("SRA")

For nX := 1 to Len(aDePara)	
  	&(aDePara[nX, 2]) := &(aDePara[nX, 1])	
Next nX

Return
   
