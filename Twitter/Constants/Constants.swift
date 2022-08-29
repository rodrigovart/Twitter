//
//  Constants.swift
//  Twitter
//
//  Created by Rodrigo Vart on 23/08/22.
//

import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage

public let CHILD_USERS_NAME = "users"
public let CHILD_TWEET_NAME = "tweets"
public let URL_BASE_STORAGE = "gs://twitter-48ddc.appspot.com"

public let DATABASE_REFERENCE = Database.database().reference()
public let STORAGE_REFERENCE = Storage.storage().reference(forURL: URL_BASE_STORAGE).child(User().image_name).rx
