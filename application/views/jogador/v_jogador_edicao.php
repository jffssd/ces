<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<style>
.team-create-edit{
	font-family: helvetica, tahoma;
	font-weight:bold;
	height: 120px; 
	padding:10px;
	margin-top:10px; 

	width:100%;
}

.form-adjust{
	margin-top:10px; 
	margin-bottom:10px;
}

.logo-team-store{
	float:left; 
	height:100px; 
	width:100px; 
	border-radius:10px; 
}

.name-team-store{
	padding-left: 130px; height: 100px; vertical-align: middle;
}
</style>
<div class="input-equipes">
	<div class="col-md-8 offset-md-2">
		<div class="row">
			<div class="page_title team-create-edit">
				<div class="logo-team-store"><img src="<?php echo site_url();?>assets/img/logo-equipes/default-team-logo.png';?>" width="100" height="100"></div>
				<div class="" style="color: #868e89;"><h2 style="font-weight: bold; margin-left:110px; font-size:32px;"><?php echo $title;?></h2><h4><?php echo isset($id) ? $nome : ''; ?></h4></div>
			</div>
		</div>


		<div class="row">

			<?= form_open('jogador/store')  ?>
	
			<input type="hidden" name="id" class="form-control" value="<?php echo $id;?>">

			<div class="form-row">
    			<div class="form-group col-md-4">
      				<label for="nome">Nome</label>
					<span class="erro"><?php echo form_error('nome') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-pencil" aria-hidden="true"></i>
						</div>
						<input type="text" class="form-control" name="nome" id="nome" placeholder="Nome" value="<?php echo $nome;?>" autofocus="true">
					</div>
				</div>
    			<div class="form-group col-md-4">
      				<label for="nick">Nick</label><?php echo form_error('nick') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-quote-left" aria-hidden="true"></i>
						</div>
						<input type="text" class="form-control" name="nick" id="nick" placeholder="Nick" value="<?php echo $nick;?>" autofocus="true" required>
					</div>
				</div>
				<div class="form-group col-md-4">
      				<label for="sobrenome">Sobrenome</label>
					<span class="erro"><?php echo form_error('sobrenome') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-pencil" aria-hidden="true"></i>
						</div>
						<input type="text" class="form-control" name="sobrenome" id="sobrenome" placeholder="Sobrenome" value="<?php echo $sobrenome;?>" autofocus="true">
					</div>
				</div>
 			</div>

			 <div class="form-row">
    			<div class="form-group col-md-12">
      				<label for="genero">Gênero</label><?php echo form_error('genero') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-quote-left" aria-hidden="true"></i>
						</div>
						<input type="text" class="form-control" name="genero" id="genero" placeholder="Genero" value="<?php echo $genero;?>" autofocus="true" required>
					</div>
				</div>
 			</div>

			<div class="form-row">
				<div class="form-group col-md-12">
					<label for="pais">País</label><span class="pais"><?php echo form_error('pais') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-flag" aria-hidden="true"></i>
						</div>
						<select name="pais" id="pais" class="form-control">
							<?php
								foreach($paises -> result() as $paises_s){
									if ($paises_s->id == $pais){ 
										echo '<option value="'.$paises_s->id.'" selected>'.$paises_s->nome.'</option>';
									}else{ 
										echo '<option value="'.$paises_s->id.'">'.$paises_s->nome.'</option>';
									}
								}
								?>
						</select>
					</div>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group col-md-12">
					<label for="funcao">Funcao</label><span class="funcao"><?php echo form_error('funcao') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-flag" aria-hidden="true"></i>
						</div>
						<select name="funcao" id="funcao" class="form-control" required>
						<option selected="true" disabled="disabled">Escolha a função...</option>    
							<?php
								foreach($funcoes -> result() as $funcao_f){
									if($funcao_f->id == $funcao){
										echo '<option value="'.$funcao_f->id.'" selected>'.$funcao_f->nome.'</option>';
									}else{
										echo '<option value="'.$funcao_f->id.'">'.$funcao_f->nome.'</option>';
									}
								}
							?>
						</select>
					</div>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group col-md-12">
					<label for="personalidade">Personalidade</label><span class="personalidade"><?php echo form_error('personalidade') ?  : ''; ?></span>
					<div class="input-group mb-2">
						<div class="input-group-addon"><i class="fa fa-flag" aria-hidden="true"></i>
						</div>
						<select name="personalidade" id="personalidade" class="form-control" required>
						<option selected="true" disabled="disabled">Escolha a personalidade...</option>    
							<?php
								foreach($personalidades -> result() as $personalidade_p){
									if($personalidade_p->id == $personalidade){
										echo '<option value="'.$personalidade_p->id.'" selected>'.$personalidade_p->nome.'</option>';
									}else{
										echo '<option value="'.$personalidade_p->id.'">'.$personalidade_p->nome.'</option>';
									}
								}
							?>
						</select>
					</div>
				</div>
			</div>

			<div class="form-row">
				<div class="col">
					<div class="form-group text-left" style="margin-top:30px; float:right;">
						<?= anchor('equipe', 'Voltar', 'class="btn btn-secondary"') ?>
					</div>
				</div>
                <div class="col">
					<div class="form-group text-left" style="margin-top:30px;">
						<input type="submit" value="Salvar" class="btn btn-success" />
					</div>
				</div>
			</div>

			<?= form_close(); ?>
		</div>
	</div>	
</div>
