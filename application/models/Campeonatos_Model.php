<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Campeonatos_Model extends CI_Model {

	public function get_campeonatos($id = null){
		if ($id) {
			$this->db->where('id', $id);
		}
		$this->db->order_by("id", 'desc');
		return $this->db->get('campeonato');
	}

	public function get_campeonato_info($id){
			
			$this->db->select('campeonato.id, campeonato.nome, campeonato.regiao_id, campeonato.ano, campeonato.temporada, campeonato.status, campeonato.logo, campeonato_formato.numDeTimes as fg_numDeTimes, campeonato_formato.numDeDivisoes, campeonato_formato.qtd_jogos_serie as fg_qtd_jogos_serie, campeonato_playoffs_tipos.noDeTimes as pl_numDeTimes, campeonato_playoffs_tipos.qtd_jogos_serie as pl_qtd_jogos_serie, campeonato_playoffs_tipos.qtd_jogos_serie_final as pl_qtd_jogos_serie_final, regiao.sigla as regiao_sigla');

			$this->db->join('campeonato_formato', 'campeonato.camp_formato_id = campeonato_formato.id');
			$this->db->join('campeonato_playoffs_tipos', 'campeonato.playoffs_id = campeonato_playoffs_tipos.id');
			$this->db->join('regiao', 'campeonato.regiao_id = regiao.id');

			$this->db->where('campeonato.id', $id);
		
			return $this->db->get('campeonato');
	}

	public function get_tabela_campeonato($id){

		$sql = 'CALL proc_get_tabela_campeonato('.$id.')';

		$result = $this->db->query($sql);

		$result->next_result(); 
		$result->free_result(); 

		return $result->result_array();
	}

	public function get_series_campeonato($id){

		$sql = 'CALL proc_get_series_campeonato('.$id.')';

		$result = $this->db->query($sql);

		return $result->result_array();
	}
}