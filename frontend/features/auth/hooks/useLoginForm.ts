import {LoginFormValues} from "@/features/auth/schemas/login.schema";
import { UseFormHandleSubmit, UseFormSetError } from 'react-hook-form';
import {useMutation} from "@tanstack/react-query";

const useLoginForm = (
    handleSubmit: UseFormHandleSubmit<LoginFormValues>,
    setError: UseFormSetError<LoginFormValues>
) => {

    const {

    } =useMutation({
        mutationFn: async ({ email, password }: { email: string; password: string }) => {
            return await loginWithPasswordFetcher(email, password, rememberMe);
        },
    })


    return {
        isLoggingIn: isPending,
        isSuccess: isSuccess,
    }
};


export default useLoginForm;