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
aAdd(aRet, {"BCOCON", {||U_CABA238C()                   }, "Aprovação de subcontrato"      	, "Aprovação de subcontrato"	})
aAdd(aRet, {"BCOCON", {||U_CABA238E()                   }, "Reprovação de subcontrato" 		, "Reprovação de subcontrato"	})
aAdd(aRet, {"BCOCON", {||U_CABA238D()                   }, "Histórico de aprovação"        	, "Histórico de aprovação"      })
aAdd(aRet, {"BUDGET", {||U_CABA239( BQC->( RecNo() ) )  }, "Anexar Documentos"              , "Anexar Documentos"           })

RestArea(aArea)

Return (aRet)
