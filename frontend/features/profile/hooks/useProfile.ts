import {useMutation, useQuery, useQueryClient} from "@tanstack/react-query";
import {
    changePassword,
    getProfile,
    getUser,
    saveProfile,
    updateUser,
} from "@/features/profile/services/profileService";
import type {AccountFormValues} from "@/features/profile/schemas/account.schema";
import type {ProfileFormValues} from "@/features/profile/schemas/profile.schema";
import type {PasswordFormValues} from "@/features/profile/schemas/password.schema";

const USER_KEY = ["user", "me"] as const;
const PROFILE_KEY = ["profile"] as const;

export function useUser() {
    return useQuery({queryKey: USER_KEY, queryFn: getUser, staleTime: 60_000});
}

export function useDiabetesProfile() {
    return useQuery({queryKey: PROFILE_KEY, queryFn: getProfile, staleTime: 60_000});
}

export function useUpdateUser() {
    const qc = useQueryClient();
    return useMutation({
        mutationFn: (values: AccountFormValues) => updateUser(values),
        onSuccess: () => qc.invalidateQueries({queryKey: USER_KEY}),
    });
}

export function useSaveProfile(exists: boolean) {
    const qc = useQueryClient();
    return useMutation({
        mutationFn: (values: ProfileFormValues) => saveProfile(values, exists),
        onSuccess: () => qc.invalidateQueries({queryKey: PROFILE_KEY}),
    });
}

export function useChangePassword() {
    return useMutation({
        mutationFn: (values: PasswordFormValues) => changePassword(values),
    });
}
