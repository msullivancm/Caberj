
#include 'totvs.ch'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"   
#INCLUDE "AP5MAIL.CH"             
#INCLUDE "PLSMGER.CH"

WSSTRUCT mb_critica
	WSDATA critica_codigo   				 AS String OPTIONAL
	WSDATA critica_descricao_problema	 AS String OPTIONAL
	WSDATA critica_solucao_problema	 	 AS String OPTIONAL
	WSDATA critica_real_motivo		 	 AS String OPTIONAL
	WSDATA critica_autoriza_contato	 	 AS Boolean OPTIONAL
ENDWSSTRUCT
           
WSSTRUCT alerta
	WSDATA alerta_codigo   				 AS String OPTIONAL
	WSDATA alerta_descricao				 AS String OPTIONAL
ENDWSSTRUCT

WSSTRUCT mb_paciente
	WSDATA login								AS String OPTIONAL		//DESCRIPTION "Informar 'S'(Sim) no beneficiario da familia que acabou de logar"
	WSDATA titular							AS String OPTIONAL
	WSDATA titular_matricula					AS String OPTIONAL
	WSDATA matricula							AS String OPTIONAL
	WSDATA matricula_funcionario			AS String OPTIONAL
	WSDATA nome								AS String OPTIONAL
	WSDATA sexo								AS String OPTIONAL
	WSDATA nascimento				    		AS Date   OPTIONAL	
	WSDATA telefone							AS String OPTIONAL
	WSDATA email								AS String OPTIONAL	 
	WSDATA inclusao							AS Date   OPTIONAL 	
	WSDATA dependencia_id					AS String OPTIONAL
	WSDATA prontuario_id						AS String OPTIONAL 	
	WSDATA bloqueado							AS String OPTIONAL
	WSDATA motivo_bloqueio					AS String OPTIONAL 	
	
	WSDATA tipo_beneficiario_id				AS String OPTIONAL
	WSDATA tipo_beneficiario_descricao 	AS String OPTIONAL			
	WSDATA grau_parentesco_id				AS String OPTIONAL 
	WSDATA grau_parentesco_descricao		AS String OPTIONAL 		
	WSDATA convenio_id						AS String OPTIONAL
	WSDATA convenio_descricao				AS String OPTIONAL
	WSDATA convenio_versao					AS String OPTIONAL
	WSDATA convenio_abrangencia				AS String OPTIONAL
	WSDATA convenio_acomodacao				AS String OPTIONAL
	WSDATA convenio_segmentacao				AS String OPTIONAL	
	WSDATA convenio_tipo_contrato			AS String OPTIONAL	
	WSDATA convenio_participativo			AS String OPTIONAL	
	WSDATA convenio_modalidade_cobranca 	AS String OPTIONAL	
	WSDATA convenio_padrao_conforto			AS String OPTIONAL	
	WSDATA convenio_permite_reembolso	 	AS String OPTIONAL
	WSDATA convenio_ANS						AS String OPTIONAL	
			
	// Dados do cartão do beneficiario
	WSDATA cartao_validade					AS Date OPTIONAL 		
	WSDATA cartao_via							AS String OPTIONAL
	WSDATA cartao_imagem						AS String OPTIONAL	
	WSDATA cartao_imagem_verso				AS String OPTIONAL
	
	// Empresa
	WSDATA empresa_id							AS String OPTIONAL	
	WSDATA empresa_nome						AS String OPTIONAL	
ENDWSSTRUCT 
	
// Grupo familiar
WSSTRUCT grupo_familiar
	WSDATA matricula	   	 					AS String  OPTIONAL
	WSDATA membros			 				AS Array Of mb_paciente OPTIONAL
ENDWSSTRUCT

WSSTRUCT mb_grupo_familiar
	WSDATA retorno_status   	 				AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 				AS Array Of grupo_familiar 	OPTIONAL
	WSDATA retorno_criticas		 			AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 			AS Array Of alerta			OPTIONAL
ENDWSSTRUCT
             
// esssa estrutura irá retornar o item da agenda sugerida segundo o planejamento de agendas da promoção da saúde
WSSTRUCT planejamento_promocao_saude
	WSDATA planejamento_id					AS String 	OPTIONAL
	WSDATA planejamento_data_sugerida		AS Date 	OPTIONAL
	
	WSDATA prestador_id						AS String 	OPTIONAL
	WSDATA prestador_descricao				AS String 	OPTIONAL
		
	WSDATA unidade_atendimento_id			AS String	OPTIONAL 
	WSDATA unidade_atendimento_descricao	AS String	OPTIONAL
			
	WSDATA programa_da_promocao_id			AS String 	OPTIONAL
	WSDATA programa_da_promocao_descricao 	AS String 	OPTIONAL

	WSDATA procedimento_id					AS String 	OPTIONAL
	WSDATA procedimento_descricao 			AS String 	OPTIONAL		
	
	WSDATA disponibilidade_id				AS String 	OPTIONAL
	WSDATA elegibilidade_id					AS String 	OPTIONAL
	WSDATA evento_id							AS String	OPTIONAL 	
ENDWSSTRUCT

// Especialidade
WSSTRUCT especialidade
	WSDATA especialidade_id					AS String OPTIONAL
	WSDATA especialidade_descricao			AS String OPTIONAL
	WSDATA especialidade_cbos				AS String OPTIONAL
	WSDATA especialidade_cbos_descricao	AS String OPTIONAL	
	WSDATA procedimento_padrao_id			AS String OPTIONAL
	WSDATA procedimento_padrao_descricao	AS String OPTIONAL
	WSDATA pertence_promocao_saude			AS Boolean OPTIONAL
	wsdata planejamento_promocao_saude		AS Array of planejamento_promocao_saude
ENDWSSTRUCT
WSSTRUCT mb_especialidade
	WSDATA retorno_status   					AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 				AS Array Of especialidade 	OPTIONAL
	WSDATA retorno_criticas					AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 			AS Array Of alerta			OPTIONAL
ENDWSSTRUCT

// Unidade de atendimento
WSSTRUCT unidade_atendimento
	WSDATA unidade_atendimento_id				AS String OPTIONAL
	WSDATA unidade_atendimento_descricao		AS String OPTIONAL
	WSDATA unidade_atendimento_endereco		AS String OPTIONAL
	WSDATA unidade_atendimento_numero			AS String OPTIONAL
	WSDATA unidade_atendimento_complemento		AS String OPTIONAL
	WSDATA unidade_atendimento_bairro			AS String OPTIONAL
	WSDATA unidade_atendimento_cidade			AS String OPTIONAL
	WSDATA unidade_atendimento_estado			AS String OPTIONAL
	WSDATA unidade_atendimento_cep				AS String OPTIONAL
	WSDATA unidade_atendimento_telefone		AS String OPTIONAL
	WSDATA unidade_atendimento_observacoes		AS String OPTIONAL                                                                  
ENDWSSTRUCT
WSSTRUCT mb_unidade_atendimento
	WSDATA retorno_status   	 					AS Boolean OPTIONAL
	WSDATA retorno_dados		 					AS Array Of unidade_atendimento 	OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica	OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL                                                               
ENDWSSTRUCT

// Prestadores
WSSTRUCT prestador
	WSDATA prestador_id							AS String OPTIONAL
	WSDATA prestador_conselho					AS String OPTIONAL
	WSDATA prestador_estado_conselho			AS String OPTIONAL
	WSDATA prestador_nome						AS String OPTIONAL
	WSDATA unidade_atendimento_id				AS String OPTIONAL
	WSDATA unidade_atendimento_descricao		AS String OPTIONAL	
	WSDATA especialidade_id						AS String OPTIONAL
	WSDATA especialidade_descricao				AS String OPTIONAL //Nome da especialidade

	WSDATA endereco								AS String OPTIONAL
	WSDATA numero									AS String OPTIONAL	
	WSDATA bairro									AS String OPTIONAL
	WSDATA complemento							AS String OPTIONAL
	WSDATA cidade									AS String OPTIONAL
	WSDATA estado									AS String OPTIONAL
	WSDATA cep										AS String OPTIONAL
	
	WSDATA telefone								AS String OPTIONAL
	WSDATA disponibilidade_id					AS String OPTIONAL // obrigatorio integração com protheus
	WSDATA data_mais_proxima						AS String OPTIONAL
	WSDATA hora_mais_proxima						AS String OPTIONAL
	WSDATA numero_de_horarios_livres			AS Integer OPTIONAL 
ENDWSSTRUCT

WSSTRUCT mb_prestador
	WSDATA retorno_status   						AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 					AS Array Of prestador 		OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL  
ENDWSSTRUCT

// Agendas do prestador selecionado
WSSTRUCT agenda_medica_horarios	
	WSDATA agenda_id								AS String OPTIONAL
	WSDATA agenda_hora							AS String OPTIONAL 
			
	WSDATA promossao_saude						AS String OPTIONAL // Sim;Não
	WSDATA promossao_saude_id					AS String OPTIONAL
	WSDATA promossao_saude_descricao			AS String OPTIONAL
	
	WSDATA paciente_marcado_matricula			AS String OPTIONAL
	WSDATA paciente_marcado_nome				AS String OPTIONAL
ENDWSSTRUCT
WSSTRUCT agenda_medica
	WSDATA disponibilidade_id					AS String OPTIONAL
	WSDATA agenda_data							AS Date   OPTIONAL
	WSDATA agenda_hora_inicial					AS String OPTIONAL 
	WSDATA agenda_hora_final						AS String OPTIONAL
	WSDATA agenda_intervalo						AS String OPTIONAL 
	WSDATA agenda_medica_horarios				AS Array Of agenda_medica_horarios OPTIONAL		
ENDWSSTRUCT
WSSTRUCT mb_agenda_medica
	WSDATA retorno_status   	 					AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 					AS Array Of agenda_medica	OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL  	
ENDWSSTRUCT

// Dados da agenda do paciente
WSSTRUCT agendas_do_paciente
	// Dados da agenda	
	WSDATA agenda_id								AS String OPTIONAL
	WSDATA agenda_status							AS String OPTIONAL 	
	WSDATA agenda_data							AS Date   OPTIONAL
	WSDATA agenda_hora							AS String OPTIONAL		 			
	WSDATA promossao_saude_descricao			AS String OPTIONAL		
	WSDATA paciente_marcado_matricula			AS String OPTIONAL
	WSDATA paciente_marcado_nome				AS String OPTIONAL		
	WSDATA prestador_nome						AS String OPTIONAL
	WSDATA prestador_telefone					AS String OPTIONAL	
	WSDATA especialidade_descricao				AS String OPTIONAL //Nome da especialidade	
	WSDATA unidade_atendimento_descricao		AS String OPTIONAL
	WSDATA unidade_atendimento_endereco		AS String OPTIONAL
	WSDATA unidade_atendimento_numero			AS String OPTIONAL
	WSDATA unidade_atendimento_complemento		AS String OPTIONAL
	WSDATA unidade_atendimento_bairro			AS String OPTIONAL
	WSDATA unidade_atendimento_cidade			AS String OPTIONAL
	WSDATA unidade_atendimento_estado			AS String OPTIONAL
	WSDATA unidade_atendimento_cep				AS String OPTIONAL	
	
	// Informacoes sobre o cancelamento
	WSDATA cancelamento_motivo_id			   	AS String 	OPTIONAL
	WSDATA cancelamento_motivo_descricao		AS String 	OPTIONAL
	WSDATA cancelamento_data						AS Date 	OPTIONAL	
	WSDATA cancelamento_hora						AS String 	OPTIONAL
	
	// Servico realizado
	WSDATA procedimento_id						AS String 	OPTIONAL
	WSDATA procedimento_descricao				AS String 	OPTIONAL	
ENDWSSTRUCT

WSSTRUCT mb_agendas_do_paciente	
	WSDATA retorno_status   	 					AS Boolean							OPTIONAL
	WSDATA retorno_dados		 					AS Array Of agendas_do_paciente	OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica				OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta				OPTIONAL  	
ENDWSSTRUCT

// Estritura de recomentacoes/orientacoes;
WSSTRUCT recomendacao
	WSDATA recomendacao_codigo   		 		AS String OPTIONAL
	WSDATA recomendacao_descricao	 			AS String OPTIONAL
ENDWSSTRUCT
WSSTRUCT mb_recomendacao_agendamento
	WSDATA retorno_status   	 					AS Boolean OPTIONAL
	WSDATA retorno_dados		 					AS Array Of recomendacao OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica		OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta		OPTIONAL
ENDWSSTRUCT
              
// Dados da agenda do paciente
WSSTRUCT detalhes_agendamento
	// Dados da agenda	
	WSDATA paciente_marcado_nome				AS String OPTIONAL
	WSDATA paciente_marcado_matricula			AS String OPTIONAL
	WSDATA paciente_marcado_email				AS String OPTIONAL
	WSDATA paciente_marcado_telefone			AS String OPTIONAL 	
	WSDATA agenda_data							AS Date   OPTIONAL
	WSDATA agenda_hora							AS String OPTIONAL
	
	WSDATA prestador_id							AS String OPTIONAL		
	WSDATA prestador_nome						AS String OPTIONAL
	WSDATA procedimento_id						AS String OPTIONAL		
	WSDATA procedimento_descricao				AS String OPTIONAL
	
	WSDATA unidade_atendimento_id				AS String OPTIONAL	
	WSDATA unidade_atendimento_descricao		AS String OPTIONAL //Nome da especialidade	
	WSDATA unidade_atendimento_endereco		AS String OPTIONAL
	WSDATA unidade_atendimento_complemento		AS String OPTIONAL
	WSDATA unidade_atendimento_numero			AS String OPTIONAL
	WSDATA unidade_atendimento_bairro			AS String OPTIONAL
	WSDATA unidade_atendimento_cidade			AS String OPTIONAL
	WSDATA unidade_atendimento_estado			AS String OPTIONAL
	WSDATA unidade_atendimento_telefone		AS String OPTIONAL
	
	WSDATA recomendacoes						   	AS Array Of recomendacao OPTIONAL	
ENDWSSTRUCT
	WSSTRUCT mb_detalhes_agendamento
	WSDATA retorno_status   	 					AS Boolean								OPTIONAL
	WSDATA retorno_dados		 					AS Array Of detalhes_agendamento	OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica					OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta					OPTIONAL  	
ENDWSSTRUCT

 // Estritura de motivos de bloqueio
WSSTRUCT motivo_cancelamento
	WSDATA cancelamento_motivo_id   			AS String OPTIONAL  
	WSDATA cancelamento_motivo_descricao		AS String OPTIONAL     //motivo_cancelamento_descricao
ENDWSSTRUCT
WSSTRUCT mb_motivo_cancelamento
	WSDATA retorno_status   	 					AS Boolean	OPTIONAL
	WSDATA retorno_dados		 					AS Array Of motivo_cancelamento 	OPTIONAL
	WSDATA retorno_criticas	 					AS Array Of mb_critica 					OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta					OPTIONAL
ENDWSSTRUCT

// Recupera senha
WSSTRUCT recupera_senha
	WSDATA paciente_nome  	 					AS String	OPTIONAL
	WSDATA email_usuario	 						AS String	OPTIONAL
	WSDATA login									AS String	OPTIONAL
	WSDATA senha		   		 					AS String	OPTIONAL		
ENDWSSTRUCT
WSSTRUCT mb_recupera_senha
	WSDATA retorno_status   	 					AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 					AS Array Of recupera_senha 	OPTIONAL
	WSDATA retorno_criticas		 				AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL
ENDWSSTRUCT

WSSTRUCT acesso
	WSDATA acessa_reembolso					AS Boolean OPTIONAL	
	WSDATA acessa_agendamento				AS Boolean OPTIONAL
	WSDATA acessa_coparticipacao			AS Boolean OPTIONAL
	WSDATA acessa_medicamento				AS Boolean OPTIONAL
	WSDATA acessa_utilizacao					AS Boolean OPTIONAL
	WSDATA acessa_consulta_carencia			AS Boolean OPTIONAL
	WSDATA acessa_edita_cadastro			AS Boolean OPTIONAL
	WSDATA acessa_troca_senha				AS Boolean OPTIONAL
	WSDATA acessa_cartao						AS Boolean OPTIONAL	
ENDWSSTRUCT

WSSTRUCT carencia
	WSDATA tipo_servico   				 AS String OPTIONAL
	WSDATA carencia						 AS String OPTIONAL
ENDWSSTRUCT

WSSTRUCT layout_cartao
	WSDATA layout_nickname 				 AS String OPTIONAL
ENDWSSTRUCT

WSSTRUCT beneficiario
	WSDATA login								AS String OPTIONAL		//DESCRIPTION "Informar 'S'(Sim) no beneficiario da familia que acabou de logar"
	WSDATA titular							AS String OPTIONAL
	WSDATA titular_matricula					AS String OPTIONAL
	WSDATA matricula							AS String OPTIONAL
	WSDATA matricula_funcionario			AS String OPTIONAL
	WSDATA matricula_sis_antigo				AS String OPTIONAL
	WSDATA nome								AS String OPTIONAL
	WSDATA sexo								AS String OPTIONAL
	WSDATA nascimento				    		AS Date   OPTIONAL	
	WSDATA telefone							AS String OPTIONAL
	WSDATA email								AS String OPTIONAL	 
	WSDATA inclusao							AS Date   OPTIONAL 	
	WSDATA dependencia_id					AS String OPTIONAL
	WSDATA prontuario_id						AS String OPTIONAL 	
	WSDATA bloqueado							AS String OPTIONAL
	WSDATA motivo_bloqueio					AS String OPTIONAL 	
	WSDATA cpf									AS String OPTIONAL
	WSDATA tipo_pessoa_contratante			AS String OPTIONAL
	WSDATA numero_contrato					AS String OPTIONAL
	
	WSDATA endereco							AS String OPTIONAL
	WSDATA numero								AS String OPTIONAL
	WSDATA complemento						AS String OPTIONAL
	WSDATA bairro								AS String OPTIONAL
	WSDATA cidade								AS String OPTIONAL
	WSDATA estado								AS String OPTIONAL
	WSDATA cep									AS String OPTIONAL
	WSDATA celular							AS String OPTIONAL
	
	WSDATA tipo_beneficiario_id				AS String OPTIONAL
	WSDATA tipo_beneficiario_descricao 	AS String OPTIONAL			
	WSDATA grau_parentesco_id				AS String OPTIONAL 
	WSDATA grau_parentesco_descricao		AS String OPTIONAL 		
	WSDATA numero_cns							AS String OPTIONAL
	WSDATA data_cpt							AS String OPTIONAL
	
	WSDATA convenio_id						AS String OPTIONAL
	WSDATA convenio_descricao				AS String OPTIONAL
	WSDATA convenio_versao					AS String OPTIONAL
	WSDATA convenio_abrangencia				AS String OPTIONAL
	WSDATA convenio_acomodacao				AS String OPTIONAL
	WSDATA convenio_segmentacao				AS String OPTIONAL	
	WSDATA convenio_tipo_contrato			AS String OPTIONAL	
	WSDATA convenio_participativo			AS String OPTIONAL	
	WSDATA convenio_modalidade_cobranca 	AS String OPTIONAL	
	WSDATA convenio_padrao_conforto			AS String OPTIONAL	
	WSDATA convenio_permite_reembolso	 	AS String OPTIONAL	
	WSDATA convenio_tipo_rede_id		 	AS String OPTIONAL
	WSDATA convenio_tipo_rede_descricao 	AS String OPTIONAL
	WSDATA convenio_opcional					AS String OPTIONAL
	WSDATA convenio_carencias				AS Array of carencia OPTIONAL
	WSDATA convenio_ANS						AS String OPTIONAL
	WSDATA convenio_regulamentacao			AS String OPTIONAL 
	WSDATA convenio_natureza_contratacao 	AS String OPTIONAL
		
	// Dados do cartão do beneficiario
	WSDATA cartao_validade					AS Date OPTIONAL 		
	WSDATA cartao_via							AS String OPTIONAL
	WSDATA cartao_imagem						AS String OPTIONAL	
	WSDATA cartao_imagem_verso				AS String OPTIONAL
	WSDATA cartao_obs							AS String OPTIONAL
	wsdata cartao_contato1  					AS String OPTIONAL
	WSDATA cartao_contato2					AS String OPTIONAL
	WSDATA cartao_contato3					AS String OPTIONAL
	WSDATA cartao_contato4					AS String OPTIONAL
	WSDATA cartao_contato5					AS String OPTIONAL
	WSDATA layout_cartoes					AS Array of layout_cartao OPTIONAL	
	
	// Empresa
	WSDATA empresa_id							AS String OPTIONAL	
	WSDATA empresa_nome						AS String OPTIONAL
	WSDATA empresa_responsavel				AS String OPTIONAL
	 
	
	//Controle de acesso
	WSDATA expirou_senha						AS String OPTIONAL
	WSDATA solicita_atualizacao_cadastro	AS String OPTIONAL 	 			
ENDWSSTRUCT
 	
WSSTRUCT st_grupo_familiar
	WSDATA retorno_status   	 				AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 				AS Array Of beneficiario 	OPTIONAL
	WSDATA retorno_criticas		 			AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 			AS Array Of alerta			OPTIONAL
	WSDATA retorno_acessos		 			AS acesso						OPTIONAL
ENDWSSTRUCT

// Recupera senha
WSSTRUCT redefine_senha
	WSDATA beneficiario_nome  					AS String	OPTIONAL
	WSDATA beneficiario_email					AS String	OPTIONAL
	WSDATA senha		   		 					AS String	OPTIONAL
	WSDATA hash		   		 					AS String	OPTIONAL		
ENDWSSTRUCT
WSSTRUCT st_redefine_senha
	WSDATA retorno_status   	 					AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 					AS Array Of redefine_senha 	OPTIONAL
	WSDATA retorno_criticas		 				AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL
ENDWSSTRUCT

// Lista de usuários de acesso vinculado a um cpf
WSSTRUCT usuario_acesso
	WSDATA beneficiario_nome  					AS String	OPTIONAL
	WSDATA beneficiario_empresa					AS String	OPTIONAL
	WSDATA beneficiario_login					AS String	OPTIONAL
	WSDATA beneficiario_matricula				AS String	OPTIONAL		
ENDWSSTRUCT
WSSTRUCT st_usuario_acesso
	WSDATA retorno_status   	 					AS Boolean 					OPTIONAL
	WSDATA retorno_dados		 					AS Array Of usuario_acesso 	OPTIONAL
	WSDATA retorno_criticas		 				AS Array Of mb_critica			OPTIONAL
	WSDATA retorno_alertas		 				AS Array Of alerta			OPTIONAL
ENDWSSTRUCT

CLASS ms_ws_structs

	METHOD New() CONSTRUCTOR

ENDCLASS

//-----------------------------------------------------------------
METHOD New() CLASS ms_ws_structs

Return