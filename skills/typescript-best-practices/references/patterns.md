# TypeScript patterns

Use only the sections needed for the current type-design decision. Match the repository's supported TypeScript version and established conventions.

## Parse unknown input into a new value

A type assertion does not validate data. Check every required field and construct the trusted value from the narrowed fields.

```ts
type User = {
  id: string;
  displayName: string;
};

function parseUser(value: unknown): User {
  if (typeof value !== "object" || value === null) {
    throw new TypeError("expected a user object");
  }
  if (!("id" in value) || typeof value.id !== "string") {
    throw new TypeError("expected a string user id");
  }
  if (!("displayName" in value) || typeof value.displayName !== "string") {
    throw new TypeError("expected a string display name");
  }

  return { id: value.id, displayName: value.displayName };
}
```

Use the project's schema library when one already owns this job. Avoid hand-written guards for large or recursive payloads.

## Model a closed state machine

Use a shared literal discriminant when the variants are closed and contradictory combinations would otherwise compile.

```ts
type DiffState =
  | { kind: "loading" }
  | { kind: "ready"; diff: GitDiff }
  | { kind: "error"; error: Error };

function assertNever(value: never): never {
  throw new Error(`unhandled variant: ${String(value)}`);
}

function render(state: DiffState): View {
  switch (state.kind) {
    case "loading":
      return renderSpinner();
    case "ready":
      return renderDiff(state.diff);
    case "error":
      return renderError(state.error);
    default:
      return assertNever(state);
  }
}
```

For data from a versioned external protocol, preserve an unknown-variant path when forward compatibility requires one.

## Strengthen only at the invariant owner

Use a readonly non-empty tuple when emptiness is invalid for a particular operation, not as a default replacement for every array.

```ts
type NonEmpty<T> = readonly [T, ...T[]];

function isNonEmpty<T>(values: readonly T[]): values is NonEmpty<T> {
  return values.length > 0;
}

function first<T>(values: NonEmpty<T>): T {
  return values[0];
}
```

If empty is meaningful, prefer `T | undefined` or another explicit result instead of strengthening the input.

## Brand a validated primitive locally

Brands distinguish primitives statically; the constructor supplies the runtime evidence. Match an existing repository convention when one exists.

```ts
declare const userIdBrand: unique symbol;
type UserId = string & { readonly [userIdBrand]: "UserId" };

function parseUserId(value: string): UserId {
  if (!isUuid(value)) throw new TypeError("invalid user id");
  return value as UserId;
}
```

Keep the assertion inside the constructor. A brand does not prevent forged values or validate deserialized data by itself.

## Check conformance without replacing inference

`satisfies` verifies compatibility while retaining the expression's inferred type.

```ts
type RouteName = "home" | "settings";

const routes = {
  home: "/",
  settings: "/settings",
} satisfies Record<RouteName, `/${string}`>;
```

It does not freeze the value. Add `as const` when readonly literal inference is intended, but remember that `as const` does not freeze the runtime object either.

## Audit assertions by evidence

For each `as T` or `!`, ask what runtime fact makes it true and where that fact is established.

- Replace boundary assertions with parsing or validation.
- Replace optional-property bags with a discriminant when states are closed.
- Replace non-null assertions with a total return type or a stronger owner-level input.
- Keep a local assertion when an external API guarantee or a checked constructor establishes the fact and TypeScript cannot carry it.
- Treat `as const` as literal and readonly inference, not as proof that external data is valid.

## Derive only across shared ownership

Utility types prevent drift when the source and derived view change together.

```ts
type SaveInput = Parameters<typeof saveUser>[0];
type SavedUser = Awaited<ReturnType<typeof saveUser>>;
type UserSummary = Pick<SavedUser, "id" | "displayName">;
```

At a package, domain, persistence, or public-API boundary, an explicit named type can be the safer contract. Do not couple independent layers solely to avoid a small declaration.

## Compiler strictness

Prefer `strict` for new projects. Consider `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, and `noImplicitOverride` when their guarantees match the codebase. Enabling them in an existing project is a migration with blast radius, not a local cleanup; inspect the errors, stage the rollout, and validate runtime behavior.
