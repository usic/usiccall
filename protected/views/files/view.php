<?php
/* @var $this FilesController */
/* @var $model Files */




?>

<h1>View Files #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'name',
		'real_name',
		'description',
		'downloads',
		'size',
		'type',
		'created',
		'status',
		'updated',
		'author_created',
		'permission',
	),
)); ?>
