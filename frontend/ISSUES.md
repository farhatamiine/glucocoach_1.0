# Frontend Development Issues Roadmap

This document outlines the core frontend tasks needed to make GlucoCoach functional.
**Assignee for all tasks**: @farhatamiine

---

## 1. Issue: Setup TanStack React Query & Devtools
**Tags**: `infrastructure`, `frontend`, `priority-high`

### Description
Initialize the data-fetching layer to manage server state effectively.

### Tasks
- [ ] Create `frontend/lib/query-client.ts` to export a configured `QueryClient`.
- [ ] Create `frontend/components/providers/query-provider.tsx` (Client Component).
- [ ] Wrap the root `layout.tsx` with the `QueryProvider`.
- [ ] Ensure `ReactQueryDevtools` is enabled in development mode.
- [ ] Set default `staleTime` (e.g., 1 minute) to avoid redundant fetches.

---

## 2. Issue: Authentication State Management & API Client
**Tags**: `auth`, `logic`, `frontend`, `priority-high`

### Description
Implement global state for the authenticated user and a centralized Axios instance that handles security headers.

### Tasks
- [ ] Create `frontend/store/useAuthStore.ts` using Zustand.
- [ ] Implement `accessToken`, `refreshToken`, and `user` state with local storage persistence.
- [ ] Create `frontend/lib/api-client.ts` using Axios.
- [ ] Add Request Interceptor: Automatically attach `Authorization: Bearer <token>` if available.
- [ ] Add Response Interceptor: Handle `401 Unauthorized` by attempting to refresh the token via `/api/auth/refresh`.
- [ ] Implement logout logic (clear store and redirect).

---

## 3. Issue: Implement Login and Register Functionality
**Tags**: `auth`, `ui`, `frontend`, `priority-medium`

### Description
Connect the existing UI shells in `(auth)` to the backend API.

### Tasks
- [ ] Define Zod validation schemas for Login and Registration.
- [ ] Integrate `react-hook-form` into `login/page.tsx` and `register/page.tsx`.
- [ ] Implement React Query mutations for the login and register endpoints.
- [ ] On success: Save tokens to the store and redirect to `/`.
- [ ] Integrate `sonner` toasts for error messages (e.g., "Invalid credentials").

---

## 4. Issue: Add Glucose Records & History Integration
**Tags**: `feat`, `data`, `frontend`, `priority-high`

### Description
Allow users to manually add glucose readings to the database and view their history.

### Tasks
- [ ] Create `frontend/hooks/useGlucose.ts` containing `useGlucoseRecords` (query) and `useAddGlucose` (mutation).
- [ ] Build an "Add Reading" dialog component in the `glucose-analytics` page.
- [ ] Connect the form to `POST /api/glucose`.
- [ ] Implement optimistic updates: Immediately show the new reading in the list while the request is pending.
- [ ] Ensure the main dashboard charts invalidate/refetch after adding a record.

---

## 5. Issue: User Profile & Dynamic Header
**Tags**: `feat`, `ui`, `frontend`, `priority-low`

### Description
Ensure the UI reflects the logged-in user's information.

### Tasks
- [ ] Implement `useProfile` hook to fetch `GET /api/users/me`.
- [ ] Update `SiteHeader` to display the actual user's name if available.
- [ ] Update `UserDropdown` to show the user's email and handle the "Signout" click.
- [ ] (Optional) Add a basic settings page to update user metadata.
