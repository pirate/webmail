require ["copy", "envelope", "fileinto", "imap4flags", "include", "mailbox", "variables", "vnd.stalwart.expressions"];

# BEGIN MAIL RULES WATCHER - MANAGED
let "type_prompt" "Classify this message";
let "type_result" "llm_prompt('model-id', type_prompt, 1.0)";
if string :is "${type_result}" "Expenses" {
  fileinto :copy :create "Type/Expenses";
}

if anyof (envelope :is "to" "receipts@example.com", address :is ["X-Original-To", "Envelope-To", "To", "Cc"] "receipts@example.com") {
  addflag "\\Seen";
  fileinto :create "Autosorted/receipts";
  stop;
}

include :personal "migrated-rainloop";
# END MAIL RULES WATCHER - MANAGED
