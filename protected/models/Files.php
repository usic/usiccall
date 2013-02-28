<?php

/**
 * This is the model class for table "files".
 *
 * The followings are the available columns in table 'files':
 * @property integer $id
 * @property string $name
 * @property string $real_name
 * @property string $description
 * @property integer $downloads
 * @property string $size
 * @property integer $type
 * @property string $created
 * @property string $status
 * @property string $updated
 * @property integer $author_created
 * @property string $permission
 *
 * The followings are the available model relations:
 * @property Comments[] $comments
 * @property Users[] $users
 * @property Users $authorCreated
 * @property Courses[] $courses
 * @property Tags[] $tags
 * @property Votes $votes
 */
class Files extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Files the static model class
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
		return 'files';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name', 'length', 'max'=>50),
			array('description', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('name, real_name, description, author_created', 'safe', 'on'=>'search'),
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
			'comments' => array(self::HAS_MANY, 'Comments', 'file_id'),
			'users' => array(self::MANY_MANY, 'Users', 'favorites(file_id, user_id)'),
			'authorCreated' => array(self::BELONGS_TO, 'Users', 'author_created'),
			'courses' => array(self::MANY_MANY, 'Courses', 'files_to_courses(file_id, course_id)'),
			'tags' => array(self::MANY_MANY, 'Tags', 'files_to_tags(file_id, tag_id)'),
			'votes' => array(self::HAS_ONE, 'Votes', 'id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'real_name' => 'Real Name',
			'description' => 'Description',
			'downloads' => 'Downloads',
			'size' => 'Size',
			'type' => 'Type',
			'created' => 'Created',
			'status' => 'Status',
			'updated' => 'Updated',
			'author_created' => 'Author Created',
			'permission' => 'Permission',
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

		
		$criteria->compare('name',$this->name,true);
		$criteria->compare('real_name',$this->real_name,true);
		$criteria->compare('description',$this->description,true);
		$criteria->compare('author_created',$this->author_created);
		

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}