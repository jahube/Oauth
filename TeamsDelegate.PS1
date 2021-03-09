•	for delegation follow the steps in below article to 
enable ACLableSyncedObjectEnabled          >>  for Org AND recipients <<
Configure Exchange to support delegated mailbox permissions in a hybrid deployment | Microsoft Docs

•	after prepare Calendar permissions (MailboxFolderPermission) AND  SendOnBehalf
https://docs.microsoft.com/en-us/microsoftteams/troubleshoot/known-issues/teams-exchange-interaction-issue
•	Last link in very detail

Calendar (MailboxFolderPermission) 

 $Mailbox = "Mailbox @ here"            # modify
$Calendar = "Calendar"                  # else Kalender, Calendrier etc
$Delegate = "Delegated @ USER here"     # modify

Get-MailboxFolderPermission -Identity "$Delegate:\$Calendar" | Format-List
Set-MailboxFolderPermission -Identity "$Delegate:\$Calendar" -User $Delegate -AccessRights Editor

SendOnBehalf Delegate permissions

CROSS premises (onprem /cloud) might still not work as ABOVE calendar permissions might not sync
possibly  if [publicdelegates] is activated in [AAD connect sync extensions] ("delegate writeback" ?
•	onprem > onprem + Cloud > cloud 
     $Mailbox = "Mailbox @ here"                          # modify
  $Delegate = "Delegated @ USER here"                     # modify
Get-Mailbox -Identity  $Mailbox | Format-List *grant*
Set-Mailbox -Identity $Mailbox -Grantsendonbehalfto @{add="$Delegate"}

IF [publicdelegates] is activated in [AAD connect sync extensions] ("delegate writeback"
OR
set remotemailbox onprem AND set-mailbox in cloud 
(but theoretically without [publicdelegates] activated calendar folder would still not be synced)
•	IF [publicdelegate] is activated you will most likely get an Error that the 
double permission (Cloud AND Onprem) is not accepted anymore and synced instead

•	cloud > onprem - not confirmed
[publicdelegates] activated in [AAD connect >> sync extensions] theoretically should sync
then one of the 2 below will give Error "synced / not above to change from  [this side]"

ONPREM
 $Mailbox = "Mailbox @ here"                    # modify
$Delegate = "Delegated @ USER here"             # modify
Get-RemoteMailbox -Identity  $Mailbox | Format-List *grant*
Set-RemoteMailbox -Identity $Mailbox -Grantsendonbehalfto @{add="$Delegate"}
•	CLOUD
 $Mailbox = "Mailbox @ here"                    # modify
$Delegate = "Delegated @ USER here"             # modify
Get-Mailbox -Identity  $Mailbox | Format-List *grant*
Set-Mailbox -Identity $Mailbox -Grantsendonbehalfto @{add="$Delegate"}
•	onprem > cloud - not confirmed
Possibly ? IF [publicdelegates] activated in [AAD connect >> sync extensions] theoretically should sync
ONPREM
 $Mailbox = "Mailbox @ here"                     # modify
$Delegate = "Delegated @ USER here"              # modify
Get-Mailbox -Identity $Mailbox | Format-List *grant*
Set-Mailbox -Identity $Mailbox -Grantsendonbehalfto @{add="$Delegate"}
