<?php

/**
 * This is the model class for table "tags".
 *
 * The followings are the available columns in table 'tags':
 * @property integer $id
 * @property string $name_en
 * @property string $name_visible
 *
 * The followings are the available model relations:
 * @property Files[] $files
 */
class Tags extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Tags the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'tags';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name_en, name_visible', 'length', 'max'=>45),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name_en, name_visible', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'files' => array(self::MANY_MANY, 'Files', 'files_to_tags(tag_id, file_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name_en' => 'Name En',
			'name_visible' => 'Name Visible',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('name_en',$this->name_en,true);
		$criteria->compare('name_visible',$this->name_visible,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	public function addTags($tags)
	{
		foreach($tags as $name)
		{
			if(!$this->exists('name_visible=:name',array(':name'=>$name)))
			{
				$tag=new Tags;
				$tag->name_visible=$name;
				$tag->save();
			}
		}
	}

	
}