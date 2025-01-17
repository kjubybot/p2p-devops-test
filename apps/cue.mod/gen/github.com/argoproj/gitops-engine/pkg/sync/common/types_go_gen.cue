// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/argoproj/gitops-engine/pkg/sync/common

package common

import "github.com/argoproj/gitops-engine/pkg/utils/kube"

// AnnotationSyncOptions is a comma-separated list of options for syncing
#AnnotationSyncOptions: "argocd.argoproj.io/sync-options"

// AnnotationSyncWave indicates which wave of the sync the resource or hook should be in
#AnnotationSyncWave: "argocd.argoproj.io/sync-wave"

// AnnotationKeyHook contains the hook type of a resource
#AnnotationKeyHook: "argocd.argoproj.io/hook"

// AnnotationKeyHookDeletePolicy is the policy of deleting a hook
#AnnotationKeyHookDeletePolicy: "argocd.argoproj.io/hook-delete-policy"

// Sync option that disables dry run in resource is missing in the cluster
#SyncOptionSkipDryRunOnMissingResource: "SkipDryRunOnMissingResource=true"

// Sync option that disables resource pruning
#SyncOptionDisablePrune: "Prune=false"

// Sync option that disables resource validation
#SyncOptionsDisableValidation: "Validate=false"

// Sync option that enables pruneLast
#SyncOptionPruneLast: "PruneLast=true"

// Sync option that enables use of replace or create command instead of apply
#SyncOptionReplace: "Replace=true"

// Sync option that enables use of --server-side flag instead of client-side
#SyncOptionServerSideApply: "ServerSideApply=true"

// Sync option that disables resource deletion
#SyncOptionDisableDeletion: "Delete=false"

// Sync option that sync only out of sync resources
#SyncOptionApplyOutOfSyncOnly: "ApplyOutOfSyncOnly=true"

#SyncPhase: string

#SyncPhasePreSync:  "PreSync"
#SyncPhaseSync:     "Sync"
#SyncPhasePostSync: "PostSync"
#SyncPhaseSyncFail: "SyncFail"

#OperationPhase: string // #enumOperationPhase

#enumOperationPhase:
	#OperationRunning |
	#OperationTerminating |
	#OperationFailed |
	#OperationError |
	#OperationSucceeded

#OperationRunning:     #OperationPhase & "Running"
#OperationTerminating: #OperationPhase & "Terminating"
#OperationFailed:      #OperationPhase & "Failed"
#OperationError:       #OperationPhase & "Error"
#OperationSucceeded:   #OperationPhase & "Succeeded"

#ResultCode: string // #enumResultCode

#enumResultCode:
	#ResultCodeSynced |
	#ResultCodeSyncFailed |
	#ResultCodePruned |
	#ResultCodePruneSkipped

#ResultCodeSynced:       #ResultCode & "Synced"
#ResultCodeSyncFailed:   #ResultCode & "SyncFailed"
#ResultCodePruned:       #ResultCode & "Pruned"
#ResultCodePruneSkipped: #ResultCode & "PruneSkipped"

#HookType: string // #enumHookType

#enumHookType:
	#HookTypePreSync |
	#HookTypeSync |
	#HookTypePostSync |
	#HookTypeSkip |
	#HookTypeSyncFail

#HookTypePreSync:  #HookType & "PreSync"
#HookTypeSync:     #HookType & "Sync"
#HookTypePostSync: #HookType & "PostSync"
#HookTypeSkip:     #HookType & "Skip"
#HookTypeSyncFail: #HookType & "SyncFail"

#HookDeletePolicy: string // #enumHookDeletePolicy

#enumHookDeletePolicy:
	#HookDeletePolicyHookSucceeded |
	#HookDeletePolicyHookFailed |
	#HookDeletePolicyBeforeHookCreation

#HookDeletePolicyHookSucceeded:      #HookDeletePolicy & "HookSucceeded"
#HookDeletePolicyHookFailed:         #HookDeletePolicy & "HookFailed"
#HookDeletePolicyBeforeHookCreation: #HookDeletePolicy & "BeforeHookCreation"

#ResourceSyncResult: {
	// holds associated resource key
	ResourceKey: kube.#ResourceKey

	// holds resource version
	Version: string

	// holds the execution order
	Order: int

	// result code
	Status: #ResultCode

	// message for the last sync OR operation
	Message: string

	// the type of the hook, empty for non-hook resources
	HookType: #HookType

	// the state of any operation associated with this resource OR hook
	// note: can contain values for non-hook resources
	HookPhase: #OperationPhase

	// indicates the particular phase of the sync that this is for
	SyncPhase: #SyncPhase
}
