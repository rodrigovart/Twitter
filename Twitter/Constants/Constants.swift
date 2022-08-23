//
//  Constants.swift
//  Twitter
//
//  Created by Rodrigo Vart on 23/08/22.
//

import FirebaseDatabase
import FirebaseStorage

public let CHILD_USERS_NAME = "users"
public let CHILD_IMAGES_NAME = "profile_images"

public let DATABASE_REFERENCE = Database.database().reference()
public let DATABASE_USERS_REFERENCE = DATABASE_REFERENCE.child(CHILD_USERS_NAME)
public let STORAGE_REFERENCE = Storage.storage().reference()
public let STORAGE_PROFILE_IMAGES_REFERENCE = STORAGE_REFERENCE.child(CHILD_IMAGES_NAME)
