import {useMutation} from "@tanstack/react-query";
import {loginWithPasswordFetcher} from "@/features/auth/services/loginWithPasswordFetcher";
import {LoginFormValues} from "@/features/auth/schemas/login.schema";


interface useLoginFormProps {
    onSuccess: () => void;
    onError: (error: Error) => void;
}

const useLoginForm = ({onSuccess, onError}: useLoginFormProps) => {
    const {isSuccess, isPending, isError, mutate} = useMutation({
        mutationFn: async ({email, password}: LoginFormValues) => {
            console.log('login mutation called');
            return await loginWithPasswordFetcher(email, password);
        },
        onSuccess: onSuccess,
        onError: onError
    })


    return {
        loginMutation: mutate,
        isLoggingIn: isPending,
        isSuccess: isSuccess,
        isError: isError,
    }
};


export default useLoginForm;