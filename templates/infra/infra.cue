package infra

import corev1 "k8s.io/api/core/v1"

import rbacv1 "k8s.io/api/rbac/v1"

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

_apiCoreV1: metav1.#TypeMeta & {
	apiVersion: "v1"
}

_apiRBACV1: metav1.#TypeMeta & {
	apiVersion: "rbac.authorization.k8s.io/v1"
}

namespaceSpec: [Name=_]: {
	name: *Name | string
	createAdminSA: *false | bool
}

namespace: [Name=_]: corev1.#Namespace & {
	_apiCoreV1
	kind: "Namespace"
	metadata: name: *Name | string
}

serviceAccount: [Name=_]: corev1.#ServiceAccount & {
	_apiCoreV1
	kind: "ServiceAccount"
	metadata: {
		name:      *Name | string
		namespace: Name
	}
}

role: [Name=_]: rbacv1.#Role & {
	_apiRBACV1
	kind: "Role"
	metadata: {
		name:      *Name | string
		namespace: Name
	}
	rules: [{
		apiGroups: ["*"]
		resources: ["*"]
		verbs: ["*"]
	}]
}

roleBinding: [Name=_]: rbacv1.#RoleBinding & {
	_apiRBACV1
	kind: "RoleBinding"
	metadata: {
		name:      *Name | string
		namespace: Name
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     *Name | string
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      *Name | string
		namespace: Name
	}]
}

for k, v in namespaceSpec {
	namespace: "\(k)": metadata: name: v.name
	if v.createAdminSA {
		let saName = "\(v.name)-sa"
		let roleName = "\(v.name)-admin"
		serviceAccount: "\(k)": metadata: name: saName
		role: "\(k)": metadata: name:           roleName
		roleBinding: "\(k)": {
			metadata: name: "\(v.name)-admin-sa"
			roleRef: name:  roleName
			subjects: [{name: saName}]
		}
	}
}
