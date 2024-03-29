/*/{Protheus.doc} PL660SBUT
@project Novas Empresas												        
@description Ponto de entrada para adicionar botao no Sub-Contrato 
@author Marcos Cantalice
@since 30/10/2022
@version 1.0		
@return
/*/

#include "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function PL660SBUT

Local aArea     := GetArea()
Local aRet      := {}

// aAdd(aRet, {"CARUSU", {||U_CABA255()                   }, "Carregar Usu. Permitido"      	, "Carregar Usu. Permitido"	    })
aAdd(aRet, {"BCOCON", {||U_CABA238C()                   }, "Aprova��o de subcontrato"      	, "Aprova��o de subcontrato"	})
aAdd(aRet, {"BCOCON", {||U_CABA238E()                   }, "Reprova��o de subcontrato" 		, "Reprova��o de subcontrato"	})
aAdd(aRet, {"BCOCON", {||U_CABA238D()                   }, "Hist�rico de aprova��o"        	, "Hist�rico de aprova��o"      })
aAdd(aRet, {"BUDGET", {||U_CABA239( BQC->( RecNo() ) )  }, "Anexar Documentos"              , "Anexar Documentos"           })

RestArea(aArea)

Return (aRet)
