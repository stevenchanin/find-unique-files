# Approach
Parse options
    - verbose (true)
    - debug (false)
    - move (false)
    - source
    - destination

Initialize a FileCollection
    - Hash
    - key (name) - [FileRecords]

    - add(FileRecord)
    - find(FileRecord)
        - hash name
        - search array for equal other records

FileRecord
    initialize(path)
        - path, name, size, create date, modified date
    equal
        - matches on name, size, create date, modified date
    destroy - delete file at path

CollectionManager
    initialize(settings, source_collection, destination_collection)
        not debug:
            move: create "destination/_unique"
    handle_duplicate(item, match)
        verbose: "File #{item} == #{match}. Delete"
        not debug: item.destroy
    handle_unique
        verbose: 
            "File #{item} is Unique."
            move: "Moving"
        not debug: 
            move:
                copy file to "destination/_unique"
                destination_collection.add(item)

DirectoryWalker
    initialize(options)

Recursively descend through destination.
For each file:
    - create a FileRecord (file)
    - add each FileRecord into FileCollection (destination)

Recursively descend through source
For each file:
    - create a FileRecord (item)
    - find in destination FileCollection (match)
        + exists: CollectionManager.handle_duplicate(item, match)
        + not exists: CollectionManager.handle_unique(item, match)
