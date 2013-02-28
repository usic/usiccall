<?php

/**
 * This is the model class for table "users".
 *
 * The followings are the available columns in table 'users':
 * @property integer $id
 * @property string $login
 * @property string $email
 * @property string $quota
 * @property double $rating
 * @property string $moderator
 * @property string $lastlogin
 * @property integer $faculties_id
 *
 * The followings are the available model relations:
 * @property Comments[] $comments
 * @property Files[] $files
 * @property Files[] $files1
 * @property Faculties $faculties
 * @property Votes[] $votes
 */
class Users extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Users the static model class
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
		return 'users';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('faculties_id', 'numerical', 'integerOnly'=>true),
			array('rating', 'numerical'),
			array('login', 'length', 'max'=>20),
			array('email', 'length', 'max'=>50),
			array('quota', 'length', 'max'=>45),
			array('moderator', 'length', 'max'=>1),
			array('lastlogin', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, login, email, quota, rating, moderator, lastlogin, faculties_id', 'safe', 'on'=>'search'),
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
			'comments' => array(self::HAS_MANY, 'Comments', 'author_created'),
			'files' => array(self::MANY_MANY, 'Files', 'favorites(user_id, file_id)'),
			'files1' => array(self::HAS_MANY, 'Files', 'author_created'),
			'faculties' => array(self::BELONGS_TO, 'Faculties', 'faculties_id'),
			'votes' => array(self::HAS_MANY, 'Votes', 'user_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'login' => 'Login',
			'email' => 'Email',
			'quota' => 'Quota',
			'rating' => 'Rating',
			'moderator' => 'Moderator',
			'lastlogin' => 'Lastlogin',
			'faculties_id' => 'Faculties',
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
		$criteria->compare('login',$this->login,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('quota',$this->quota,true);
		$criteria->compare('rating',$this->rating);
		$criteria->compare('moderator',$this->moderator,true);
		$criteria->compare('lastlogin',$this->lastlogin,true);
		$criteria->compare('faculties_id',$this->faculties_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}