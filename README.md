## Task 1 (XML Handling)

In the given code, we used a namespace to specify the context or domain for the elements in the XML document. This helps us accurately locate specific elements using the namespace prefix ota|. An alternative approach could have been to remove the namespaces from the document altogether. This could be done by modifying the XML document and deleting the namespace declarations. However, Removing namespaces from the XML document can lead to naming conflicts and loss of integrity.

## Task 2 (Count array and sort)

This code demonstrates two different approaches, in the 2nd approach I used the tally method introduced in Ruby 2.7. The tally method directly counts the occurrences of each item and returns a hash with the item as the key and its count as the value. Then sort the resulting hash based on count (in descending order) using sort_by. Finally, convert the sorted array of key-value pairs back into a hash using to_h.

## Task 3 (Handle Positions)

I have created a model class here named navigation, and added model callbacks to run before create and destroy lifecycle.

## Task 4 (Base64 to Image)

For this I created a tmp folder which we can assume to act as Rails tmp directory.

## Task 5 (Delete Duplicates) 

I have created a rake task here which is always a better approach when working with database query so that it could be scheduled and reused, assuming that I have a model called user

## Task 6 (Create a secure pdf)

This approach ensures that the necessary tools and dependencies are in place before performing the conversion and provides feedback on the success or failure of the operation. I am first checking if ghostscript is installed on system level if not it exits and gives the error to the user otherwise it uses ghostscript for conversion. checking the ghostscript documentation I wrote the command for conversion to run on system level where -dPDFA=1: This option sets the PDF/A mode to 1, indicating that the output PDF should be PDF/A-1b standard as mentioned in the requirements


## Task 7 (Response check)

Here I am using retry logic which we used in GoMoment as well. I have used a dummy endpoint which returns a random status between 200, 500. The API will keep calling until 10 retries have finished.

## Task 8 (Regex)

I used SecureRandom.alphanumeric instead of rand() for extra characters. While both can generate random characters, SecureRandom is more unpredictable, making our password harder to guess
