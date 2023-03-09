#include "rwmake.ch"
#include "tbicode.ch"
#include "tbiconn.ch"
#include "ap5mail.ch"

********************
User Function FuncWF
********************
Local aEmps := {}
Local I

// busca empresas
DbUseArea(.T.,"","SIGAMAT.EMP","SM0")
While !Eof()
   Aadd(aEmps,{SM0->M0_CODIGO,SM0->M0_CODFIL})
   DbSkip()
End
DbCloseArea()

// processa empresas/filiais encontradas
//For I:= 1 to Len(aEmps)
    // abre novas thred's
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '01' MODULO "SIGAFIN"
	// executa funcao de importacao
   	U_ImportCli('01','01')
	U_ImportDep('01','01')
	// fecha arquivos
	RESET ENVIRONMENT
	DbCloseAll()
//Next I

// retorna
Return              
                                           