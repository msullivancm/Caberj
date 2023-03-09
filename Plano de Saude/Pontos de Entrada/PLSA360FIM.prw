#Include "Protheus.ch"
      

/*
//===================================================================================================================================================
//³Confirmação RDA Cadastro                                                                                                                          
//³O ponto de Entrada PLSA360FIM, disponibilizado para que o usuário possa implementar suas customizações após a confirmação da tela RDA - Cadastro. 
//===================================================================================================================================================
*/
User Function PLSA360FIM() 

Local nOpc := paramixb[1]

   /* 
   //*************************************************************************************************** 
   //³CHAMA A ROTINA QUE FAZ A GRAVACAO DA TABELA AUXILIAR RDA_CAB_INT, SEQUENCIAL UNICO DE BAU_CODIGO ³
   //*************************************************************************************************** 
   */   
   If nOpc = 3//Inclusão  
     U_CABA338G()    
   End if  

Return